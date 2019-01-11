//
//  CLPedometerManager.h
//  CLPedometerManager
//
//  Created by Cain Luo on 2019/1/11.
//  Copyright © 2019 Cain Luo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreMotion/CoreMotion.h>

NS_ASSUME_NONNULL_BEGIN

typedef void (^CLSensorTypePedometerBlock)(CMPedometerData * _Nullable cl_pedometerData, NSError * _Nullable cl_error);
typedef void (^CLPedometerEventHandler)(CMPedometerEvent * __nullable pedometerEvent, NSError * __nullable error) NS_AVAILABLE(NA, 10_0) __WATCHOS_AVAILABLE(3_0) API_UNAVAILABLE(tvos);

typedef NS_ENUM(NSInteger, CLDateType) {
    
    CLDateTypeSingleDay = 0,    // 单天
    CLDateTypeMultipleDay       // 多天
};

@interface CLPedometerManager : NSObject

+ (CLPedometerManager *)cl_managerWithDateType:(CLDateType)dateType;

@property (nonatomic, assign, readonly) CLDateType cl_dateType;

/**
 当CLDateType为CLDateTypeSingleDay才生效
 */
@property (nonatomic, strong) NSDate *cl_dataDate;

/**
 当CLDateType为CLDateTypeMultipleDay才生效
 */
@property (nonatomic, strong) NSDate *cl_startDate;
@property (nonatomic, strong) NSDate *cl_endDate;

/**
 获取CMPedometer传感器的数据

 @param complete CLSensorTypePedometerBlock
 */
- (void)cl_startPedometerUpdatesComplete:(CLSensorTypePedometerBlock)complete;

/**
 获取CMPedometer传感器的行为

 @param handler CMPedometer
 */
- (void)cl_startPedometerEventUpdatesWithHandler:(CLPedometerEventHandler)handler NS_AVAILABLE(NA,10_0) __WATCHOS_AVAILABLE(3_0);

/**
 停止获取CMPedometer传感器数据
 */
- (void)cl_stopPedometerUpdates;

/**
 停止获取CMPedometer传感器的行为
 */
- (void)cl_stopPedometerEventUpdates NS_AVAILABLE(NA,10_0) __WATCHOS_AVAILABLE(3_0);

/**
 当前设备是否有计步器数据

 @return BOOL
 */
+ (BOOL)cl_isStepCountingAvailable;

/**
 当前设备是否有距离估算, 并不是所有设备都有该功能

 @return BOOL
 */
+ (BOOL)cl_isDistanceAvailable;

/**
 获取当前楼层计数是否可用

 @return BOOL
 */
+ (BOOL)cl_isFloorCountingAvailable;

/**
 获取当前设备是否有步速信息

 @return BOOL
 */
+ (BOOL)cl_isPaceAvailable NS_AVAILABLE(NA,9_0);

/**
 获取当前设备是否有节奏信息

 @return BOOL
 */
+ (BOOL)cl_isCadenceAvailable NS_AVAILABLE(NA,9_0);

/**
 获取当前设备的计数事件是否可用

 @return BOOL
 */
+ (BOOL)cl_isPedometerEventTrackingAvailable NS_AVAILABLE(NA,10_0) __WATCHOS_AVAILABLE(3_0);

/**
 获取当前应用是否有权限收集计步器数据

 @return CMAuthorizationStatus
 */
+ (CMAuthorizationStatus)cl_authorizationStatus NS_AVAILABLE(NA, 11_0) __WATCHOS_AVAILABLE(4_0);

@end

NS_ASSUME_NONNULL_END
