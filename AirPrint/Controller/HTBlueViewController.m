//
//  HTBlueViewController.m
//  AirPrint
//
//  Created by 曹宇春 on 2020/11/29.
//  Copyright © 2020 huateng. All rights reserved.
//

#import "HTBlueViewController.h"
#import <PrinterSDK/PrinterSDK.h>
#import <CoreBluetooth/CoreBluetooth.h>
@interface HTBlueViewController ()
@property (nonatomic, strong) CBCentralManager *manager;


@end

@implementation HTBlueViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[PTDispatcher share] getBluetoothStatus];
    PTDispatchMode model = [PTDispatcher share].mode;
    
    NSDictionary *options = @{CBCentralManagerOptionShowPowerAlertKey:@NO};//不弹窗（配置）
       self.manager = [[CBCentralManager alloc] initWithDelegate:self queue:nil options:options];

    
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    
    PTBluetoothState staue=[ [PTDispatcher share] getBluetoothStatus];

    switch (staue) {
        case PTBluetoothStateUnauthorized:
           
            break;
            
        default:
            break;
    }
    [PTDispatcher share].printStateBlock = ^(PTPrintState state) {
        NSLog(@"aaaa");
    };
    
    [PTDispatcher share].findAllPeripheralBlock = ^(NSMutableArray<PTPrinter *> *printerArray) {
                NSLog(@"aaaa");

    };
    
    [PTDispatcher share].connectSuccessBlock = ^{
                NSLog(@"aaaa");

    };
    
    [PTDispatcher share].connectFailBlock = ^(PTConnectError error) {
                NSLog(@"aaaa");

    };
    
    
    [PTDispatcher share].unconnectBlock = ^(NSNumber *number, BOOL isActive) {
                NSLog(@"aaaa");

    };
    
    
    PTPrinter *priter = [PTDispatcher share].printerConnected;
    
    if (!priter) {
        [[PTDispatcher share] scanBluetooth];
        
        [[PTDispatcher share] whenFindAllBluetooth:^(NSMutableArray<PTPrinter *> *printerArray) {
            
            [[PTDispatcher share] stopScanBluetooth];
            for (PTPrinter *printer in printerArray) {
                
                NSLog(@"name==%@",priter.name);
                NSLog(@"mac ==%@",priter.mac);
                [[PTDispatcher share] connectPrinter:priter];
                break;;
            }
            NSLog(@"sdfadf");
        }];
    }
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/




- (void)centralManagerDidUpdateState:(CBCentralManager *)central {
    NSString *strMessage = @"";
    NSString *buttonTitle = nil;
    switch (central.state) {
        case CBManagerStatePoweredOn: {
            NSLog(@"蓝牙开启且可用");
            [QMUITips showError:@"蓝牙开启且可用" inView:self.view hideAfterDelay:2];

            return;
        }
            break;
        case CBManagerStateUnknown: {
            strMessage = @"手机没有识别到蓝牙，请检查手机。";
            buttonTitle = @"前往设置";
            [QMUITips showError:@"手机没有识别到蓝牙，请检查手机。" inView:self.view hideAfterDelay:2];

        }
            break;
        case CBManagerStateResetting: {
            strMessage = @"手机蓝牙已断开连接，重置中...";
            buttonTitle = @"前往设置";
            [QMUITips showError:@"手机蓝牙已断开连接，重置中..." inView:self.view hideAfterDelay:2];

        }
            break;
        case CBManagerStateUnsupported: {
            strMessage = @"手机不支持蓝牙功能，请更换手机。";
            [QMUITips showError:@"手机不支持蓝牙功能，请更换手机。" inView:self.view hideAfterDelay:2];

        }
            break;
        case CBManagerStatePoweredOff: {
            strMessage = @"手机蓝牙功能关闭，请前往设置打开蓝牙及控制中心打开蓝牙。";
            buttonTitle = @"前往设置";
            [QMUITips showError:@"手机蓝牙功能关闭，请前往设置打开蓝牙及控制中心打开蓝牙。" inView:self.view hideAfterDelay:2];

        }
            break;
        case CBManagerStateUnauthorized: {
            strMessage = @"手机蓝牙功能没有权限，请前往设置。";
            buttonTitle = @"前往设置";
            [QMUITips showError:@"手机蓝牙功能没有权限，请前往设置。" inView:self.view hideAfterDelay:2];

        }
            break;
        default: { }
            break;
    }
    //通知没有打开蓝牙的自定义提示弹窗（弹窗代码自行实现）
//    [self __broadAlertMessage:strMessage buttonTitle:buttonTitle];
    
//    QMUIToastView
}
//当使用完蓝牙时记得关闭蓝牙监听，减少资源消耗：
//    self.manager.delegate = nil;
//    self.manager = nil;
@end
