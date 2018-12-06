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
#define kColorRGB(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]

/** RGBA颜色 */
#define kColorRGBA(r, g, b, a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)]

/** 十六进制颜色 */
#define kColorHex(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

/** 随机色 */
#define kColor [UIColor colorWithRed:arc4random_uniform(255)/255.0 green:arc4random_uniform(255)/255.0 blue:arc4random_uniform(255)/255.0 alpha:1]


/** 透明 */
#define kClearColor [UIColor clearColor]
/** 白色 */
#define kWhiteColor kColorHex(0xffffff)
/** 主题黑颜色 */
#define kBlackColor kColorHex(0x232A4A)
/** 主题蓝颜色 */
#define kBlueColor kColorHex(0x5656D6)
/** 主题棕颜色 */
#define kBrownColor kColorHex(0x6f480f)
/** 主题黄颜色 */
#define kThemeColor kColorHex(0xf8d147)
/** 背景色 */
#define kBackgroundColor kColorHex(0xF7F7F7)
/** 蒙版背景色 */
#define kMaskViewColor kColorRGBA(0, 0, 0, 0.7)

/** K线红 */
#define kCandlestickRedColor kColorHex(0xbe2f1f)
/** K线绿 */
#define kCandlestickGreenColor kColorHex(0x58ac83)

/** 分割线 */
#define kLineColor kColorHex(0xEAEAEA)

/** tabbar */
#define kBabBarItemSeleColor kColorHex(0xf8cb47)
#define kBabBarItemColor kColorHex(0xe4e4e4)

///** 导航栏颜色 */
//#define kNavColor kColorHex()
///** 导航栏分割线 */
//#define kNavLineColor kColorHex()
///** TabBar颜色 */
//#define kTabBarColor kColorHex()


/** 一般字体颜色 */
#define kFontColor kBlackColor
/** 输入框字体颜色 */
#define kPlaceholderColor kColorHex(0x9194A4)
/** 一般灰色字体颜色 */
#define kFontColor_Gray kColorHex(0x9194A4)
/** 浅灰色字体颜色 */
#define kFontColor_Lightgary kColorHex(0xC7CCE6)
/** 主题色字体颜色 */
#define kFontColor_Theme kColorHex(0xf89e47)
/** 提醒字体颜色 */
#define kFontColor_Red kColorHex(0xFF0400)



#endif /* YYColorMacros_h */
