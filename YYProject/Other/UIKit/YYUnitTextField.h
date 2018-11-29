//
//  YYUnitTextField.h
//  YYProject
//
//  Created by 于优 on 2018/11/29.
//  Copyright © 2018 SuperYu. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface YYUnitTextField : UIView

/** 输入内容 */
@property (nonatomic, strong) NSString *contentNumber;

/** 监听输入 */
@property (nonatomic, copy) void(^didTextValueDidChangedHandle)(UITextField *textField);

@end

NS_ASSUME_NONNULL_END
