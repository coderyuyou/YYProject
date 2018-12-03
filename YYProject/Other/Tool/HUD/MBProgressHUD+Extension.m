//
//  MBProgressHUD+Extension.m
//  YYProject
//
//  Created by 于优 on 2018/12/3.
//  Copyright © 2018 SuperYu. All rights reserved.
//

#import "MBProgressHUD+Extension.h"
#import "YYHUDAnimationView.h"

@implementation MBProgressHUD (Extension)

#pragma mark 显示一些信息
/**
 只显示文字
 */
+ (void)yy_showPlainText:(NSString *)text view:(nullable UIView *)view{
    [self yy_showPlainText:text hideAfterDelay:1.0 view:view];
}

+ (void)yy_showPlainText:(NSString *)text
          hideAfterDelay:(NSTimeInterval)time
                    view:(nullable UIView *)view {
    
    if (view == nil) view = [[UIApplication sharedApplication].windows lastObject];
    // 快速显示一个提示信息
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.mode = MBProgressHUDModeText;
    hud.label.text = text;
    
    // 隐藏时候从父控件中移除
    hud.removeFromSuperViewOnHide = YES;
    
    // 1秒之后再消失
    [hud hideAnimated:YES afterDelay:time];
}

#pragma mark - 显示成功失败信息（打勾打叉动画）

+ (void)show:(nullable NSString *)text animationType:(YYHUDAnimationType)animationType hideAfterDelay:(NSTimeInterval)time view:(nullable UIView *)view {
    
    YYHUDAnimationView *suc = [[YYHUDAnimationView alloc] init];
    suc.animationType = animationType;
    [MBProgressHUD yy_showCustomView:suc message:text hideAfterDelay:time toView:view];
}

+ (void)yy_showError:(nullable NSString *)error
      hideAfterDelay:(NSTimeInterval)time
              toView:(nullable UIView *)view {
    [self show:error animationType:YYHUDAnimationTypeError hideAfterDelay:time view:view];
}

+ (void)yy_showError:(nullable NSString *)error toView:(nullable UIView *)view {
    [self yy_showError:error hideAfterDelay:1.0 toView:nil];
}

+ (void)yy_showError:(nullable NSString *)error {
    [self yy_showError:error toView:nil];
}

+ (void)yy_showError{
    [self yy_showError:nil];
}

+ (void)yy_showSuccess:(nullable NSString *)success
        hideAfterDelay:(NSTimeInterval)time
                toView:(nullable UIView *)view{
    [self show:success animationType:YYHUDAnimationTypeSuccess hideAfterDelay:time view:view];
}

+ (void)yy_showSuccess:(nullable NSString *)success toView:(nullable UIView *)view {
    [self yy_showSuccess:success hideAfterDelay:1.0 toView:view];
}

+ (void)yy_showSuccess:(nullable NSString *)success {
    [self yy_showSuccess:success toView:nil];
}

+ (void)yy_showSuccess {
    [self yy_showSuccess:nil];
}

#pragma mark - 有加载进度的HUD

/**
 显示菊花加载状态
 
 @param message 消息正文
 @param view 展示的view
 */
+ (instancetype)yy_showActivityLoading:(nullable NSString *)message toView:(nullable UIView *)view {
    if (view == nil) view = [[UIApplication sharedApplication].windows lastObject];
    // 快速显示一个提示信息
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    // 默认
    hud.mode = MBProgressHUDModeIndeterminate;
    
    if (message) {
        hud.label.text = message;
    }

    // 隐藏时候从父控件中移除
    hud.removeFromSuperViewOnHide = YES;
    
    return hud;
}

+ (instancetype)yy_showActivityLoadingToView:(nullable UIView *)view {
    return [self yy_showActivityLoading:nil toView:view];
}

+ (instancetype)yy_showActivityLoading {
    return [self yy_showActivityLoadingToView:nil];
}

+ (instancetype)yy_showLoadingStyle:(YYHUDLoadingProgressStyle)style message:(nullable NSString *)message toView:(nullable UIView *)view{
    
    if (view == nil) view = [[UIApplication sharedApplication].windows lastObject];
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    
    switch (style) {
        case YYHUDLoadingProgressStyleDeterminate:
            hud.mode = MBProgressHUDModeDeterminate;
            break;
        case YYHUDLoadingStyleDeterminateHorizontalBar:
            hud.mode = MBProgressHUDModeDeterminateHorizontalBar;
            break;
        case YYHUDLoadingStyleAnnularDeterminate:
            hud.mode = MBProgressHUDModeAnnularDeterminate;
            break;
    }
    
    if (message) {
        hud.label.text = message;
    }
    
    // 隐藏时候从父控件中移除
    hud.removeFromSuperViewOnHide = YES;
    
    return hud;
}

+ (instancetype)yy_showLoadingStyle:(YYHUDLoadingProgressStyle)style toView:(nullable UIView *)view {
    return [self yy_showLoadingStyle:style message:nil toView:view];
}

+ (instancetype)yy_showLoadingStyle:(YYHUDLoadingProgressStyle)style {
    return [self yy_showLoadingStyle:style toView:nil];
}


#pragma mark 显示带有自定义icon图片的消息

+ (void)yy_showIcon:(UIImage *)icon
            message:(NSString *)message
     hideAfterDelay:(NSTimeInterval)time
               view:(nullable UIView *)view{
    
    if (view == nil) view = [[UIApplication sharedApplication].windows lastObject];
    
    // 快速显示一个提示信息
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    // 默认
    //    hud.mode = MBProgressHUDModeIndeterminate;
    hud.label.text = message;
    // 设置图片
    hud.customView = [[UIImageView alloc] initWithImage:icon];
    // 再设置模式
    hud.mode = MBProgressHUDModeCustomView;
    
    
    // 隐藏时候从父控件中移除
    hud.removeFromSuperViewOnHide = YES;
    
    // 1秒之后再消失
    [hud hideAnimated:YES afterDelay:time];
}

/**
 显示带有自定义icon图标消息HUD
 
 @param icon 图标
 @param message 消息正文
 @param view 展示的view
 */
+ (void)yy_showIcon:(UIImage *)icon message:(NSString *)message view:(nullable UIView *)view{
    //    if (view == nil) view = [[UIApplication sharedApplication].windows lastObject];
    //    // 快速显示一个提示信息
    //    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    //    // 默认
    //    //    hud.mode = MBProgressHUDModeIndeterminate;
    //    hud.labelText = message;
    //    // 设置图片
    //    hud.customView = [[UIImageView alloc] initWithImage:icon];
    //    // 再设置模式
    //    hud.mode = MBProgressHUDModeCustomView;
    //
    //
    //    // 隐藏时候从父控件中移除
    //    hud.removeFromSuperViewOnHide = YES;
    //
    //    // 1秒之后再消失
    //    [hud hide:YES afterDelay:1.0];
    
    [self yy_showIcon:icon message:message hideAfterDelay:1.0 view:view];
    
}


+ (void)yy_showIcon:(UIImage *)icon message:(NSString *)message{
    [self yy_showIcon:icon message:message view:nil];
}


#pragma mark 自定义View的方法

+ (void)yy_showCustomView:(UIView *)customView message:(nullable NSString *)message hideAfterDelay:(NSTimeInterval)time toView:(nullable UIView *)view
{
    if (view == nil) {
        view = [[UIApplication sharedApplication].windows lastObject];
    }
    // 快速显示一个提示信息
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    // 置模式
    hud.mode = MBProgressHUDModeCustomView;
    
    // 设置自定义view
    hud.customView = customView;
    
    hud.square = YES;

    if (message) {
        hud.label.text = message;
    }
    
    // 隐藏时候从父控件中移除
    hud.removeFromSuperViewOnHide = YES;
    // 消失时间
    [hud hideAnimated:YES afterDelay:time];
}

+ (void)yy_showCustomView:(UIView *)customView hideAfterDelay:(NSTimeInterval)time toView:(nullable UIView *)view {
    [self yy_showCustomView:customView message:nil hideAfterDelay:time toView:view];
}

+ (void)yy_showCustomView:(UIView *)customView hideAfterDelay:(NSTimeInterval)time{
    [self yy_showCustomView:customView message:nil hideAfterDelay:time toView:nil];
}


+ (void)yy_showMessage:(nullable NSString *)message hideAfterDelay:(NSTimeInterval)time toView:(nullable UIView *)view customView:(UIView *(^)(void))customView{
    
    [self yy_showCustomView:customView() message:message hideAfterDelay:time toView:view];
}

+ (void)yy_showHideAfterDelay:(NSTimeInterval)time customView:(UIView *(^)(void))customView {
    
    [self yy_showCustomView:customView() hideAfterDelay:time toView:nil];
}


#pragma mark 隐藏HUD

+ (void)yy_hideHUDForView:(nullable UIView *)view {
    [self hideHUDForView:view animated:YES];
}

+ (void)yy_hideHUD {
    [self yy_hideHUDForView:nil];
}


@end
