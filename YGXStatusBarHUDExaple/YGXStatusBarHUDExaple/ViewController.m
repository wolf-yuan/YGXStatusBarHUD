//
//  ViewController.m
//  YGXStatusBarHUDExaple
//
//  Created by wolf －yuan on 16/8/24.
//  Copyright © 2016年 com.yuan. All rights reserved.
//

#import "ViewController.h"
#import "YGXStatusBarHUD.h"
/*
 解决框架里的图片 和 自己项目里图片名字互相冲突的问题 ，对资源进行打包，打包到bundle里面去
 先建一个文件夹，把图片拖进去，然后单击文件夹，在文件夹后面添加 .bundle后缀。修改图片的路径xx.bundle/图片名字
 guthub客户端：https://desktop.github.com
 
 1.在guthub远程服务器端创建了一个代码仓库，
 把仓库下载到硬盘上
 把硬盘代码传到服务器
 把项目代码放到仓库里面去
 
 将框架拖到项目文件夹下， 再将框架拖到项目的时候，千万不要勾选Copy items if need
 
 仅仅是传到guthub服务器，还需要传导cocapods服务器
 */

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

//window变量只有1个 点击任何一个按钮 窗口变量负新值的时候，原来的窗口就会自动销毁
- (IBAction)success:(id)sender {
    [YGXStatusBarHUD showSuccess:@"加载成功!"];
}
- (IBAction)error:(id)sender {
    [YGXStatusBarHUD showError:@"加载失败!"];
}
- (IBAction)loading:(id)sender {
    [YGXStatusBarHUD showLoading:@"正在加载....."];
}
- (IBAction)hiden:(id)sender {
    [YGXStatusBarHUD hide];
}
- (IBAction)normal:(id)sender {
    [YGXStatusBarHUD showMessage:@"没有什么事!!!"];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    //    [YGXStatusBarHUD showSuccess:@"加载成功!"];
    //    [YGXStatusBarHUD showError:@"加载失败!"];
    //    [YGXStatusBarHUD showLoading:@"正在加载....."];
}


@end
