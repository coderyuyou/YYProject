//
//  UIImage+Extension.m
//  YYProject
//
//  Created by 于优 on 2018/11/29.
//  Copyright © 2018 SuperYu. All rights reserved.
//

#import "UIImage+Extension.h"

@implementation UIImage (Extension)

+ (UIImage *)gradientImageWithBounds:(CGRect)bounds andColors:(NSArray*)colors andGradientType:(NSInteger)gradientType {
    
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
        case 0:
            start = CGPointMake(0.0, 0.0);
            end = CGPointMake(0.0, bounds.size.height);
            break;
        case 1:
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
