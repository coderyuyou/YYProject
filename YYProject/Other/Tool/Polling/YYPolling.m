//
//  YYPolling.m
//  YYProject
//
//  Created by 于优 on 2018/12/6.
//  Copyright © 2018 SuperYu. All rights reserved.
//

#import "YYPolling.h"
#import "HWWeakTimer.h"
#import "YYMarketModel.h"
#import "YYNetwork.h"

@interface YYPolling ()

/** 定时器 */
@property (nonatomic, strong) NSTimer *timer;

@end

@implementation YYPolling

NSString * const kPollingdidReceiveMessageNote = @"kPollingdidReceiveMessageNote";

YYSingletonM(Polling)

- (void)pollingOpen {
    
    // 开启轮询
    WEAKSELF;
    _timer = [HWWeakTimer scheduledTimerWithTimeInterval:10 block:^(id userInfo) {
        // 获取最新数据
        [weakSelf requestNewData];
        
    } userInfo:nil repeats:YES];
}

- (void)requestNewData {
    
    [[YYNetwork sharedNetwork]requestWithPath:BASEURL(MARKET_GetTicker5m) method:RequestTypeGet parameters:@{} success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        
        YYMarketModel *lastModel = [YYMarketModel mj_objectWithKeyValues:responseObject[@"data"]];
        
        [[NSNotificationCenter defaultCenter] postNotificationName:kPollingdidReceiveMessageNote object:nil userInfo:@{@"key":lastModel}];
        
    } failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error) {
        
    }];
}


- (void)pollingClose {
    
    [_timer invalidate];
    _timer = nil;
}



@end
