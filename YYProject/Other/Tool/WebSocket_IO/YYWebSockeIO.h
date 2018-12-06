//
//  YYWebSocke_IO.h
//  YYProject
//
//  Created by 于优 on 2018/12/6.
//  Copyright © 2018 SuperYu. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

extern NSString * const kNeedPayOrderNote;
extern NSString * const kWebSocketDidOpenNote;
extern NSString * const kWebSocketDidCloseNote;
extern NSString * const kWebSocketdidReceiveMessageNote;

@interface YYWebSockeIO : NSObject

/** 获取连接状态 */
//@property (nonatomic,assign,readonly) SRReadyState socketReadyState;

+ (instancetype)sharedWebSockeIO;

/** 开启连接 */
- (void)webSocketOpenWithURLString:(NSString *)urlString;
/** 关闭连接 */
- (void)webSocketClose;
/** 发送数据 */
//- (void)sendData:(id)data;

@end

NS_ASSUME_NONNULL_END
