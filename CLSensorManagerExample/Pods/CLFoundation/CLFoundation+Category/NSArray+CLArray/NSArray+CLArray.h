//
//  NSArray+CLArray.h
//  SimpleProject
//
//  Created by Cain on 2017/8/27.
//  Copyright © 2017年 Cain Luo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (CLArray)

/**
 创建一个安全的Array

 @param object 对象, 可以为nil
 @return NSArray
 */
+ (instancetype)cl_initSafeArrayWithObject:(id)object;

/**
 序列化创建一个NSArray

 @param plist NSData
 @return NSArray
 */
+ (NSArray *)cl_arrayWithPlistData:(NSData *)plist;

/**
 从数组里获取一个id对象, 索引超出之后, 也不会崩掉

 @param index 对象索引
 @return id
 */
- (id)cl_safeObjectAtIndex:(NSUInteger)index;

/**
 根据Range返回对应的Array

 @param range range, 这里就算超出了索引也不会引起问题
 @return NSArray
 */
- (NSArray *)cl_safeArrayWithRange:(NSRange)range;

/**
 输入指定的筛选条件获取对应的数据
 
 @param key NSString
 @return NSArray
 */
- (NSArray *)cl_filterArrayWithKey:(NSString *)key;

/**
 输入指定的筛选条件获取对应的数据

 @param condition NSString, 比如: SELF CONTAINS height
 @return NSArray
 */
- (NSArray *)cl_filterArrayWithCondition:(NSString *)condition;

/**
 根据指定的Key排序

 @param key NSString
 @param ascending BOOL
 @return NSArray
 */
- (NSArray *)cl_sortArrayWithKey:(NSString *)key
                       ascending:(BOOL)ascending;

/**
 根据指定的Keys排序

 @param keys NSArray<NSString *>
 @param ascending BOOL
 @return NSArray
 */
- (NSArray *)cl_sortArrayWithKeys:(NSArray<NSString *> *)keys
                        ascending:(BOOL)ascending;

/**
 根据对象返回对应的索引

 @param object 对象
 @return NSUInteger
 */
- (NSUInteger)cl_safeIndexOfObject:(id)object;

/**
 根据给定的Plist文件名返回里面的数组

 @param name Plist文件名
 @return NSArray
 */
+ (NSArray *)cl_getArrayWithPlistName:(NSString *)name;

/**
 根据给定的JSON String转成NSArray

 @param jsonString NSString
 @return NSArray
 */
+ (NSArray *)cl_getArrayWithJSONString:(NSString *)jsonString;

@end
