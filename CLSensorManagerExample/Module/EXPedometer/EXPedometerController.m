//
//  EXPedometerController.m
//  CLSensorManager
//
//  Created by Cain Luo on 2019/1/11.
//  Copyright © 2019 Cain Luo. All rights reserved.
//

#import "EXPedometerController.h"

@interface EXPedometerController ()

@property (nonatomic, strong) UILabel *ex_contentLabel;

@end

@implementation EXPedometerController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self ex_pedonmeterStart];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    [self.view addSubview:self.ex_contentLabel];
    
    [self.ex_contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        if (@available(iOS 11.0, *)) {
            
            make.top.equalTo(self.view.mas_safeAreaLayoutGuideTop);
            make.left.equalTo(self.view.mas_safeAreaLayoutGuideLeft);
            make.bottom.equalTo(self.view.mas_safeAreaLayoutGuideBottom);
            make.right.equalTo(self.view.mas_safeAreaLayoutGuideRight);
        } else {
            
            (void)make.edges;
        }
    }];
}

- (UILabel *)ex_contentLabel {
    
    CL_GET_METHOD_RETURN_OBJC(_ex_contentLabel);
    
    _ex_contentLabel = [[UILabel alloc] init];
    
    _ex_contentLabel.textColor                 = [UIColor blackColor];
    _ex_contentLabel.textAlignment             = NSTextAlignmentCenter;
    _ex_contentLabel.numberOfLines             = 0;
    _ex_contentLabel.minimumScaleFactor        = 15;
    _ex_contentLabel.adjustsFontSizeToFitWidth = YES;
    
    return _ex_contentLabel;
}

- (void)ex_pedonmeterStart {
    
    if ([CLPedometerManager cl_isStepCountingAvailable]) {
        
        CLPedometerManager *cl_pedometerManager = [CLPedometerManager cl_managerWithDateType:CLDateTypeSingleDay];
        
        cl_pedometerManager.cl_dataDate = [NSDate dateWithTimeIntervalSinceNow:-60*60*24*2];
        
        NSString *ex_dateString = [NSDate cl_getStringDateWithDate:cl_pedometerManager.cl_dataDate
                                                         formatter:@"yyyy-MM-dd"];
        
        [cl_pedometerManager cl_startPedometerUpdatesComplete:^(CMPedometerData * _Nullable cl_pedometerData, NSError * _Nullable cl_error) {
            
            if (cl_error) {
                NSLog(@"error：%@",cl_error);
            } else {
                
                self.ex_contentLabel.text = [NSString stringWithFormat:@"日期：%@\n获取到的步数为：%@\n距离为：%@", ex_dateString, cl_pedometerData.numberOfSteps, cl_pedometerData.distance];
            }
        }];
    } else {
        
        NSLog(@"计步器没有数据");
    }
}

@end
