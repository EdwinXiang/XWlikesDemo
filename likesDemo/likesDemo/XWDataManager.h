//
//  XWDataManager.h
//  likesDemo
//
//  Created by Edwin on 16/4/11.
//  Copyright © 2016年 EdwinXiang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XWDataModel.h"
@interface XWDataManager : NSObject

/**
 *  单例
 */
+(instancetype)sharedManager;


/**
 *  判断本地是否缓存了数据
 *
 *  @return 返回结果
 */
-(BOOL)isLocalExistDatas;


/**
 *  判断数据是否存在
 *
 *  @param sourceStr 源数据名字
 *
 *  @return 返回结果
 */
-(BOOL)isDataExistByurlStr:(NSString *)urlStr;

/**
 *  添加数据
 *
 *  @param model 数据模型
 *
 *  @return 返回添加数据是否成功
 */
-(BOOL)addDataFromModel:(XWDataModel *)model;

/**
 *  删除数据
 *
 *  @param model 数据模型
 *
 *  @return 返回删除数据结果
 */
-(BOOL)deleteDataByModel:(XWDataModel *)model;

-(BOOL)updateFromModel:(XWDataModel *)model andNewValue:(NSString *)newValue;

/**
 *  获取所有数据
 *
 *  @return 以数组形式返回数据
 */
-(NSMutableArray *)fetchAllData;
@end
