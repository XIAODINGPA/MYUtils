//
//  HomeViewController.m
//  MYUtils
//
//  Created by sunjinshuai on 2017/8/8.
//  Copyright © 2017年 com.51fanxing. All rights reserved.
//

#import "HomeViewController.h"
#import "MYShowTextViewController.h"
#import "MYIconFontViewController.h"
#import "MYImageCornerRadiusViewController.h"
#import "MYBannerCycleViewController.h"
#import "MYPagerViewController.h"
#import "MYCustomNavigationBarViewController.h"
#import "MYWebViewController.h"
#import "MYKeyboardViewController.h"
#import "MYCountDownViewController.h"
#import "MYAMViralSwitchViewController.h"
#import "MYTextFieldViewController.h"
#import "FXSliderViewController.h"
#import "MWPhotoBrowserDemo.h"

@interface HomeViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataSource;

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"UIKitDemo";
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.dataSource addObject:@"UILabel设置行间距、指定显示行数-MYShowTextViewController"];
    [self.dataSource addObject:@"iconfont实战-MYIconFontViewController"];
    [self.dataSource addObject:@"imageView设置圆角-MYImageCornerRadiusViewController"];
    [self.dataSource addObject:@"*轮播图-MYBannerCycleViewController"];
    [self.dataSource addObject:@"*TYPagerController-MYBannerCycleViewController"];
    [self.dataSource addObject:@"*照片浏览器-MWPhotoBrowserDemo"];
    [self.dataSource addObject:@"*自定义UISlider-FXSliderViewController"];
    [self.dataSource addObject:@"*自定义UITextField-MYTextFieldViewController"];
    [self.dataSource addObject:@"*自定义UISwitch-MYAMViralSwitchViewController"];
    [self.dataSource addObject:@"*倒计时演练-MYCountDownViewController"];
    [self.dataSource addObject:@"*keyboard-MYKeyboardViewController"];
    [self.dataSource addObject:@"*WebView实战-MYWebViewController"];
    [self.dataSource addObject:@"*自定义导航条-MYCustomNavigationBarViewController"];
   
    [self.view addSubview:self.tableView];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.dataSource.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 50.0f;
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    if (section == 0) {
        return 0.01f;
    }
    return 10.00f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
    return 0.01f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        
    }
    cell.textLabel.text = self.dataSource[indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *title = [self.dataSource objectAtIndex:indexPath.row];
    NSString *className = [[title componentsSeparatedByString:@"-"] lastObject];
    
    UIViewController *viewController = [[NSClassFromString(className) alloc] init];
    viewController.title = [[title componentsSeparatedByString:@"-"] firstObject];
    
    [self.navigationController pushViewController:viewController animated:YES];
}

- (NSMutableArray *)dataSource {
    
    if (!_dataSource) {
        _dataSource = [NSMutableArray array];
    }
    return _dataSource;
}


- (UITableView *)tableView {
    
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.dataSource = self;
        [self.view addSubview:_tableView];
    }
    return _tableView;
}

@end
