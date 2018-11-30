//
//  UIColor+Extension.h
//  YYProject
//
//  Created by 于优 on 2018/11/27.
//  Copyright © 2018 SuperYu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (Extension)

/**
 通过十六进制获取颜色

 @param hexString 十六进制色值
 @return Color
 */
+ (UIColor *)colorWithHexString:(NSString *)hexString;

/**
 通过十六进制获取颜色
 注：hexString:支持@“#123456”、 @“0X123456”、 @“123456”三种格式
 @param hexString 十六进制色值
 @param alpha 透明度
 @return Color
 */
+ (UIColor *)colorWithHexString:(NSString *)hexString alpha:(CGFloat)alpha;

/**
 通过颜色获取十六进制

 @param color 颜色
 @return 十六进制String
 */
+ (NSString *)hexValuesFromUIColor:(UIColor *)color;

@end

