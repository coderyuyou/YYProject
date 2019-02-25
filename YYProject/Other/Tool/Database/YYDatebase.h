//
//  YYDatebase.h
//  YYProject
//
//  Created by 于优 on 2019/2/18.
//  Copyright © 2019 SuperYu. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface YYDatebase : NSObject

YYSingletonH(Datebase)

// 添加
- (void)addData:(NSObject *)application;

// 移除
- (void)deleteData:(NSObject *)application;

// 获取列表
- (NSArray<NSObject *> *)getDataList;

// 是否已经保存
- (BOOL)isSave:(NSString *)Id;

@end

NS_ASSUME_NONNULL_END
