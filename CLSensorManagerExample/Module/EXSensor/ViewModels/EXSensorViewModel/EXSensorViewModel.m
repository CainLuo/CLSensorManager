//
//  EXSensorViewModel.m
//  CLSensorManager
//
//  Created by Cain Luo on 2019/1/11.
//  Copyright © 2019 Cain Luo. All rights reserved.
//

#import "EXSensorViewModel.h"
#import "EXSensorModel.h"

@implementation EXSensorViewModel

- (void)cl_tableViewHTTPRequest {
    
    [self.cl_dataSource addObjectsFromArray:[NSArray yy_modelArrayWithClass:[EXSensorModel class]
                                                                       json:[self ex_dataSource]]];
    
    [self.cl_tableViewController.cl_tableView reloadData];
    
    [self cl_showTableViewSeparatorLine];
}

- (NSArray *)ex_dataSource {
    return @[@{@"ex_title":@"CMPedometer",
               @"ex_controller":@"EXPedometerController"}];
}

@end
