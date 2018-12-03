//
//  MBProgressHUD+Extension.h
//  YYProject
//
//  Created by 于优 on 2018/12/3.
//  Copyright © 2018 SuperYu. All rights reserved.
//

#import "MBProgressHUD.h"

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, YYHUDLoadingProgressStyle) {
    YYHUDLoadingProgressStyleDeterminate, // 开扇型加载进度
    YYHUDLoadingStyleDeterminateHorizontalBar, // 横条加载进度
    YYHUDLoadingStyleAnnularDeterminate, // 环形加载进度
};

@interface MBProgressHUD (Extension)

#pragma mark - 显示纯文本信息

/**
 只显示纯文本信息, 默认 1 秒后消失
 
 @param text 消息文本
 @param view 展示的View
 */
+ (void)yy_showPlainText:(NSString *)text view:(nullable UIView *)view;

#pragma mark - 显示操作成功或失败信息（自定义view打勾打叉动画）

/**
 显示失败信息，同时有打叉的动画, 默认 1 秒后消失
 
 @param error 错误信息提示文本
 @param view 展示的View
 */
+ (void)yy_showError:(nullable NSString *)error toView:(nullable UIView *)view;

/**
 显示失败信息，同时有打叉的动画，默认 1 秒后消失
 
 @param error 错误信息提示文本
 */
+ (void)yy_showError:(nullable NSString *)error;

/**
 只显示打叉动画HUD，默认 1 秒后消失
 */
+ (void)yy_showError;

/**
 显示成功信息，同时会有一个打勾的动画, 默认 1s 后消失
 
 @param success 成功信息提示文本
 @param view 展示的View
 */
+ (void)yy_showSuccess:(nullable NSString *)success toView:(nullable UIView *)view;
/**
 显示成功信息，同时会有一个打勾的动画, 默认 1s 后消失
 
 @param success 成功信息提示文本
 */
+ (void)yy_showSuccess:(nullable NSString *)success;

/**
 只显示打勾动画HUD，默认 1s 后消失
 */
+ (void)yy_showSuccess;

#pragma mark - 自己设置提示信息的 图标

/**
 显示带有自定义icon图标消息HUD, 默认 1s 后消失
 
 @param icon 图标
 @param message 消息正文
 @param view 展示的view
 */
+ (void)yy_showIcon:(UIImage *)icon
            message:(NSString *)message
               view:(nullable UIView *)view;

/**
 显示带有自定义icon图标消息HUD, 默认 1s 后消失
 
 @param icon 图标
 @param message 消息正文
 */
+ (void)yy_showIcon:(UIImage *)icon message:(NSString *)message;


#pragma mark - 有加载进度的HUD
/**
 显示菊花加载状态，不会自动消失，在需要移除的时候调用 yy_hideHUDForView: 等移除方法
 
 @param message 消息正文
 @param view 展示的view
 @return MBProgressHUD对象，可以通过它调用MBProgressHUD中的方法
 */
+ (instancetype)yy_showActivityLoading:(nullable NSString *)message
                                toView:(nullable UIView *)view;

/**
 只显示菊花加载动画，不会自动消失，在需要移除的时候调用 yy_hideHUDForView: 等移除方法
 
 @return MBProgressHUD对象，可以通过它调用MBProgressHUD中的方法
 */
+ (instancetype)yy_showActivityLoading;


/**
 加载进度的HUD，设置HUD的progress请通过 HUD 对象调用 showAnimated: whileExecutingBlock: 等方法
 
 使用举例：
 MBProgressHUD *hud = [MBProgressHUD yy_showLoadingStyle:WJHUDLoadingProgressStyleDeterminate message:@"正在加载..." toView:nil];
 [hud showAnimated:YES whileExecutingBlock:^{
 float progress = 0.0f;
 while (progress < 1.0f) {
 hud.progress = progress;
 hud.labelText = [NSString stringWithFormat:@"正在加载...%.0f%%", progress * 100];
 progress += 0.01f;
 usleep(50000);
 }
 } completionBlock:^{
 [MBProgressHUD yy_hideHUD];
 // [hud removeFromSuperViewOnHide];
 }];
 
 @param style 进度条样式
 @param message 消息正文，传nil不显示
 @param view 展示的View
 @return MBProgressHUD对象，可以通过它调用MBProgressHUD中的方法
 */
+ (instancetype)yy_showLoadingStyle:(YYHUDLoadingProgressStyle)style
                            message:(nullable NSString *)message
                             toView:(nullable UIView *)view;

/**
 只显示加载进度的HUD，不显示消息文本，设置HUD的progress请通过 HUD 对象调用 showAnimated: whileExecutingBlock: 等方法
 
 @param style 进度条样式
 @return MBProgressHUD对象，可以通过它调用MBProgressHUD中的方法
 */
+ (instancetype)yy_showLoadingStyle:(YYHUDLoadingProgressStyle)style;

#pragma mark - 自定义HUD中显示的view

/**
 自定义HUD中显示的view
 
 @param customView 自定义的view
 @param message 消息正文，传nil只显示自定义的view在HUD上
 @param time HUD展示时长
 @param view 展示的view
 */
+ (void)yy_showCustomView:(UIView *)customView
                  message:(nullable NSString *)message
           hideAfterDelay:(NSTimeInterval)time
                   toView:(nullable UIView *)view;

+ (void)yy_showCustomView:(UIView *)customView
           hideAfterDelay:(NSTimeInterval)time
                   toView:(nullable UIView *)view;

+ (void)yy_showCustomView:(UIView *)customView
           hideAfterDelay:(NSTimeInterval)time;

/**
 自定义HUD中显示的view, 闭包返回自定义的View
 
 @param message 消息正文
 @param time HUD展示时长
 @param view 展示的view
 @param customView 返回自定义UIView
 */
+ (void)yy_showMessage:(nullable NSString *)message
        hideAfterDelay:(NSTimeInterval)time
                toView:(nullable UIView *)view
            customView:(UIView *(^)(void))customView;

+ (void)yy_showHideAfterDelay:(NSTimeInterval)time
                   customView:(UIView *(^)(void))customView;



#pragma mark - 移除HUD
/**
 从view上移除HUD
 
 @param view 展示HUD的View
 */
+ (void)yy_hideHUDForView:(nullable UIView *)view;
/**
 从当前展示的View上移除HUD
 */
+ (void)yy_hideHUD;

@end

NS_ASSUME_NONNULL_END
