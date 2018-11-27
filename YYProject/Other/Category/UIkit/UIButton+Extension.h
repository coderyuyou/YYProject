//
//  UIButton+Extension.h
//  YYProject
//
//  Created by 于优 on 2018/11/27.
//  Copyright © 2018 SuperYu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (Extension)

/** 高亮背景颜色 */
@property (nonatomic, weak) UIColor *highLightBackgroundColor;
/** 被选中的背景颜色 */
@property (nonatomic, weak) UIColor *selectedBackgroundColor;
/** 不能点击时的背景颜色 */
@property (nonatomic, weak) UIColor *disabledBackgroundColor;
/** 点击按钮的回调 */
@property (nonatomic, copy) void(^clickHandle)(UIButton *btn);

/**
 *  给按钮添加事件
 *
 *  @param events      事件类型
 *  @param actionHandle 响应事件的回调
 */
- (void)addTargetWithEvents:(UIControlEvents)events
               actionHandle:(void(^)(UIButton *btn))actionHandle;

@end

