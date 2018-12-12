//
//  YYProgressHUD.m
//  YYProject
//
//  Created by 于优 on 2018/12/4.
//  Copyright © 2018 SuperYu. All rights reserved.
//

#import "YYProgressHUD.h"
#import "MBProgressHUD.h"
#import "YYHUDAnimationView.h"

@implementation YYProgressHUD

#pragma mark 显示一些信息

+ (void)showPlainText:(NSString *)text hideAfterDelay:(NSTimeInterval)time view:(nullable UIView *)view {
    
    if (view == nil) {
        view = [[UIApplication sharedApplication].windows lastObject];
    }
    // 快速显示一个提示信息
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.mode = MBProgressHUDModeText;
    hud.label.text = text;
    
    // 隐藏时候从父控件中移除
    hud.removeFromSuperViewOnHide = YES;
    
    // 1秒之后再消失
    [hud hideAnimated:YES afterDelay:time];
}

+ (void)showPlainText:(NSString *)text view:(nullable UIView *)view{
    [self showPlainText:text hideAfterDelay:1.0 view:view];
}

#pragma mark - 显示成功失败信息（打勾打叉动画）

+ (void)show:(nullable NSString *)text animationType:(YYHUDAnimationType)animationType hideAfterDelay:(NSTimeInterval)time view:(nullable UIView *)view {
    
    YYHUDAnimationView *suc = [[YYHUDAnimationView alloc] init];
    suc.animationType = animationType;
    [self showCustomView:suc message:text hideAfterDelay:time toView:view];
}

+ (void)showError:(nullable NSString *)error
      hideAfterDelay:(NSTimeInterval)time
              toView:(nullable UIView *)view {
    [self show:error animationType:YYHUDAnimationTypeError hideAfterDelay:time view:view];
}

+ (void)showError:(nullable NSString *)error toView:(nullable UIView *)view {
    [self showError:error hideAfterDelay:1.0 toView:nil];
}

+ (void)showError:(nullable NSString *)error {
    [self showError:error toView:nil];
}

+ (void)showError{
    [self showError:nil];
}

+ (void)showSuccess:(nullable NSString *)success
        hideAfterDelay:(NSTimeInterval)time
                toView:(nullable UIView *)view{
    [self show:success animationType:YYHUDAnimationTypeSuccess hideAfterDelay:time view:view];
}

+ (void)showSuccess:(nullable NSString *)success toView:(nullable UIView *)view {
    [self showSuccess:success hideAfterDelay:1.0 toView:view];
}

+ (void)showSuccess:(nullable NSString *)success {
    [self showSuccess:success toView:nil];
}

+ (void)showSuccess {
    [self showSuccess:nil];
}

#pragma mark - 有加载进度的HUD

+ (MBProgressHUD *)showActivityLoading:(nullable NSString *)message toView:(nullable UIView *)view {
    if (view == nil) {
        view = [[UIApplication sharedApplication].windows lastObject];
    }
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

+ (MBProgressHUD *)showActivityLoadingToView:(nullable UIView *)view {
    return [self showActivityLoading:nil toView:view];
}

+ (MBProgressHUD *)showActivityLoading {
    return [self showActivityLoadingToView:nil];
}

+ (MBProgressHUD *)showLoadingStyle:(YYHUDLoadingProgressStyle)style message:(nullable NSString *)message toView:(nullable UIView *)view {
    
    if (view == nil) {
        view = [[UIApplication sharedApplication].windows lastObject];
    }
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    
    switch (style) {
        case YYHUDLoadingStyleDeterminate:
            hud.mode = MBProgressHUDModeDeterminate;
            break;
        case YYHUDLoadingStyleDeterminateHorizontalBar:
            hud.mode = MBProgressHUDModeDeterminateHorizontalBar;
            break;
        case YYHUDLoadingStyleAnnularDeterminate:
            hud.mode = MBProgressHUDModeAnnularDeterminate;
            break;
    }
    
    dispatch_async(dispatch_get_global_queue(QOS_CLASS_USER_INITIATED, 0), ^{
        float progress = 0.0f;
        while (progress < 1.0f) {
            progress += 0.01f;
            dispatch_async(dispatch_get_main_queue(), ^{
                [MBProgressHUD HUDForView:view].progress = progress;
                // hud.labelText = [NSString stringWithFormat:@"正在加载...%.0f%%", progress * 100];
            });
            usleep(50000);
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [hud hideAnimated:YES];
        });
    });
    
    if (message) {
        hud.label.text = message;
    }
    
    // 隐藏时候从父控件中移除
    hud.removeFromSuperViewOnHide = YES;
    
    return hud;
}

+ (void)showLoadingStyle:(YYHUDLoadingProgressStyle)style message:(nullable NSString *)message {
    [self showLoadingStyle:style message:message toView:nil];
}

+ (MBProgressHUD *)showLoadingStyle:(YYHUDLoadingProgressStyle)style toView:(nullable UIView *)view {
    return [self showLoadingStyle:style message:nil toView:view];
}

+ (MBProgressHUD *)showLoadingStyle:(YYHUDLoadingProgressStyle)style {
    return [self showLoadingStyle:style toView:nil];
}


#pragma mark 显示带有自定义icon图片的消息

+ (void)showIcon:(UIImage *)icon message:(NSString *)message hideAfterDelay:(NSTimeInterval)time view:(nullable UIView *)view {
    
    if (view == nil) {
        view = [[UIApplication sharedApplication].windows lastObject];
    }
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

+ (void)showIcon:(UIImage *)icon message:(NSString *)message view:(nullable UIView *)view {
    [self showIcon:icon message:message hideAfterDelay:1.0 view:view];
}


+ (void)showIcon:(UIImage *)icon message:(NSString *)message {
    [self showIcon:icon message:message view:nil];
}


#pragma mark 自定义View的方法

+ (void)showCustomView:(UIView *)customView message:(nullable NSString *)message hideAfterDelay:(NSTimeInterval)time toView:(nullable UIView *)view {
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

+ (void)showCustomView:(UIView *)customView hideAfterDelay:(NSTimeInterval)time toView:(nullable UIView *)view {
    [self showCustomView:customView message:nil hideAfterDelay:time toView:view];
}

+ (void)showCustomView:(UIView *)customView hideAfterDelay:(NSTimeInterval)time{
    [self showCustomView:customView message:nil hideAfterDelay:time toView:nil];
}


+ (void)showMessage:(nullable NSString *)message hideAfterDelay:(NSTimeInterval)time toView:(nullable UIView *)view customView:(UIView *(^)(void))customView{
    [self showCustomView:customView() message:message hideAfterDelay:time toView:view];
}

+ (void)showHideAfterDelay:(NSTimeInterval)time customView:(UIView *(^)(void))customView {
    [self showCustomView:customView() hideAfterDelay:time toView:nil];
}


#pragma mark 隐藏HUD

+ (void)hideHUDForView:(nullable UIView *)view {
    if (view == nil) {
        view = [[UIApplication sharedApplication].windows lastObject];
    }
    [MBProgressHUD hideHUDForView:view animated:YES];
}

+ (void)hideHUD {
    [self hideHUDForView:nil];
}



@end
