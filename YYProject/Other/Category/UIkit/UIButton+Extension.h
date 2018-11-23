//
//  UIButton+Extension.h
//  MyKeyboardDemo
//
//  Created by 樊小聪 on 16/8/1.
//  Copyright © 2016年 laitang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (Extension)

/** 👀 高亮背景颜色 👀 */
@property (weak, nonatomic) UIColor *highLightBackgroundColor;

/** 👀 被选中的背景颜色 👀 */
@property (weak, nonatomic) UIColor *selectedBackgroundColor;

/** 👀 不能点击时的背景颜色 👀 */
@property (weak, nonatomic) UIColor *disabledBackgroundColor;

/** 👀 点击按钮的回调 👀 */
@property (copy, nonatomic) void(^clickHandle)(UIButton *btn);


/**
 *  给按钮添加事件
 *
 *  @param events      事件类型
 *  @param actionHandle 响应事件的回调
 */
- (void)addTargetWithEvents:(UIControlEvents)events
               actionHandle:(void(^)(UIButton *btn))actionHandle;

@end
