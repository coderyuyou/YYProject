//
//  UITextField+Extension.h
//  YYProject
//
//  Created by 于优 on 2018/12/10.
//  Copyright © 2018 SuperYu. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/**
 监听删除按钮
 */
extern NSString * const YYTextFieldDidDeleteBackwardNotification;

@protocol YYTextFieldDelegate <UITextFieldDelegate>

- (void)textFieldDidDeleteBackward:(UITextField *)textField;

@end

@interface UITextField (Extension)

@property (weak, nonatomic) id<YYTextFieldDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
