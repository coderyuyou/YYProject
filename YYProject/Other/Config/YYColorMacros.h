//
//  YYColorMacros.h
//  FZMGoldExchange
//
//  Created by 于优 on 2018/4/23.
//  Copyright © 2018年 FZM. All rights reserved.
//

#ifndef YYColorMacros_h
#define YYColorMacros_h

/** RGB颜色 */
#define kRGBColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]

/** RGBA颜色 */
#define kRGBAColor(r, g, b, a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)]

/** 随机色 */
#define kColor [UIColor colorWithRed:arc4random_uniform(255)/255.0 green:arc4random_uniform(255)/255.0 blue:arc4random_uniform(255)/255.0 alpha:1]

/** 十六进制颜色转为RGB */
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]


/** 透明 */
#define kClearColor [UIColor clearColor]
/** 主题黑颜色 */
#define kBlackColor UIColorFromRGB(0x232A4A)
/** 主题蓝颜色 */
#define kBlueColor UIColorFromRGB(0x5656D6)
/** 白色 */
#define kWhiteColor UIColorFromRGB(0xffffff)
/** 背景色 */
#define kBackgroundColor UIColorFromRGB(0xF7F7F7)
/** 蒙版背景色 */
#define kMaskViewColor kRGBAColor(0, 0, 0, 0.7)

/** 分割线 */
#define kLineColor UIColorFromRGB(0xEAEAEA)

/** tabbar */
#define kBabBarItemSeleColor UIColorFromRGB(0xf8cb47)
#define kBabBarItemColor UIColorFromRGB(0xe4e4e4)




///** 导航栏颜色 */
//#define kNavColor UIColorFromRGB()
///** 导航栏分割线 */
//#define kNavLineColor UIColorFromRGB()
///** TabBar颜色 */
//#define kTabBarColor UIColorFromRGB()


/** 一般字体颜色 */
#define kFontColor kBlackColor
/** 输入框字体颜色 */
#define kPlaceholderColor UIColorFromRGB(0x9194A4)
/** 一般灰色字体颜色 */
#define kFontColor_Gray UIColorFromRGB(0x9194A4)
/** 浅灰色字体颜色 */
#define kFontColor_Lightgary UIColorFromRGB(0xC7CCE6)
/** 主题色字体颜色 */
#define kFontColor_Theme UIColorFromRGB(0xf89e47)
/** 提醒字体颜色 */
#define kFontColor_Red UIColorFromRGB(0xFF0400)



#endif /* YYColorMacros_h */
