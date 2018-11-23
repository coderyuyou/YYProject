//
//  ERConstants.h
//  EasyRent
//
//  Created by 于优 on 2018/8/9.
//  Copyright © 2018年 EasyRent. All rights reserved.
//

#ifndef ERConstants_h
#define ERConstants_h

// ----------  Enum  ----------

// 角色登录状态
typedef NS_ENUM(NSInteger, ApplicationLoginState) {
    ApplicationLoginStateLogin = 1,      // 已登录
    ApplicationLoginStateNotLogged,      // 未登录
    ApplicationLoginStateVisitors        // 访客模式
};


// ----------  Notification  ----------

/** 登录通知 */
static NSString *const kLoginNotification = @"kLoginNotification";

// ----------  Value  ----------

/** 一般边距 */
static const CGFloat kNormalMargin = 20;
/** 边距 */
static const CGFloat kSubMargin = 15;
/** 短信倒计时 */
static const NSTimeInterval kMessageCountdown = 30;
/** 数据刷新时间 */
static const NSTimeInterval kUploadTime = 0.3;

#endif /* ERConstants_h */
