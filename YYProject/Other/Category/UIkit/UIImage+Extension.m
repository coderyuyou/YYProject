//
//  UIImage+Extension.m
//  YYProject
//
//  Created by 于优 on 2018/11/29.
//  Copyright © 2018 SuperYu. All rights reserved.
//

#import "UIImage+Extension.h"

@implementation UIImage (Extension)

+ (UIImage *)imageWithColor:(UIColor *)color {
    
    //描述一个矩形
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    //开启图形上下文
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, 0);
    //获得图形上下文
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    //使用color演示填充上下文
    CGContextSetFillColorWithColor(ctx, [color CGColor]);
    //渲染上下文
    CGContextFillRect(ctx, rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    //关闭图形上下文
    UIGraphicsEndImageContext();
    
    return image;
}

+ (UIImage *)snapshotImage:(UIView *)view {
    UIGraphicsBeginImageContextWithOptions(view.bounds.size, view.opaque, 0);
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *snap = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return snap;
}

+ (UIImage *)snapshotImageAfterScreenUpdates:(BOOL)afterUpdates operateView:(UIView *)view {
    if (CGRectIsEmpty(view.frame)) {
        // 因为设置为YES后,这些方法会等在view update结束在执行,如果在update结束前view被release了,会出现找不到view而引起崩溃
        return nil;
    }
    
    if (![self respondsToSelector:@selector(drawViewHierarchyInRect:afterScreenUpdates:)]) {
        return [self snapshotImage:view];
    }
    UIGraphicsBeginImageContextWithOptions(view.bounds.size, view.opaque, 0);
    [view drawViewHierarchyInRect:view.bounds afterScreenUpdates:afterUpdates];
    UIImage *snap = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return snap;
}

+ (UIImage *)gradientImageWithBounds:(CGRect)bounds colors:(NSArray<UIColor *> *)colors gradientType:(UIGradientType)gradientType {
    
    NSMutableArray *ar = [[NSMutableArray alloc] init];
    for(UIColor *c in colors) {
        [ar addObject:(id)c.CGColor];
    }
    
    UIGraphicsBeginImageContextWithOptions(bounds.size, YES, 1);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);
    CGColorSpaceRef colorSpace = CGColorGetColorSpace([[colors lastObject] CGColor]);
    CGGradientRef gradient = CGGradientCreateWithColors(colorSpace, (CFArrayRef)ar, NULL);
    CGPoint start = CGPointZero;
    CGPoint end = CGPointZero;
    
    switch (gradientType) {
        case UIGradientTypeVertical:
            start = CGPointMake(0.0, 0.0);
            end = CGPointMake(0.0, bounds.size.height);
            break;
        case UIGradientTypeTransverse:
            start = CGPointMake(0.0, 0.0);
            end = CGPointMake(bounds.size.width, 0.0);
            break;
    }
    
    CGContextDrawLinearGradient(context, gradient, start, end, kCGGradientDrawsBeforeStartLocation | kCGGradientDrawsAfterEndLocation);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    CGGradientRelease(gradient);
    CGContextRestoreGState(context);
    CGColorSpaceRelease(colorSpace);
    UIGraphicsEndImageContext();
    
    return image;
}


@end
