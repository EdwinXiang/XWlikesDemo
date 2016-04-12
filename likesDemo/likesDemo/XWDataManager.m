//
//  XWDataManager.m
//  likesDemo
//
//  Created by Edwin on 16/4/11.
//  Copyright © 2016年 EdwinXiang. All rights reserved.
//

#import "XWDataManager.h"
#import "FMDB.h"

static XWDataManager *g_manager = nil;

@interface XWDataManager ()
@property (nonatomic,strong) FMDatabase *dataBase;
@end
@implementation XWDataManager

+(instancetype)sharedManager{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        g_manager = [[XWDataManager alloc]init];
    });
    return g_manager;
}

-(instancetype)init{
    
    if ( self = [super init]) {
        
        NSString *dataPath = [NSString stringWithFormat:@"%@/Documents/likeData.db",NSHomeDirectory()];
        NSFileManager *fileManager = [NSFileManager defaultManager];
        if ([fileManager fileExistsAtPath:dataPath]) {
            // 该操作用来复原
            //            [fileManager removeItemAtPath:dataPath error:nil];
        }
        
        _dataBase = [[FMDatabase alloc]initWithPath:dataPath];
        if ([_dataBase open]) {
            
            NSString *creatStr = @"create table if not exists t_likes(likes,channel)";
            BOOL isSuc = [_dataBase executeUpdate:creatStr];
            
            if (isSuc) {
                NSLog(@"打开或创建数据库成功");
            }else{
                NSLog(@"打开或创建数据库失败");
            }
        }
    }
    return self;
}

- (BOOL)isLocalExistDatas {
    FMResultSet *set = [_dataBase executeQuery:@"select * from t_likes"];
    return  [set next]?YES:NO;
}

-(BOOL)isDataExistByurlStr:(NSString *)urlStr{
    FMResultSet *set = [_dataBase executeQuery:@"select * from t_likes where channel=?",urlStr];
    if ([set next]) {  //如果数据存在
        return YES;
    }else{
        return NO;
    }
}

-(BOOL)addDataFromModel:(XWDataModel *)model{
    
    BOOL isExist = [self isDataExistByurlStr:model.channel];
    
    if (isExist) {
        NSLog(@"该数据已经存在");
        return NO;
    }else{
        BOOL isSuc =  [_dataBase executeUpdate:@"insert into t_likes (likes,channel) values(?,?);",model.likes,model.channel];
        if (isSuc) {
            NSLog(@"加入数据成功");
            return YES;
        }else {
            NSLog(@"DBError = %@",_dataBase.lastErrorMessage);
            return NO;
        }
        
    }
}

-(BOOL)deleteDataByModel:(XWDataModel *)model{
    
    //判断数据是否存在
    
    BOOL isExist = [self isDataExistByurlStr:model.likes];
    
    if (isExist) {
        
        [_dataBase executeUpdate:@"delete from t_likes where likes=?",model.likes];
        return YES;
    }else{
        NSLog(@"该数据不存在,删除数据库失败");
        return NO;
    }
}

-(BOOL)updateFromModel:(XWDataModel *)model andNewValue:(NSString *)newValue{
    return [_dataBase executeUpdate:@"update t_likes set likes = ? where channel=?",newValue,model.channel];
}

-(NSMutableArray *)fetchAllData{
    FMResultSet *set = [_dataBase executeQuery:@"select * from t_likes"];
    NSMutableArray *dataArr = [NSMutableArray array];
    
    while ([set next]) {
        XWDataModel *model = [[XWDataModel alloc]init];
        model.likes = [set stringForColumn:@"likes"];
        model.channel = [set stringForColumn:@"channel"];
        [dataArr addObject:model];
    }
    return dataArr;
}
@end
