//
//  YYPolling.h
//  YYProject
//
//  Created by 于优 on 2018/12/6.
//  Copyright © 2018 SuperYu. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

extern NSString * const kPollingdidReceiveMessageNote;

@interface YYPolling : NSObject

+ (instancetype)sharedPolling;

/** 开启轮询 */
- (void)pollingOpen;
/** 关闭轮询 */
- (void)pollingClose;

@end

NS_ASSUME_NONNULL_END
