//
//  MYVerticalWaterfallFlowLayout.m
//  MYUtils
//
//  Created by sunjinshuai on 2017/12/29.
//  Copyright © 2017年 com.51fanxing. All rights reserved.
//

#import "MYVerticalWaterfallFlowLayout.h"

static const NSInteger _Columns_ = 3;
static const CGFloat _XMargin_ = 10;
static const CGFloat _YMargin_ = 10;
static const UIEdgeInsets _EdgeInsets_ = {20, 10, 10, 10};

@interface MYVerticalWaterfallFlowLayout()

/** 所有的cell的attrbts */
@property (nonatomic, strong) NSMutableArray<UICollectionViewLayoutAttributes *> *attributes;

/** 每一列的最后的高度 */
@property (nonatomic, strong) NSMutableArray *columnsHeightArray;

@end

@implementation MYVerticalWaterfallFlowLayout

- (instancetype)initWithDelegate:(id<MYVerticalWaterfallFlowLayoutDelegate>)delegate {
    if (self = [super init]) {
        
    }
    return self;
}

+ (instancetype)flowLayoutWithDelegate:(id<MYVerticalWaterfallFlowLayoutDelegate>)delegate {
    return [[self alloc] initWithDelegate:delegate];
}

/**
 *  刷新布局的时候回重新调用
 */
- (void)prepareLayout {
    [super prepareLayout];
    
    // 如果重新刷新就需要移除之前存储的高度
    [self.columnsHeightArray removeAllObjects];
    
    // 复赋值以顶部的高度, 并且根据列数
    for (NSInteger i = 0; i < self.columns; i++) {
        
        [self.columnsHeightArray addObject:@(self.edgeInsets.top)];
    }
    
    // 移除以前计算的cells的attrbs
    [self.attributes removeAllObjects];
    
    // 并且重新计算, 每个cell对应的atrbs, 保存到数组
    for (NSInteger i = 0; i < [self.collectionView numberOfItemsInSection:0]; i++) {
        [self.attributes addObject:[self layoutAttributesForItemAtIndexPath:[NSIndexPath indexPathForItem:i inSection:0]]];
    }
}


/**
 *在这里边所处每个cell对应的位置和大小
 */
- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewLayoutAttributes *atrbs = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    
    CGFloat w = 1.0 * (self.collectionView.frame.size.width - self.edgeInsets.left - self.edgeInsets.right - self.xMargin * (self.columns - 1)) / self.columns;
    
    w = floorf(w);
    
    // 高度由外界决定, 外界必须实现这个方法
    CGFloat h = [self.delegate waterflowLayout:self collectionView:self.collectionView heightForItemAtIndexPath:indexPath itemWidth:w];
    
    // 拿到最后的高度最小的那一列, 假设第0列最小
    NSInteger indexCol = 0;
    CGFloat minColH = [self.columnsHeightArray[indexCol] doubleValue];
    
    for (NSInteger i = 1; i < self.columnsHeightArray.count; i++) {
        CGFloat colH = [self.columnsHeightArray[i] doubleValue];
        if (minColH > colH) {
            minColH = colH;
            indexCol = i;
        }
    }
    
    CGFloat x = self.edgeInsets.left + (self.xMargin + w) * indexCol;
    
    CGFloat y = minColH + [self yMarginAtIndexPath:indexPath];
    
    // 是第一行
    if (minColH == self.edgeInsets.top) {
        y = self.edgeInsets.top;
    }
    
    // 赋值frame
    atrbs.frame = CGRectMake(x, y, w, h);
    
    // 覆盖添加完后那一列;的最新高度
    self.columnsHeightArray[indexCol] = @(CGRectGetMaxY(atrbs.frame));
    
    return atrbs;
}

- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect {
    return self.attributes;
}

- (CGSize)collectionViewContentSize {
    CGFloat maxColH = [self.columnsHeightArray.firstObject doubleValue];
    
    for (NSInteger i = 1; i < self.columnsHeightArray.count; i++) {
        CGFloat colH = [self.columnsHeightArray[i] doubleValue];
        if (maxColH < colH) {
            maxColH = colH;
        }
    }
    
    return CGSizeMake(self.collectionView.frame.size.width, maxColH + self.edgeInsets.bottom);
}

- (NSInteger)columns {
    if ([self.delegate respondsToSelector:@selector(waterflowLayout:columnsInCollectionView:)]) {
        return [self.delegate waterflowLayout:self columnsInCollectionView:self.collectionView];
    } else {
        return _Columns_;
    }
}

- (CGFloat)xMargin {
    if ([self.delegate respondsToSelector:@selector(waterflowLayout:columnsMarginInCollectionView:)]) {
        return [self.delegate waterflowLayout:self columnsMarginInCollectionView:self.collectionView];
    } else {
        return _XMargin_;
    }
}

- (CGFloat)yMarginAtIndexPath:(NSIndexPath *)indexPath {
    if ([self.delegate respondsToSelector:@selector(waterflowLayout:collectionView:linesMarginForItemAtIndexPath:)]) {
        return [self.delegate waterflowLayout:self collectionView:self.collectionView linesMarginForItemAtIndexPath:indexPath];
    } else {
        return _YMargin_;
    }
}

- (UIEdgeInsets)edgeInsets {
    if ([self.delegate respondsToSelector:@selector(waterflowLayout:edgeInsetsInCollectionView:)]) {
        return [self.delegate waterflowLayout:self edgeInsetsInCollectionView:self.collectionView];
    } else {
        return _EdgeInsets_;
    }
}

- (id<MYVerticalWaterfallFlowLayoutDelegate>)delegate {
    return (id<MYVerticalWaterfallFlowLayoutDelegate>)self.collectionView.dataSource;
}

- (NSMutableArray *)attributes {
    if(!_attributes) {
        _attributes = [NSMutableArray array];
    }
    return _attributes;
}

- (NSMutableArray *)columnsHeightArray {
    if (!_columnsHeightArray) {
        _columnsHeightArray = [NSMutableArray array];
    }
    return _columnsHeightArray;
}

@end
