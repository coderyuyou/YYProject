//
//  UIFont+Extension.m
//  YYProject
//
//  Created by 于优 on 2018/12/3.
//  Copyright © 2018 SuperYu. All rights reserved.
//

#import "UIFont+Extension.h"

@implementation UIFont (Extension)

+ (UIFont *)fitConfigure:(CGFloat)fontSize {
    return [self fitFontName:@"PingFangSC-Regular" fontSize:fontSize];
}

+ (UIFont *)fitBoldConfigure:(CGFloat)fontSize {
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    CGFloat resultFontSize = fontSize * width / 375;
    return [UIFont boldSystemFontOfSize:resultFontSize];
}

+ (UIFont *)fitFontName:(NSString *)fontName fontSize:(CGFloat)fontSize {
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    CGFloat resultFontSize = fontSize * width / 375;
    UIFont *resultFont = [UIFont fontWithName:fontName size:resultFontSize];
    return resultFont;
}

@end
