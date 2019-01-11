//
//  ESSensorController.m
//  CLPedometerManager
//
//  Created by Cain Luo on 2018/8/20.
//  Copyright © 2018年 Cain Luo. All rights reserved.
//

#import "ESSensorController.h"
#import "CLPedometerManager.h"

@interface ESSensorController ()

@property (nonatomic, strong) CMPedometer *cl_pedonmeter;

@end

@implementation ESSensorController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.title = @"iOS传感器";
    
    self.cl_pedonmeter = [[CMPedometer alloc] init];
    
    [self cl_motionStart];
}

- (void)cl_motionStart {

    if ([CLPedometerManager cl_isStepCountingAvailable]) {
        
        CLPedometerManager *cl_pedometerManager = [CLPedometerManager cl_shareInstance];
        
        cl_pedometerManager.cl_dataDate   = [NSDate dateWithTimeIntervalSinceNow:-60*60*24*2];
        
        [cl_pedometerManager cl_startPedometerUpdatesComplete:^(CMPedometerData * _Nullable cl_pedometerData, NSError * _Nullable cl_error) {
            
            if (cl_error) {
                NSLog(@"error===%@",cl_error);
            } else {
                NSLog(@"步数===%@",cl_pedometerData.numberOfSteps);
                NSLog(@"距离===%@",cl_pedometerData.distance);
            }
        }];

//        [self.cl_pedonmeter queryPedometerDataFromDate:[NSDate dateWithTimeIntervalSinceNow:-60*60*24*2]
//                                        toDate:[NSDate dateWithTimeIntervalSinceNow:-60*60*24*1]
//                                   withHandler:^(CMPedometerData * _Nullable pedometerData, NSError * _Nullable error) {
//                                       if (error) {
//                                           NSLog(@"error===%@",error);
//                                       } else {
//                                           NSLog(@"步数===%@",pedometerData.numberOfSteps);
//                                           NSLog(@"距离===%@",pedometerData.distance);
//                                       }
//                                   }];
    } else {
        
        NSLog(@"不可用===");
    }
}

@end
