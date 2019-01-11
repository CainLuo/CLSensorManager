//
//  EXSensorDelegate.m
//  CLSensorManager
//
//  Created by Cain Luo on 2019/1/11.
//  Copyright © 2019 Cain Luo. All rights reserved.
//

#import "EXSensorDelegate.h"
#import "EXSensorModel.h"

@implementation EXSensorDelegate

- (void)tableView:(UITableView *)tableView
didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath
                             animated:YES];
    
    EXSensorModel *ex_sensorModel = self.cl_viewModel.cl_dataSource[indexPath.row];

    UIViewController *ex_controller = [[NSClassFromString(ex_sensorModel.ex_controller) alloc] init];
    
    ex_controller.title = ex_sensorModel.ex_title;
    
    [self.cl_viewModel.cl_tableViewController.navigationController pushViewController:ex_controller
                                                                             animated:YES];
}

@end
