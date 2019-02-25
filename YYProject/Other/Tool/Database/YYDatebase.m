//
//  YYDatebase.m
//  YYProject
//
//  Created by 于优 on 2019/2/18.
//  Copyright © 2019 SuperYu. All rights reserved.
//

#import "YYDatebase.h"
#import "FMDB.h"

@interface YYDatebase ()

/**  */
@property (nonatomic, strong) FMDatabase *db;

@end

@implementation YYDatebase

YYSingletonM(Datebase)

- (instancetype)init {
    
    self = [super init];
    if (self) {
        //1.获得数据库文件的路径
        NSString *doc = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
        NSString *fileName = [doc stringByAppendingPathComponent:@"collection.sqlite"];
        
        //2.获得数据库
        FMDatabase *db = [FMDatabase databaseWithPath:fileName];
        
        //3.打开数据库
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

@end

