//
//  YYWebSocke_IO.m
//  YYProject
//
//  Created by 于优 on 2018/12/6.
//  Copyright © 2018 SuperYu. All rights reserved.
//

#import "YYWebSockeIO.h"
#import "YYMarketModel.h"
#import "YYNetwork.h"

@import SocketIO;

@interface YYWebSockeIO () {
    int _index;
}

@property (nonatomic, strong) SocketManager *manager;
@property (nonatomic, strong) SocketIOClient *socket;
@property (nonatomic,copy) NSString *urlString;

@end

@implementation YYWebSockeIO

static YYWebSockeIO *_instance = nil;

NSString * const kNeedPayOrderNote = @"kNeedPayOrderNote";
NSString * const kWebSocketDidOpenNote = @"kWebSocketDidOpenNote";
NSString * const kWebSocketDidCloseNote = @"kWebSocketDidCloseNote";
NSString * const kWebSocketdidReceiveMessageNote = @"kWebSocketdidReceiveMessageNote";

+ (instancetype)sharedWebSockeIO {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[YYWebSockeIO alloc] init];
    });
    return _instance;
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [super allocWithZone:zone];
    });
    return _instance;
}

#pragma mark - public methods
- (void)webSocketOpenWithURLString:(NSString *)urlString {
    
    WEAKSELF;
    
    //如果是同一个url 或者为空
    if (self.socket || !urlString) {
        return;
    }
    
    self.urlString = urlString;
    
    NSURL* url = [[NSURL alloc] initWithString:urlString];
    self.manager = [[SocketManager alloc] initWithSocketURL:url config:@{@"log": @YES}];
    self.socket = self.manager.defaultSocket;
    
    [self.socket on:@"connect" callback:^(NSArray* data, SocketAckEmitter* ack) {
        NSLog(@"socket connected");
    }];
    
    [self.socket on:@"currentAmount" callback:^(NSArray* data, SocketAckEmitter* ack) {
        double cur = [[data objectAtIndex:0] floatValue];
        
        [[weakSelf.socket emitWithAck:@"canUpdate" with:@[@(cur)]] timingOutAfter:0 callback:^(NSArray* data) {
            [weakSelf.socket emit:@"update" with:@[@{@"amount": @(cur + 2.50)}]];
        }];
        
        [ack with:@[@"Got your currentAmount, ", @"dude"]];
    }];
    
    [self.socket on:@"ticker15m" callback:^(NSArray* data, SocketAckEmitter* ack) {
        
        NSDictionary *dic = [data.lastObject mj_JSONObject];
        ResponseModel *model = [[ResponseModel alloc] initWithResponse:dic];
        YYMarketModel *lastModel = [YYMarketModel mj_objectWithKeyValues:model.responseData];
        
        [[NSNotificationCenter defaultCenter] postNotificationName:kWebSocketdidReceiveMessageNote object:nil userInfo:@{@"key":lastModel}];
        
    }];
    
    [self.socket connect];
}

- (void)webSocketClose {
    //    [self.socket disconnect];
}


@end
