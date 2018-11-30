//
//  UIView+Extension.m
//  YYProject
//
//  Created by 于优 on 2018/11/27.
//  Copyright © 2018 SuperYu. All rights reserved.
//

#import "UIView+Extension.h"
#import <objc/runtime.h>

@implementation UIView (Extension)

- (CGFloat)left {
    return self.frame.origin.x;
}

- (void)setLeft:(CGFloat)x {
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}

- (CGFloat)top {
    return self.frame.origin.y;
}

- (void)setTop:(CGFloat)y {
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}

- (CGFloat)right {
    return self.frame.origin.x + self.frame.size.width;
}

- (void)setRight:(CGFloat)right {
    CGRect frame = self.frame;
    frame.origin.x = right - frame.size.width;
    self.frame = frame;
}

- (CGFloat)bottom {
    return self.frame.origin.y + self.frame.size.height;
}

- (void)setBottom:(CGFloat)bottom {
    CGRect frame = self.frame;
    frame.origin.y = bottom - frame.size.height;
    self.frame = frame;
}

- (CGFloat)width {
    return self.frame.size.width;
}

- (void)setWidth:(CGFloat)width {
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}

- (CGFloat)height {
    return self.frame.size.height;
}

- (void)setHeight:(CGFloat)height {
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}

- (CGFloat)centerX {
    return self.center.x;
}

- (void)setCenterX:(CGFloat)centerX {
    self.center = CGPointMake(centerX, self.center.y);
}

- (CGFloat)centerY {
    return self.center.y;
}

- (void)setCenterY:(CGFloat)centerY {
    self.center = CGPointMake(self.center.x, centerY);
}

- (CGPoint)origin {
    return self.frame.origin;
}

- (void)setOrigin:(CGPoint)origin {
    CGRect frame = self.frame;
    frame.origin = origin;
    self.frame = frame;
}

- (CGSize)size {
    return self.frame.size;
}

- (void)setSize:(CGSize)size {
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}

- (CGFloat)x {
    return self.frame.origin.x;
}
- (void)setX:(CGFloat)x {
    CGRect tempRect = self.frame;
    tempRect.origin.x = x;
    self.frame = tempRect;
}

- (CGFloat)y {
    return self.frame.origin.y;
}


- (void)setY:(CGFloat)y {
    CGRect tempRect = self.frame;
    tempRect.origin.y = y;
    self.frame = tempRect;
}

- (CGFloat)borderWidth {
    return self.borderWidth;
}

- (void)setBorderWidth:(CGFloat)borderWidth {
    
    if (borderWidth < 0) {
        return;
    }
    self.layer.borderWidth = borderWidth;
}

- (UIColor *)borderColor {
    return self.borderColor;
}

- (void)setBorderColor:(UIColor *)borderColor {
    self.layer.borderColor = borderColor.CGColor;
}

- (CGFloat)cornerRadius {
    return self.cornerRadius;
}

- (void)setCornerRadius:(CGFloat)cornerRadius {
    self.layer.cornerRadius = cornerRadius;
    self.layer.masksToBounds = YES;
}

static char event_key;

- (void (^)(UITapGestureRecognizer *, UIView *))tapGestureHandle {
    return objc_getAssociatedObject(self, &event_key);
}

- (void)setTapGestureHandle:(void (^)(UITapGestureRecognizer *, UIView *))tapGestureHandle {
    self.userInteractionEnabled = YES;
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTapHandle:)];
    
    [self addGestureRecognizer:tapGesture];
    
    objc_setAssociatedObject(self, &event_key, tapGestureHandle, OBJC_ASSOCIATION_COPY);
}

- (void)didTapHandle:(UITapGestureRecognizer *)tap {
    void (^tapGestureHandle)(UITapGestureRecognizer *tap, UIView *tapView) = objc_getAssociatedObject(self, &event_key);
    
    if (tapGestureHandle) {
        tapGestureHandle(tap, tap.view);
    }
}

- (UIViewController *)parentController {
    UIResponder *responder = [self nextResponder];
    while (responder) {
        if ([responder isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)responder;
        }
        responder = [responder nextResponder];
    }
    return nil;
}

- (void)removeAllSubviews {
    for (UIView * view in self.subviews) {
        [view removeFromSuperview];
    }
}

- (void)setLayerShadow:(UIColor *)color offset:(CGSize)offset radius:(CGFloat)radius {
    // 阴影颜色
    self.layer.shadowColor = color.CGColor;
    // 阴影的偏移量
    self.layer.shadowOffset = offset;
    // shadow 的渐变距离，从外围开始，往里渐变 shadowRadius 距离
    self.layer.shadowRadius = radius;
    // 阴影的透明效果
    self.layer.shadowOpacity = 1;
    
    self.layer.shouldRasterize = YES;
    self.layer.rasterizationScale = [UIScreen mainScreen].scale;
}

- (void)setLayerBorder:(UIColor *)color borderWidth:(CGFloat)borderWidth borderType:(UIBorderSideType)borderType {
    if (borderType == UIBorderSideTypeAll) {
        self.layer.borderWidth = borderWidth;
        self.layer.borderColor = color.CGColor;
    }
    
    /// 线的路径
    UIBezierPath * bezierPath = [UIBezierPath bezierPath];
    
    /// 左侧
    if (borderType & UIBorderSideTypeLeft) {
        /// 左侧线路径
        [bezierPath moveToPoint:CGPointMake(0.0f, self.frame.size.height)];
        [bezierPath addLineToPoint:CGPointMake(0.0f, 0.0f)];
    }
    
    /// 右侧
    if (borderType & UIBorderSideTypeRight) {
        /// 右侧线路径
        [bezierPath moveToPoint:CGPointMake(self.frame.size.width, 0.0f)];
        [bezierPath addLineToPoint:CGPointMake(self.frame.size.width, self.frame.size.height)];
    }
    
    /// top
    if (borderType & UIBorderSideTypeTop) {
        /// top线路径
        [bezierPath moveToPoint:CGPointMake(0.0f, 0.0f)];
        [bezierPath addLineToPoint:CGPointMake(self.frame.size.width, 0.0f)];
    }
    
    /// bottom
    if (borderType & UIBorderSideTypeBottom) {
        /// bottom线路径
        [bezierPath moveToPoint:CGPointMake(0.0f, self.frame.size.height)];
        [bezierPath addLineToPoint:CGPointMake(self.frame.size.width, self.frame.size.height)];
    }
    
    CAShapeLayer * shapeLayer = [CAShapeLayer layer];
    shapeLayer.strokeColor = color.CGColor;
    shapeLayer.fillColor  = [UIColor clearColor].CGColor;
    /// 添加路径
    shapeLayer.path = bezierPath.CGPath;
    /// 线宽度
    shapeLayer.lineWidth = borderWidth;
    
    [self.layer addSublayer:shapeLayer];
}

- (void)setLayerRoundedRect:(CGFloat)cornerRadius {
    self.layer.cornerRadius = cornerRadius;
    self.layer.masksToBounds = NO;
}

- (void)setLayerBezierPath:(CGRect)rect corners:(UIRectCorner)corners cornerRadii:(CGSize)cornerRadii {
    
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:rect byRoundingCorners:corners cornerRadii:cornerRadii];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = self.bounds;
    maskLayer.path = maskPath.CGPath;
    self.layer.mask = maskLayer;
}

@end
