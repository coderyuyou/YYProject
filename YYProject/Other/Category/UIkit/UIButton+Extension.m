//
//  UIButton+Extension.m
//  MyKeyboardDemo
//
//  Created by 樊小聪 on 16/8/1.
//  Copyright © 2016年 laitang. All rights reserved.
//

#import "UIButton+Extension.h"
#import <objc/runtime.h>


@interface _XCButtonTarget : NSObject

@property (copy, nonatomic) void(^actionHandle)(UIButton *btn);

- (instancetype)initWithActionHandle:(void(^)(UIButton *btn))actionHandle;
- (void)eventAction:(UIButton *)btn;

@end

@implementation _XCButtonTarget

- (instancetype)initWithActionHandle:(void (^)(UIButton *))actionHandle
{
    if (self = [super init])
    {
        self.actionHandle = [actionHandle copy];
    }
    
    return self;
}

- (void)eventAction:(UIButton *)btn
{
    if (self.actionHandle)
    {
        self.actionHandle(btn);
    }
}

@end


@implementation UIButton (Extension)

- (UIImage *)imageFromColor:(UIColor *)color frame:(CGRect)frame
{
    CGRect rect = CGRectMake(0, 0, frame.size.width, frame.size.height);
    
    // 开启一个 位图上下文
    UIGraphicsBeginImageContext(rect.size);
    
    // 获取当前的位图上下文
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    // 设置填充颜色
    CGContextSetFillColorWithColor(context, [color CGColor]);
    
    // 开始填充
    CGContextFillRect(context, rect);
    
    // 获得 当前上下文的图片
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    // 结束 位图上下文
    UIGraphicsEndImageContext();
    return image;
}

- (UIImage *)imageFromColor:(UIColor *)color
{
    return [self imageFromColor:color frame:CGRectMake(0, 0, 1, 1)];
}


- (void)setHighLightBackgroundColor:(UIColor *)highLightBackgroundColor
{
    objc_setAssociatedObject(self, @selector(highLightBackgroundColor), highLightBackgroundColor, OBJC_ASSOCIATION_ASSIGN);
    
    [self setBackgroundImage:[self imageFromColor:highLightBackgroundColor] forState:UIControlStateHighlighted];
}

- (UIColor *)highLightBackgroundColor
{
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setDisabledBackgroundColor:(UIColor *)disabledBackgroundColor
{
    objc_setAssociatedObject(self, @selector(disabledBackgroundColor), disabledBackgroundColor, OBJC_ASSOCIATION_ASSIGN);
    
    [self setBackgroundImage:[self imageFromColor:disabledBackgroundColor] forState:UIControlStateDisabled];
}

- (UIColor *)disabledBackgroundColor
{
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setSelectedBackgroundColor:(UIColor *)selectedBackgroundColor
{
    objc_setAssociatedObject(self, @selector(selectedBackgroundColor), selectedBackgroundColor, OBJC_ASSOCIATION_ASSIGN);
    
    [self setBackgroundImage:[self imageFromColor:selectedBackgroundColor] forState:UIControlStateSelected];
}

- (UIColor *)selectedBackgroundColor
{
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setClickHandle:(void (^)(UIButton *))clickHandle
{
    [self addTargetWithEvents:UIControlEventTouchUpInside actionHandle:clickHandle];
}

- (void (^)(UIButton *))clickHandle
{
    return [objc_getAssociatedObject(self, _cmd) actionHandle];
}

/**
 *  给按钮添加事件
 *
 *  @param events      事件类型
 *  @param actionHandle 响应事件的回调
 */
- (void)addTargetWithEvents:(UIControlEvents)events
               actionHandle:(void(^)(UIButton *btn))actionHandle
{
    _XCButtonTarget *target = [[_XCButtonTarget alloc] initWithActionHandle:actionHandle];
    
    objc_setAssociatedObject(self, @selector(clickHandle), target, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    [self addTarget:target action:@selector(eventAction:) forControlEvents:events];
}

@end




























