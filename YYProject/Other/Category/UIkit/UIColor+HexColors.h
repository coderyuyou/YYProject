//
//  UIColor+HexColors.h
//  MZB
//
//  Created by 吴文拼 on 2017/10/31.
//  Copyright © 2017年 吴文拼. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (HexColors)

+(UIColor *)colorWithHexString:(NSString *)hexString;
+(NSString *)hexValuesFromUIColor:(UIColor *)color;

@end
