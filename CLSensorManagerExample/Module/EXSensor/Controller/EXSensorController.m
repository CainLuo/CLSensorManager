//
//  EXSensorController.m
//  CLPedometerManager
//
//  Created by Cain Luo on 2018/8/20.
//  Copyright © 2018年 Cain Luo. All rights reserved.
//

#import "EXSensorController.h"
#import "EXSensorDataSource.h"
#import "EXSensorDelegate.h"
#import "EXSensorViewModel.h"

@interface EXSensorController ()

@property (nonatomic, strong) EXSensorDataSource *ex_sensorDataSource;
@property (nonatomic, strong) EXSensorDelegate   *ex_sensorDelegate;
@property (nonatomic, strong) EXSensorViewModel  *ex_sensorViewModel;

@end

@implementation EXSensorController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self cl_removeRefresh];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.title = @"iOS传感器";
    
    [self cl_setTableViewDelegate:self.ex_sensorDelegate
                       dataSource:self.ex_sensorDataSource];
    
    [self.ex_sensorViewModel cl_tableViewHTTPRequest];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    [self ex_addConstraintsWithSuperView];
}

- (EXSensorDataSource *)ex_sensorDataSource {
    
    CL_GET_METHOD_RETURN_OBJC(_ex_sensorDataSource);
    
    _ex_sensorDataSource = [[EXSensorDataSource alloc] initTableViewDataSourceWithViewModel:self.ex_sensorViewModel];
    
    return _ex_sensorDataSource;
}

- (EXSensorViewModel *)ex_sensorViewModel {
    
    CL_GET_METHOD_RETURN_OBJC(_ex_sensorViewModel);
    
    _ex_sensorViewModel = [[EXSensorViewModel alloc] initTableViewBaseModelWithController:self];
    
    return _ex_sensorViewModel;
}

- (EXSensorDelegate *)ex_sensorDelegate {
    
    CL_GET_METHOD_RETURN_OBJC(_ex_sensorDelegate);
    
    _ex_sensorDelegate = [[EXSensorDelegate alloc] initTableViewDelegateWithViewModel:self.ex_sensorViewModel];
    
    return _ex_sensorDelegate;
}

- (void)ex_addConstraintsWithSuperView {
    
    self.cl_tableView.rowHeight = [UIScreen cl_fitPlusScreen:150];
    
    [self.cl_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        
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

@end
