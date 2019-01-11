//
//  CLPedometerManager.m
//  CLPedometerManager
//
//  Created by Cain Luo on 2019/1/11.
//  Copyright © 2019 Cain Luo. All rights reserved.
//

#import "CLPedometerManager.h"

@interface CLPedometerManager()

@property (nonatomic, strong) CMPedometer *cl_pedometer;

@property (nonatomic, assign, readwrite) CLDateType cl_dateType;

@end

@implementation CLPedometerManager

+ (CLPedometerManager *)cl_managerWithDateType:(CLDateType)dateType {

    static CLPedometerManager *cl_sensorManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        cl_sensorManager = [[self alloc] initWithDateType:dateType];
    });
    
    return cl_sensorManager;
}

- (instancetype)initWithDateType:(CLDateType)dateType {
    self = [super init];
    
    if (self) {
        
        self.cl_pedometer = [[CMPedometer alloc] init];
        
        self.cl_dateType = dateType;
    }
    
    return self;
}

- (void)cl_startPedometerUpdatesComplete:(CLSensorTypePedometerBlock)complete {

    switch (self.cl_dateType) {
        case CLDateTypeSingleDay:
            
            if (self.cl_dataDate) {
                
                [self.cl_pedometer startPedometerUpdatesFromDate:self.cl_dataDate
                                                     withHandler:^(CMPedometerData * _Nullable pedometerData, NSError * _Nullable error) {
                                                         
                                                         dispatch_async(dispatch_get_main_queue(), ^{
                                                             
                                                             if (complete) {
                                                                 complete(pedometerData, error);
                                                             }
                                                         });
                                                     }];
            } else {
                
                [self cl_emptyDateErrorComplete:complete];
            }
            break;
        case CLDateTypeMultipleDay:
            
            if (self.cl_startDate && self.cl_endDate) {
                
                [self.cl_pedometer queryPedometerDataFromDate:self.cl_startDate
                                                       toDate:self.cl_endDate
                                                  withHandler:^(CMPedometerData * _Nullable pedometerData, NSError * _Nullable error) {
                                                      
                                                      dispatch_async(dispatch_get_main_queue(), ^{
                                                          
                                                          if (complete) {
                                                              complete(pedometerData, error);
                                                          }
                                                      });
                                                  }];
            } else {
                
                [self cl_emptyDateErrorComplete:complete];
            }
            break;
        default:
            break;
    }
}

- (void)cl_emptyDateErrorComplete:(CLSensorTypePedometerBlock)complete {
    
    NSError *cl_error = [NSError errorWithDomain:@"****The date you entered is empty****"
                                            code:-999
                                        userInfo:@{NSLocalizedDescriptionKey:@"****The date you entered is empty****"}];
    
    if (complete) {
        complete([CMPedometerData new], cl_error);
    }
}

- (void)cl_startPedometerEventUpdatesWithHandler:(CLPedometerEventHandler)handler {
    
    [self.cl_pedometer startPedometerEventUpdatesWithHandler:handler];
}

- (void)cl_stopPedometerUpdates {
    
    [self.cl_pedometer stopPedometerUpdates];
}

- (void)cl_stopPedometerEventUpdates {
    
    [self.cl_pedometer stopPedometerEventUpdates];
}

+ (BOOL)cl_isStepCountingAvailable {
    return [CMPedometer isStepCountingAvailable];
}

+ (BOOL)cl_isDistanceAvailable {
    return [CMPedometer isDistanceAvailable];
}

+ (BOOL)cl_isFloorCountingAvailable {
    return [CMPedometer isFloorCountingAvailable];
}

+ (BOOL)cl_isPaceAvailable NS_AVAILABLE(NA,9_0) {
    return [CMPedometer isPaceAvailable];
}

+ (BOOL)cl_isCadenceAvailable NS_AVAILABLE(NA,9_0) {
    return [CMPedometer isCadenceAvailable];
}

+ (BOOL)cl_isPedometerEventTrackingAvailable NS_AVAILABLE(NA,10_0) __WATCHOS_AVAILABLE(3_0) {
    return [CMPedometer isPedometerEventTrackingAvailable];
}

+ (CMAuthorizationStatus)cl_authorizationStatus NS_AVAILABLE(NA, 11_0) __WATCHOS_AVAILABLE(4_0) {
    return [CMPedometer authorizationStatus];
}

@end
