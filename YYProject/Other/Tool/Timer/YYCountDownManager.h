//
//  YYCountDownManager.h
//  YYProject
//
//  Created by 于优 on 2019/3/13.
//  Copyright © 2019 SuperYu. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/** 宏: 使用单例 */
#define kCountDownManager [YYCountDownManager share]
#define WEAKSELF __weak typeof(self) weakSelf = self

/** 倒计时的通知名 */
extern NSString *const YYCountDownNotification;

@interface YYCountDownManager : NSObject

/** 使用单例 */
+ (instancetype)share;

/** 开始倒计时 */
- (void)start;

/** 停止倒计时 */
- (void)invalidate;




// 增加后台模式, 后台状态下会继续计算时间差

/** 时间差(单位:秒) */
@property (nonatomic, assign) NSInteger timeInterval;

/** 刷新倒计时 */
- (void)reload;



// 增加identifier:标识符, 一个identifier支持一个倒计时源, 有一个单独的时间差

/** 添加倒计时源 */
- (void)addSourceWithIdentifier:(NSString *)identifier;

/** 获取时间差 */
- (NSInteger)timeIntervalWithIdentifier:(NSString *)identifier;

/** 刷新倒计时源 */
- (void)reloadSourceWithIdentifier:(NSString *)identifier;

/** 刷新所有倒计时源 */
- (void)reloadAllSource;

/** 清除倒计时源 */
- (void)removeSourceWithIdentifier:(NSString *)identifier;

/** 清除所有倒计时源 */
- (void)removeAllSource;

@end

@interface YYTimeInterval : NSObject

@end

NS_ASSUME_NONNULL_END
