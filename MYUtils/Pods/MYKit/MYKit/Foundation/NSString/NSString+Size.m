//
//  NSString+Size.m
//  MYKitDemo
//
//  Created by sunjinshuai on 2017/9/7.
//  Copyright © 2017年 com.51fanxing. All rights reserved.
//

#import "NSString+Size.h"

@implementation NSString (Size)

- (CGSize)textSizeWithFont:(UIFont *)font {
    
    CGSize textSize = [self sizeWithAttributes:@{NSFontAttributeName:font}];
    textSize = CGSizeMake((int)ceil(textSize.width), (int)ceil(textSize.height));
    return textSize;
}

/**
 根据字体、行数、行间距和constrainedWidth计算文本占据的size
 **/
- (CGSize)textSizeWithFont:(UIFont *)font
             numberOfLines:(NSInteger)numberOfLines
               lineSpacing:(CGFloat)lineSpacing
          constrainedWidth:(CGFloat)constrainedWidth
          isLimitedToLines:(BOOL * _Nonnull)isLimitedToLines {
    
    if (self.length == 0) {
        return CGSizeZero;
    }
    CGFloat oneLineHeight = font.lineHeight;
    CGSize textSize = [self boundingRectWithSize:CGSizeMake(constrainedWidth, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font} context:nil].size;
    
    CGFloat rows = textSize.height / oneLineHeight;
    CGFloat realHeight = oneLineHeight;
    // 0 不限制行数
    if (numberOfLines == 0) {
        if (rows >= 1) {
            realHeight = (rows * oneLineHeight) + (rows - 1) * lineSpacing;
        }
    }else{
        if (rows > numberOfLines) {
            rows = numberOfLines;
            if (isLimitedToLines) {
                *isLimitedToLines = YES;  //被限制
            }
        }
        realHeight = (rows * oneLineHeight) + (rows - 1) * lineSpacing;
    }
    
    return CGSizeMake(ceil(constrainedWidth),ceil(realHeight));
}

- (CGSize)sizeForFont:(UIFont *)font size:(CGSize)size mode:(NSLineBreakMode)lineBreakMode {
    CGSize result;
    if (!font) font = [UIFont systemFontOfSize:12];
    if ([self respondsToSelector:@selector(boundingRectWithSize:options:attributes:context:)]) {
        NSMutableDictionary *attr = [NSMutableDictionary new];
        attr[NSFontAttributeName] = font;
        if (lineBreakMode != NSLineBreakByWordWrapping) {
            NSMutableParagraphStyle *paragraphStyle = [NSMutableParagraphStyle new];
            paragraphStyle.lineBreakMode = lineBreakMode;
            attr[NSParagraphStyleAttributeName] = paragraphStyle;
        }
        CGRect rect = [self boundingRectWithSize:size
                                         options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                      attributes:attr context:nil];
        result = rect.size;
    } else {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
        result = [self sizeWithFont:font constrainedToSize:size lineBreakMode:lineBreakMode];
#pragma clang diagnostic pop
    }
    return result;
}

- (CGFloat)widthForFont:(UIFont *)font {
    CGSize size = [self sizeForFont:font size:CGSizeMake(HUGE, HUGE) mode:NSLineBreakByWordWrapping];
    return size.width;
}

- (CGFloat)heightForFont:(UIFont *)font width:(CGFloat)width {
    CGSize size = [self sizeForFont:font size:CGSizeMake(width, HUGE) mode:NSLineBreakByWordWrapping];
    return size.height;
}

- (CGSize)sizeWithMaxWidth:(CGFloat)maxWidth addributes:(NSDictionary *)attributes
{
    CGSize maxSize = CGSizeMake(maxWidth, MAXFLOAT);
    return [self boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size;
}

- (CGSize)sizeWithMaxWidth:(CGFloat)maxWidth font:(UIFont *)font
{
    NSMutableDictionary *attributes = [NSMutableDictionary dictionary];
    attributes[NSFontAttributeName] = font;
    return [self sizeWithMaxWidth:maxWidth addributes:attributes];
}

- (CGSize)sizeWithMaxWidth:(CGFloat)maxWidth font:(UIFont *)font lineSpace:(CGFloat)lineSpace
{
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:lineSpace];
    return [self sizeWithMaxWidth:maxWidth addributes:@{NSParagraphStyleAttributeName:paragraphStyle,NSFontAttributeName:font}];
}

- (CGSize)mySizeWithFont:(UIFont *)font maxSize:(CGSize)size lineBreakMode:(NSLineBreakMode)mode
{
    CGSize realSize = CGSizeZero;
    CGRect textRect = [self boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font} context:nil];
    realSize = textRect.size;
    realSize.width = ceilf(realSize.width);
    realSize.height = ceilf(realSize.height);
    return realSize;
}

- (CGSize)mySizeWithFont:(UIFont *)font
{
    CGSize resultSize = [self mySizeWithFont:font constrainedToSize:CGSizeMake(MAXFLOAT, font.lineHeight)];
    return resultSize;
}

- (CGSize)mySizeWithFont:(UIFont *)font constrainedToSize:(CGSize)size
{
    CGSize resultSize = [self mySizeWithFont:font constrainedToSize:size lineBreakMode:NSLineBreakByWordWrapping];
    return resultSize;
}

- (CGSize)mySizeWithFont:(UIFont *)font constrainedToSize:(CGSize)size lineBreakMode:(NSLineBreakMode)lineBreakMode
{
    CGSize resultSize = [self mySizeWithFont:font maxSize:size lineBreakMode:lineBreakMode];
    return resultSize;
}

- (CGSize)sizeWithFont:(UIFont *)font maxSize:(CGSize)size lineBreakMode:(NSLineBreakMode)mode
{
    CGSize realSize = CGSizeZero;
    CGRect textRect = [self boundingRectWithSize:size
                                         options:NSStringDrawingUsesLineFragmentOrigin
                                      attributes:@{
                                                   NSFontAttributeName:font
                                                   }
                                         context:nil];
    realSize = textRect.size;
    realSize.width = ceilf(realSize.width);
    realSize.height = ceilf(realSize.height);
    return realSize;
}

@end
