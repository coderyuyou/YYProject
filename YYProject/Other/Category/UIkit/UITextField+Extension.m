//
//  UITextField+Extension.m
//  YYProject
//
//  Created by 于优 on 2018/12/10.
//  Copyright © 2018 SuperYu. All rights reserved.
//

#import "UITextField+Extension.h"
#import <objc/runtime.h>
NSString * const YYTextFieldDidDeleteBackwardNotification = @"YYTextFieldDidDeleteBackwardNotification";

@implementation UITextField (Extension)

+ (void)load {
    // 交换2个方法中的IMP
    Method method1 = class_getInstanceMethod([self class], NSSelectorFromString(@"deleteBackward"));
    Method method2 = class_getInstanceMethod([self class], @selector(yy_deleteBackward));
    method_exchangeImplementations(method1, method2);
}

- (void)yy_deleteBackward {
    [self yy_deleteBackward];
    
    if ([self.delegate respondsToSelector:@selector(textFieldDidDeleteBackward:)]) {
        id <YYTextFieldDelegate> delegate  = (id<YYTextFieldDelegate>)self.delegate;
        [delegate textFieldDidDeleteBackward:self];
    }
    
    [[NSNotificationCenter defaultCenter] postNotificationName:YYTextFieldDidDeleteBackwardNotification object:self];
}

@end
