//
//  UIImage+Extension.h
//  YYProject
//
//  Created by 于优 on 2018/11/29.
//  Copyright © 2018 SuperYu. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, UIGradientType) {
    UIGradientTypeVertical    = 0, //从上到下
    UIGradientTypeTransverse    = 1, //从左到右
};

@interface UIImage (Extension)

/**
 根据颜色生成一张图片

 @param color 提供的颜色
 @param size 绘制大小
 @return 指定颜色的UIImage
 */
+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size;

/**
 截取当前视图

 @param view 目标View
 @return 截屏Image
 */
+ (UIImage *)snapshotImage:(UIView *)view;
//NS_DEPRECATED_IOS(2_0,2_0, "推荐使用 snapshotImageAfterScreenUpdates:方法" )__TVOS_PROHIBITED

/**
 截取当前视图
 Create a snapshot image of the complete view hierarchy.
 discussion It's faster than "snapshotImage", but may cause screen updates.
 See -[UIView drawViewHierarchyInRect:afterScreenUpdates:] for more information.
 
 @param afterUpdates 是否在view update结束后执行
 @return 截屏Image
 */
+ (UIImage *)snapshotImageAfterScreenUpdates:(BOOL)afterUpdates operateView:(UIView *)view;

/**
 获取矩形的渐变色的UIImage

 @param bounds UIImage的bounds
 @param colors 渐变色数组
 @param gradientType 渐变的方式
 @return 渐变色的UIImage
 */
+ (UIImage *)gradientImageWithBounds:(CGRect)bounds colors:(NSArray<UIColor *> *)colors gradientType:(UIGradientType)gradientType;

@end

NS_ASSUME_NONNULL_END
