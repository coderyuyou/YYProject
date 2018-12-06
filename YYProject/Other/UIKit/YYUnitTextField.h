//
//  YYUnitTextField.h
//  YYProject
//
//  Created by 于优 on 2018/11/29.
//  Copyright © 2018 SuperYu. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger,YYUnitAlignment){
    YYUnitAlignmentLeft = 0,
    YYUnitAlignmentRight,
};

@interface YYUnitTextField : UIView

/** 输入内容 */
@property (nonatomic, strong) NSString *contentNumber;
/** placeholder文字颜色 */
@property (nonatomic, strong) UIColor *placeholderColor;
/** 输入文字颜色 */
@property (nonatomic, strong) UIColor *textColor;

/** 监听输入 */
@property (nonatomic, copy) void(^didTextValueDidChangedHandle)(UITextField *textField);

- (instancetype)initUnitTextFieldWith:(YYUnitAlignment)alignment unit:(NSString *)unit;

@end

NS_ASSUME_NONNULL_END
