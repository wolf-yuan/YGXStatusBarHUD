//
//  YGXStatusBarHUD.m
//  状态栏指示器01
//
//  Created by wolf －yuan on 16/8/19.
//  Copyright © 2016年 com.yuan. All rights reserved.
//  http://www.easyicon.net/iconsearch/check/

//大版本号.功能更新版本号.BUG修复版本号
//怎么让框架 支持coapods

#import "YGXStatusBarHUD.h"
//定时器设置为2秒后出发
static CGFloat const YGXTimeDuration = 2.0;

static CGFloat const YGXAnimDuration = 0.5;

@implementation YGXStatusBarHUD
//全局的窗口变量
static UIWindow *window_;

//全局的定时器对象
static NSTimer *timer_;

+ (void)showSuccess:(NSString *)msg
{
    //创建并显示窗口
//    window_ = [[UIWindow alloc]init];
//    window_.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 20);
//    window_.backgroundColor = [UIColor yellowColor];
//    window_.windowLevel = UIWindowLevelAlert;
//    window_.hidden = NO;
    
//    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
//    btn.frame = window_.bounds;
    
//    [btn setImage:[UIImage imageNamed:@"check"] forState:UIControlStateNormal];
//    [btn setTitle:msg forState:UIControlStateNormal];
//    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//    [btn.titleLabel setFont:[UIFont systemFontOfSize:13]];
//    btn.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
    
//    [window_ addSubview:btn];
    
    [self showMessage:msg image:[UIImage imageNamed:@"YGXStatusBarHUD.bundle/check"]];
    NSLog(@"%@",NSTemporaryDirectory());
}

+ (void)showError:(NSString *)msg
{
    //创建并显示窗口
//    window_ = [[UIWindow alloc]init];
//    window_.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 20);
//    window_.backgroundColor = [UIColor yellowColor];
//    window_.windowLevel = UIWindowLevelAlert;
//    window_.hidden = NO;
    
//    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
//    btn.frame = window_.bounds;
    
//    [btn setImage:[UIImage imageNamed:@"error"] forState:UIControlStateNormal];
//    [btn setTitle:msg forState:UIControlStateNormal];
//    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//    [btn.titleLabel setFont:[UIFont systemFontOfSize:13]];
//    btn.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
    
//    [window_ addSubview:btn];
    
    [self showMessage:msg image:[UIImage imageNamed:@"YGXStatusBarHUD.bundle/error"]];
}

+ (void)showMessage:(NSString *)msg
{
    //创建并显示窗口
//    window_ = [[UIWindow alloc]init];
//    window_.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 20);
//    window_.backgroundColor = [UIColor yellowColor];
//    window_.windowLevel = UIWindowLevelAlert;
//    window_.hidden = NO;
    
//    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
//    btn.frame = window_.bounds;
    
//    [btn setTitle:msg forState:UIControlStateNormal];
//    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//    [btn.titleLabel setFont:[UIFont systemFontOfSize:13]];
    
//    [window_ addSubview:btn];
    
    [self showMessage:msg image:nil];

}

+ (void)setupWindow
{
    window_.hidden = YES;//解决窗口残留问题
    window_ = [[UIWindow alloc]init];
    
    CGFloat windowH = 20;
    CGRect frame = CGRectMake(0, -windowH, [UIScreen mainScreen].bounds.size.width, windowH);
    
    window_.frame = frame;
    window_.backgroundColor = [UIColor blackColor];
    window_.windowLevel = UIWindowLevelAlert;
    window_.hidden = NO;
    
    //拿出 frame,修改y值
    frame.origin.y = 0;
    //给当前view增加 动画
    [UIView animateWithDuration:YGXAnimDuration animations:^{
        window_.frame = frame;
    }];
}
//showSuccess  showError  showMessage都要消失,所以在公共方法里面写代码
+ (void)showMessage:(NSString *)msg image:(UIImage *)image
{
    //创建并显示窗口
//    window_ = [[UIWindow alloc]init];
//    window_.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 20);
//    window_.backgroundColor = [UIColor yellowColor];
//    window_.windowLevel = UIWindowLevelAlert;
//    window_.hidden = NO;
    [self setupWindow];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = window_.bounds;
    
    [btn setTitle:msg forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn.titleLabel setFont:[UIFont systemFontOfSize:13]];
    
    //如果有图片 才需要设置图片和Label距离图片的间距
    if (image) {
        [btn setImage:image forState:UIControlStateNormal];
        btn.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
    }
    
    [window_ addSubview:btn];
    
    /*停止上一次的定时器*/
    [timer_ invalidate];
    timer_ = nil;
    
    //定时消失
    /*出现的问题就是点击showSuccess然后再点击showError的时候 showError1秒就消失了
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self hide];
    });*/
    //scheduledTimerWithTimeInterval 默认会添加runLoop里面去
    timer_ = [NSTimer scheduledTimerWithTimeInterval:YGXTimeDuration target:self selector:@selector(hide) userInfo:nil repeats:NO];

}


+ (void)showLoading:(NSString *)msg
{
    //停止 并 销毁定时器
    [timer_ invalidate];
    timer_ = nil;
    
    [self setupWindow];
    
    //添加label
    UILabel *lab = [[UILabel alloc]init];
    lab.frame = window_.bounds;
    lab.text = msg;
    lab.textColor = [UIColor whiteColor];
    lab.font = [UIFont systemFontOfSize:13];
    lab.textAlignment = NSTextAlignmentCenter;
    [window_ addSubview:lab];
    
    UIActivityIndicatorView *indicator = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    //设置indicator的位置 通过设置中心点来设置
    CGSize contentSize = [msg sizeWithAttributes:@{NSFontAttributeName : [UIFont systemFontOfSize:13]}];
    CGFloat centerX = (window_.frame.size.width - contentSize.width) * 0.5 - 20;
    CGFloat centerY = window_.frame.size.height * 0.5;
    indicator.center = CGPointMake(centerX, centerY);
    
    [indicator startAnimating];
    [window_ addSubview:indicator];
}

+ (void)hide
{
    [UIView animateWithDuration:YGXAnimDuration animations:^{
        CGRect frame = window_.frame;
        frame.origin.y = -frame.size.height;
        window_.frame = frame;
        
    } completion:^(BOOL finished) {
        //窗口死掉 他里面的子控件也死掉了
        window_ = nil;
        
        timer_ = nil;
    }];

}
@end
