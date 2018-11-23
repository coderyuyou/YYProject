//
//  YYUtilsMacros.h
//  FZMGoldExchange
//
//  Created by 于优 on 2018/4/23.
//  Copyright © 2018年 FZM. All rights reserved.
//

#ifndef YYUtilsMacros_h
#define YYUtilsMacros_h

#if DEBUG
#define YYLog(format, ...) do {                                             \
fprintf(stderr, "<%s : line(%d)> %s\n",     \
[[[NSString stringWithUTF8String:__FILE__] lastPathComponent] UTF8String],  \
__LINE__, __func__);                        \
printf("%s\n", [[NSString stringWithFormat:format, ##__VA_ARGS__] UTF8String]);           \
fprintf(stderr, "-------------------\n");   \
} while (0)
#else
#define YYLog(format, ...) nil
#endif

/** ---------- UI 相关 ---------- */

/** 当前屏幕宽度 */
#define kScreen_Width [UIScreen mainScreen].bounds.size.width
/** 当前屏幕高度 */
#define kScreen_Height [UIScreen mainScreen].bounds.size.height

/** iPhone4S */
#define kDevice_Is_iPhone4S ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 960), [[UIScreen mainScreen] currentMode].size) : NO)

/** iPhone5 iPhone5s iPhoneSE */
#define kDevice_Is_iPhoneSE ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)

/** iPhone6 iPhone7 iPhone8 */
#define kDevice_Is_iPhone ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? (CGSizeEqualToSize(CGSizeMake(750, 1334), [[UIScreen mainScreen] currentMode].size) || CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size)) : NO)

/** iPhone6plus  iPhone7plus iPhone8plus */
#define kDevice_Is_iPhonePlus ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? (CGSizeEqualToSize(CGSizeMake(1125, 2001), [[UIScreen mainScreen] currentMode].size) || CGSizeEqualToSize(CGSizeMake(1242, 2208), [[UIScreen mainScreen] currentMode].size)) : NO)

/** iphoneX */
#define kDevice_Is_iPhoneX ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO)

/** 状态栏高度 */
#define STATUS_BAR_SIZE [UIApplication sharedApplication].statusBarFrame.size
#define STATUS_BAR_WIDTH MAX(STATUS_BAR_SIZE.height, STATUS_BAR_SIZE.width)
#define kStatusBarHeight MIN(STATUS_BAR_SIZE.height, STATUS_BAR_SIZE.width)

/** NavBar高度 */
#define kNavigationBarHeight 44.0f

/** TabBar高度 */
#define kTabBarHeight (kDevice_Is_iPhoneX ? (49.f + 34.f) : 49.0f)

/** 状态栏 ＋ 导航栏 高度 */
#define kStatusAndNavigationBarHeitht ((kStatusBarHeight) + (kNavigationBarHeight))

/** 缩放比分割线 */
#define kLineHeight (1 / [UIScreen mainScreen].scale)

/** 获取window */
#define kWindow [UIApplication sharedApplication].keyWindow

/** ---------- tool 相关 ---------- */

/** __weak */
#define WEAKSELF __weak typeof(self) weakSelf = self
#define WeakSelf(self) __weak __typeof(self) weakSelf = self;

/** 检查是否为空对象 */
#define YYCHECK_NULL(object) ([object isKindOfClass:[NSNull class]]?nil:object)
/** 空对象 赋予空字符串 */
#define YYNullClass(object) (object?object:@"")

#define FZMLocalizedString(key, comment) [[NSBundle mainBundle] localizedStringForKey:(key) value:@"" table:nil]

#endif /* YYUtilsMacros_h */
