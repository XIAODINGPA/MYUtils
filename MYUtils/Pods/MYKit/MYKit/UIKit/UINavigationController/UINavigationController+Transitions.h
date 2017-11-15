//
//  UINavigationController+Transitions.h
//  MYUtils
//
//  Created by sunjinshuai on 2017/8/28.
//  Copyright © 2017年 com.51fanxing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UINavigationController (Transitions)

- (void)pushViewController:(UIViewController *)controller
                transition:(UIViewAnimationTransition)transition;

- (UIViewController *)popViewControllerWithTransition:(UIViewAnimationTransition)transition;

@end

