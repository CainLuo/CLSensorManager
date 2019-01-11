//
//  EXSensorDataSource.m
//  CLSensorManager
//
//  Created by Cain Luo on 2019/1/11.
//  Copyright © 2019 Cain Luo. All rights reserved.
//

#import "EXSensorDataSource.h"
#import "EXSensorModel.h"

@implementation EXSensorDataSource

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *ex_tableViewCell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"];
    
    if (!ex_tableViewCell) {
        
        ex_tableViewCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                                  reuseIdentifier:@"UITableViewCell"];
    }
    
    EXSensorModel *ex_sensorModel = self.cl_viewModel.cl_dataSource[indexPath.row];
    
    ex_tableViewCell.textLabel.text = ex_sensorModel.ex_title;
    
    return ex_tableViewCell;
}

@end
