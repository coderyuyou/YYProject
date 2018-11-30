//
//  UIView+Extension.h
//  YYProject
//
//  Created by 于优 on 2018/11/27.
//  Copyright © 2018 SuperYu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, UIBorderSideType) {
    UIBorderSideTypeAll    = 0,
    UIBorderSideTypeTop    = 1 << 0,
    UIBorderSideTypeBottom = 1 << 1,
    UIBorderSideTypeLeft   = 1 << 2,
    UIBorderSideTypeRight  = 1 << 3,
};

IB_DESIGNABLE

@interface UIView (Extension)

/** frame.origin.x */
@property (nonatomic) CGFloat left;

/** frame.origin.y */
@property (nonatomic) CGFloat top;

/** frame.origin.x + frame.size.width */
@property (nonatomic) CGFloat right;

/** frame.origin.y + frame.size.height */
@property (nonatomic) CGFloat bottom;

/** frame.size.width */
@property (nonatomic) CGFloat width;

/** frame.size.height */
@property (nonatomic) CGFloat height;

/** center.x */
@property (nonatomic) CGFloat centerX;

/** center.y */
@property (nonatomic) CGFloat centerY;

/** frame.origin */
@property (nonatomic) CGPoint origin;

/** frame.origin.size */
@property (nonatomic) CGSize  size;

/** frame.origin.x */
@property (nonatomic) CGFloat x;

/** frame.origin.y */
@property (nonatomic) CGFloat y;

@property (nonatomic, assign) IBInspectable CGFloat borderWidth;
@property (nonatomic, assign) IBInspectable UIColor *borderColor;
@property (nonatomic, assign) IBInspectable CGFloat cornerRadius;

/**
 添加手势事件
 */
@property (nonatomic, copy, nullable) void(^tapGestureHandle)(UITapGestureRecognizer * _Nullable gesture, UIView * _Nullable tapView);

/**
 获取父控制器
 */
- (UIViewController *)parentController;

/**
 移除所有子视图
 */
- (void)removeAllSubviews;

/**
 给 UIView 的图层添加阴影

 @param color 阴影颜色
 @param offset 阴影的偏移量
 @param radius 阴影的渐变距离
 */
- (void)setLayerShadow:(UIColor *)color offset:(CGSize)offset radius:(CGFloat)radius;

/**
 给 UIView 的图层添加边框

 @param color 边框颜色
 @param borderWidth 边框宽度
 @param borderType 边框类型
 */
- (void)setLayerBorder:(UIColor *)color borderWidth:(CGFloat)borderWidth borderType:(UIBorderSideType)borderType;

/**
 给 UIView 绘制圆角

 @param cornerRadius 圆角度数
 */
- (void)setLayerRoundedRect:(CGFloat)cornerRadius;

/**
 给 UIView 绘制指定位置圆角

 @param rect 绘制view的bounds
 @param corners 绘制view的位置
 UIRectCornerTopLeft     = 1 << 0,
 UIRectCornerTopRight    = 1 << 1,
 UIRectCornerBottomLeft  = 1 << 2,
 UIRectCornerBottomRight = 1 << 3,
 UIRectCornerAllCorners  = ~0UL
 @param cornerRadii 圆角的Size(width有效)
 */
- (void)setLayerBezierPath:(CGRect)rect corners:(UIRectCorner)corners cornerRadii:(CGSize)cornerRadii;


@end

NS_ASSUME_NONNULL_END
