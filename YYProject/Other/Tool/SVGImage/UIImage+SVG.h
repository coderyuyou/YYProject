//
//  UIImage+SVG.h
//  YYProject
//
//  Created by 于优 on 2018/12/6.
//  Copyright © 2018 SuperYu. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (SVG)

/**
 show svg image
 
 @param name svg name
 @param size image size
 @return svg image
 */
+ (UIImage *)svgImageNamed:(NSString *)name size:(CGSize)size;

/**
 show svg image
 
 @param name svg name
 @param size image size
 @param tintColor image color
 @return svg image
 */
+ (UIImage *)svgImageNamed:(NSString *)name size:(CGSize)size tintColor:(UIColor *)tintColor;

@end

NS_ASSUME_NONNULL_END
