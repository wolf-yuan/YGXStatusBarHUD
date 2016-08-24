//
//  YGXStatusBarHUD.h
//  状态栏指示器01
//
//  Created by wolf －yuan on 16/8/19.
//  Copyright © 2016年 com.yuan. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <UIKit/UIKit.h>

@interface YGXStatusBarHUD : NSObject
+ (void)showSuccess:(NSString *)msg;
+ (void)showError:(NSString *)msg;
+ (void)showLoading:(NSString *)msg;
+ (void)hide;

+ (void)showMessage:(NSString *)msg;
+ (void)showMessage:(NSString *)msg image:(UIImage *)image;

@end
