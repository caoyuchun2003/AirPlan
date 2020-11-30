//
//  ListViewController.m
//  AirPrint
//
//  Created by 曹宇春 on 2020/11/29.
//  Copyright © 2020 huateng. All rights reserved.
//

#import "ListViewController.h"
#import "ViewController.h"
#import "QiCodeScanningViewController.h"
#import "HTBlueViewController.h"

@interface ListViewController ()

@end

@implementation ListViewController


- (void)initDataSource {
    [super initDataSource];
    self.dataSource = @[@"新建打包",
                        @"二维码扫描",
                        @"书单列表",
                        @"蓝牙列表",
                        @"Interactive Debugger",
                        @"UINavigationBar Smooth Effect",
                        @"UINavigationBar Bottom Accessory"
                        ];
}

- (void)didSelectCellWithTitle:(NSString *)title {
    __weak __typeof(self)weakSelf = self;
    UIViewController *viewController = nil;
    if ([title isEqualToString:@"新建打包"]) {
        viewController = [[ViewController alloc] init];
    }
    else   if ([title isEqualToString:@"二维码扫描"]) {
          viewController = [[QiCodeScanningViewController alloc] init];
      }
    
    else   if ([title isEqualToString:@"蓝牙列表"]) {
             viewController = [[HTBlueViewController alloc] init];
         }
    
    
    
    
    viewController.title = title;
    [self.navigationController pushViewController:viewController animated:YES];
}

- (void)setupNavigationItems {
    [super setupNavigationItems];
    self.title = @"功能列表";
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem qmui_itemWithImage:UIImageMake(@"icon_nav_about") target:self action:@selector(handleAboutItemEvent)];
    AddAccessibilityLabel(self.navigationItem.rightBarButtonItem, @"打开关于界面");
}

- (void)handleAboutItemEvent {
//    QDAboutViewController *viewController = [[QDAboutViewController alloc] init];
//    [self.navigationController pushViewController:viewController animated:YES];
}
@end
