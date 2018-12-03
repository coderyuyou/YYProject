//
//  YYHUDAnimationView.m
//  YYProject
//
//  Created by 于优 on 2018/12/3.
//  Copyright © 2018 SuperYu. All rights reserved.
//

#import "YYHUDAnimationView.h"

@interface YYHUDAnimationView ()

/** shape */
@property (nonatomic, strong) CAShapeLayer *shapeLayer;
/** animation */
@property (nonatomic, strong) CABasicAnimation *animation;

@end

@implementation YYHUDAnimationView

- (void)drawLine {
    
    //半径
    //    CGFloat radius = self.frame.size.width / 2;
    
    //    CGFloat x = self.center.x;
    //    CGFloat y = self.center.y;
    
    CGFloat radius = 20;
    CGFloat x = 20;
    CGFloat y = 20;
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    if (_animationType == YYHUDAnimationTypeSuccess) {
        [path moveToPoint:CGPointMake(x - radius + 5, y)];
        [path addLineToPoint:CGPointMake(x - 3, y + 10)];
        [path addLineToPoint:CGPointMake(x + radius - 5, y - 10)];
    } else if (_animationType == YYHUDAnimationTypeError) {
        [path moveToPoint:CGPointMake(radius / 2, radius / 2)];
        [path addLineToPoint:CGPointMake(radius + radius / 2, radius + radius / 2)];
        [path moveToPoint:CGPointMake(radius / 2, radius + radius / 2)];
        [path addLineToPoint:CGPointMake(radius + radius / 2, radius / 2)];
    }
    
    self.shapeLayer.path = path.CGPath;
    [self.layer addSublayer:self.shapeLayer];
    
    [self.shapeLayer addAnimation:self.animation forKey:@"strokeEnd"];
}

- (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size {
    
    //描述一个矩形
    CGRect rect = CGRectMake(0.0f, 0.0f, size.width, size.height);
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

#pragma mark - ****  setter & getter  ****

- (void)setAnimationType:(YYHUDAnimationType)animationType {
    _animationType = animationType;
    
    // 1.0.0 之后的版本，在自定义view的frame被设置后无法被add到hud上。 btn,以及确定图片size的imageView可以被adds上。 所以这里先这样处理
    self.image = [self imageWithColor:[UIColor clearColor] size:CGSizeMake(40, 40)];
    
    [self drawLine];
}

- (CAShapeLayer *)shapeLayer {
    if (!_shapeLayer) {
        _shapeLayer = [CAShapeLayer layer];
//        _shapeLayer.path = path.CGPath;
        //线条颜色
        _shapeLayer.strokeColor = [UIColor whiteColor].CGColor;
        //填充颜色
        _shapeLayer.fillColor = [UIColor clearColor].CGColor;
        _shapeLayer.lineWidth = 4.0;
        // 设置线帽为圆
        _shapeLayer.lineCap = @"round";
        _shapeLayer.strokeStart = 0.0;
        // 该属性为 1.0 就是完成显示出来，可以通过给他动画就实现画线条出来。
        _shapeLayer.strokeEnd = 0.0;
    }
    return _shapeLayer;
}

- (CABasicAnimation *)animation {
    if (!_animation) {
        _animation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
        [_animation setFromValue:@0.0];
        [_animation setToValue:@1.0];
        [_animation setDuration:0.5];
        //当动画结束后,layer会一直保持着动画最后的状态
        _animation.removedOnCompletion = NO;
        _animation.fillMode = kCAFillModeForwards;
    }
    return _animation;
}

@end
