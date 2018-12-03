//
//  UIFont+Extension.h
//  YYProject
//
//  Created by 于优 on 2018/12/3.
//  Copyright © 2018 SuperYu. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIFont (Extension)

/**
 根据屏幕宽度自适应字体大小
 
 @param font 需要设置的字体大小
 @return 返回对应的字体
 */
+ (UIFont *)fitConfigure:(CGFloat)font;


/**
 根据屏幕宽度自适应粗体字体大小
 
 @param font 需要设置的字体大小
 @return 返回对应的字体
 */
+ (UIFont *)fitBoldConfigure:(CGFloat)font;


/**
 根据屏幕的宽度自适应自定义字体大小
 
 @param fontName 需要的字体类型
 @param fontSize 需要设置的字体大小
 @return 返回对应的字体
 */
+ (UIFont *)fitFontName:(NSString *)fontName fontSize:(CGFloat)fontSize;

@end

NS_ASSUME_NONNULL_END
