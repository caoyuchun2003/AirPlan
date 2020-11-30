//
//  ViewController.m
//  AirPrint
//
//  Created by 曹宇春 on 2020/11/29.
//  Copyright © 2020 huateng. All rights reserved.
//

#import "ViewController.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.title=@"打印app";
    QMUIButton * btn =[[QMUIButton alloc]init];
    
    [btn setTitle:@"新建打包" forState:UIControlStateNormal];

    [self.view addSubview:btn];

    
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.centerX.equalTo(self.view);
    }];
    
    
    
    
//    self.view.backgroundColor=[UIColor redColor];
    // Do any additional setup after loading the view.
}


@end
