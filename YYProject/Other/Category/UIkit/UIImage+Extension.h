//
//  UIImage+Extension.h
//  YYProject
//
//  Created by 于优 on 2018/11/29.
//  Copyright © 2018 SuperYu. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (Extension)

/**
 *  获取矩形的渐变色的UIImage(此函数还不够完善)
 *
 *  @param bounds       UIImage的bounds
 *  @param colors       渐变色数组，可以设置两种颜色
 *  @param gradientType 渐变的方式：0--->从上到下   1--->从左到右
 *
 *  @return 渐变色的UIImage
 */
+ (UIImage *)gradientImageWithBounds:(CGRect)bounds andColors:(NSArray*)colors andGradientType:(NSInteger)gradientType;

@end

NS_ASSUME_NONNULL_END
