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

/** ---------- 单例 ---------- */
// .h文件
#define YYSingletonH(name) + (instancetype)shared##name;

// .m文件
#define YYSingletonM(name) \
static id _instance; \
\
+ (instancetype)allocWithZone:(struct _NSZone *)zone { \
static dispatch_once_t onceToken; \
dispatch_once(&onceToken, ^{ \
_instance = [super allocWithZone:zone]; \
}); \
return _instance; \
} \
\
+ (instancetype)shared##name { \
static dispatch_once_t onceToken; \
dispatch_once(&onceToken, ^{ \
_instance = [[self alloc] init]; \
}); \
return _instance; \
} \
\
- (id)copyWithZone:(NSZone *)zone { \
return _instance; \
}

/** ---------- UI 相关 ---------- */

/** 当前屏幕宽度 */
#define kScreen_Width [UIScreen mainScreen].bounds.size.width
/** 当前屏幕高度 */
#define kScreen_Height [UIScreen mainScreen].bounds.size.height

/** iPhone4S */
#define kDevice_iPhone4S ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 960), [[UIScreen mainScreen] currentMode].size) : NO)

/** iPhone5 iPhone5s iPhoneSE */
#define kDevice_iPhoneSE ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)

/** iPhone6 iPhone7 iPhone8 */
#define kDevice_iPhone ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? (CGSizeEqualToSize(CGSizeMake(750, 1334), [[UIScreen mainScreen] currentMode].size) || CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size)) : NO)

/** iPhone6plus  iPhone7plus iPhone8plus */
#define kDevice_iPhonePlus ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? (CGSizeEqualToSize(CGSizeMake(1125, 2001), [[UIScreen mainScreen] currentMode].size) || CGSizeEqualToSize(CGSizeMake(1242, 2208), [[UIScreen mainScreen] currentMode].size)) : NO)

/** iphoneX */
#define kDevice_iPhoneX ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO)
/** iphoneXR */
#define kDevice_iPhoneXR ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(828, 1792), [[UIScreen mainScreen] currentMode].size) : NO)
/** iphoneXS */
#define kDevice_iPhoneXS ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO)
/** iphoneXSMax */
#define kDevice_iPhoneXSMax ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2688), [[UIScreen mainScreen] currentMode].size) : NO)

/** 异形屏系列 */
#define kDevice_iPhoneXSeries (kDevice_iPhoneX || kDevice_iPhoneXR || kDevice_iPhoneXS || kDevice_iPhoneXSMax)

/** 视图底部偏移量 */
#define kBottomOffset (kDevice_iPhoneXSeries ? 34 : 0)

/** 状态栏 */
#define kStatusBarSize [UIApplication sharedApplication].statusBarFrame.size
#define kStatusBarWdth kStatusBarSize.width
#define kStatusBarHeight kStatusBarSize.height

/** NavBar高度 */
#define kNavigationBarHeight 44.0f

/** TabBar高度 */
#define kTabBarHeight (kDevice_iPhoneXSeries ? (49.f + 34.f) : 49.0f)

/** 状态栏 ＋ 导航栏 高度 */
#define kStatusAndNavigationBarHeitht (kStatusBarHeight + kNavigationBarHeight)

/** 缩放比分割线 */
#define kLineHeight (1 / [UIScreen mainScreen].scale)

/** 获取window */
#define kWindow [UIApplication sharedApplication].keyWindow

/** ---------- tool 相关 ---------- */

/** 获取系统版本 */
#define kiOS_VERSION [[[UIDevice currentDevice] systemVersion] floatValue]

/** 某版本及以上 */
#define IS_iOS(value) (([[[UIDevice currentDevice] systemVersion] floatValue] >= value) ? YES : NO)

//[[UIDevice currentDevice].systemVersion floatValue] = value

/** __weak */
#define WEAKSELF __weak typeof(self) weakSelf = self
#define WeakSelf(self) __weak __typeof(self) weakSelf = self

/** 检查是否为空对象 */
#define YYCHECK_NULL(object) ([object isKindOfClass:[NSNull class]]?nil:object)
/** 空对象 赋予空字符串 */
#define YYNullClass(object) (object?object:@"")

/** 多语言 */
#define YYLocalizedString(key, comment) [[NSBundle mainBundle] localizedStringForKey:(key) value:@"" table:nil]

#endif /* YYUtilsMacros_h */
