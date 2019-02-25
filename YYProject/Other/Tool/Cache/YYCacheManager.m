//
//  YYCacheManager.m
//  YYProject
//
//  Created by 于优 on 2018/12/6.
//  Copyright © 2018 SuperYu. All rights reserved.
//

#import "YYCacheManager.h"
#import "FMDB.h"

@interface YYCacheManager ()

@property (nonatomic, strong) FMDatabase *db;

@end

@implementation YYCacheManager

YYSingletonM(Cache)

- (instancetype)init {
    
    self = [super init];
    if (self) {
        // 获得数据库文件的路径
        NSString *doc = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
        NSString *fileName = [doc stringByAppendingPathComponent:@"collection.sqlite"];
        
        // 获得数据库
        FMDatabase *db = [FMDatabase databaseWithPath:fileName];
        
        // 打开数据库
        if ([db open]) {
            //4.创表
            BOOL result = [db executeUpdate:@"CREATE TABLE IF NOT EXISTS t_collection (id integer PRIMARY KEY AUTOINCREMENT, userId text NOT NULL, collection text NOT NULL);"];
            if (result) {
                NSLog(@"创表成功");
            }
            else {
                NSLog(@"创表失败");
            }
        }
        self.db = db;
    }
    return self;
}

// 添加
- (void)addInfo:(YYCacheModel *)application {
    
    //    NSString *key = [[BCEAppSettings instance] getUserInfo].userid;
    NSString *key = @"bWallet";
    
    if ([_instance query:key]) { // 修改
        
        NSArray<YYCacheModel *> *oldData = [_instance getCollectionList];
        NSMutableArray<YYCacheModel *> *newData = [[NSMutableArray alloc] initWithArray:oldData];
        [newData addObject:application];
        
        NSString *oldStr = [oldData yy_modelToJSONString];
        NSString *newStr = [newData yy_modelToJSONString];
        
        BOOL result = [self.db executeUpdate:@"update t_collection set collection = ? where collection = ?",newStr,oldStr];
        if (result) {
            NSLog(@"修改成功");
        } else {
            NSLog(@"修改失败");
        }
    }
    else { // 插入
        NSMutableArray<YYCacheModel *> *newData = [[NSMutableArray alloc] init];
        [newData addObject:application];
        
        NSString *dataStr = [newData yy_modelToJSONString];
        
        BOOL result = [self.db executeUpdate:@"INSERT INTO t_collection (userId, collection) VALUES (?,?)",key,dataStr];
        
        if (result) {
            NSLog(@"插入成功");
        } else {
            NSLog(@"插入失败");
        }
    }
}

// 移除
- (void)deleteInfo:(YYCacheModel *)application {
    
    NSArray<YYCacheModel *> *oldData = [_instance getCollectionList];
    NSMutableArray<YYCacheModel *> *newData = [[NSMutableArray alloc] init];
    
    for (YYCacheModel *model in oldData) {
        if (![application.modelId isEqualToString:model.modelId]) {
            [newData addObject:model];
        }
    }
    
    NSString *oldStr = [oldData yy_modelToJSONString];
    NSString *newStr = [newData yy_modelToJSONString];
    
    BOOL result = [self.db executeUpdate:@"update t_collection set collection = ? where collection = ?",newStr,oldStr];
    if (result) {
        NSLog(@"修改成功");
    } else {
        NSLog(@"修改失败");
    }
}

// 获取本地列表
- (NSArray<YYCacheModel *> *)getCollectionList {
    
    NSString *key = @"bWallet";
    NSString *jsonStr = @"";
    //查询整个表
    FMResultSet * resultSet = [_db executeQuery:@"select * from t_collection"];
    
    //遍历结果集合
    while ([resultSet next]) {
        //        NSString *userId = [resultSet objectForColumn:@"userId"];
        if ([key isEqualToString:[resultSet objectForColumn:@"userId"]]) {
            jsonStr = [resultSet objectForColumn:@"collection"];
        }
    }
    
    NSArray *detaArray = [NSArray yy_modelArrayWithClass:[YYCacheModel class] json:jsonStr];
    
    return detaArray;
}

// 是否已缓存
- (BOOL)isCollection:(NSString *)appId {
    
    NSArray<YYCacheModel *> *data = [_instance getCollectionList];
    
    for (YYCacheModel *model in data) {
        if ([appId isEqualToString:model.modelId]) {
            return YES;
        }
    }
    return NO;
}

- (BOOL)query:(NSString *)key {
    
    //查询整个表
    FMResultSet * resultSet = [_db executeQuery:@"select * from t_collection"];
    
    //遍历结果集合
    while ([resultSet next]) {
        //        NSString *userId = [resultSet objectForColumn:@"userId"];
        if ([key isEqualToString:[resultSet objectForColumn:@"userId"]]) {
            return YES;
        }
    }
    return NO;
}


@end

@implementation YYCacheModel

@end
