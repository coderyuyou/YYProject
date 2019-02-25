//
//  YYCacheManager.h
//  YYProject
//
//  Created by 于优 on 2018/12/6.
//  Copyright © 2018 SuperYu. All rights reserved.
//

#import <Foundation/Foundation.h>
@class YYCacheModel;
NS_ASSUME_NONNULL_BEGIN

@interface YYCacheManager : NSObject

YYSingletonH(Cache)

// 添加
- (void)addInfo:(YYCacheModel *)application;

// 移除
- (void)deleteInfo:(YYCacheModel *)application;

// 获取本地列表
- (NSArray<YYCacheModel *> *)getCollectionList;

// 是否已缓存
- (BOOL)isCollection:(NSString *)appId;

@end

@interface YYCacheModel : NSObject
/** id */
@property (nonatomic,strong) NSString *modelId;

@end

NS_ASSUME_NONNULL_END
