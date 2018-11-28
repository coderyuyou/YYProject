//
//  YYNavigationBarView.h
//  YYProject
//
//  Created by 于优 on 2018/11/28.
//  Copyright © 2018 SuperYu. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/**
 nav btnClick type.
 */
typedef NS_ENUM(NSUInteger, YYNavBtnClickType) {
    YYNavBtnClickTypeLeft = 0, ///< unknown
    YYNavBtnClickTypeRight,        ///< jpeg, jpg
};

@interface YYNavigationBarView : UIView

/** 导航栏颜色 */
@property (nonatomic, strong) UIColor *backgroundColor;
/** 导航栏图片 */
@property (nonatomic, strong) UIImage *backgroundImage;

/** 标题 */
@property (nonatomic, copy) NSString *title;
/** 标题字号 */
@property (nonatomic, strong) UIFont *titleFont;
/** 标题颜色 */
@property (nonatomic, strong) UIColor *titleColor;

/** 是否隐藏左边按钮 */
@property (nonatomic, assign) BOOL hiddenLeftBtn;
/** 左边按钮文字 */
@property (nonatomic, copy) NSString *leftBtnTitle;
/** 左边按钮文字字号 */
@property (nonatomic, strong) UIFont *leftBtnFont;
/** 左边按钮文字颜色 */
@property (nonatomic, strong) UIColor *leftBtnTitleColor;
/** 左边按钮图片 */
@property (nonatomic, strong) UIImage *leftBtnImage;

/** 右边按钮文字 */
@property (nonatomic, copy) NSString *rightBtnTitle;
/** 右边按钮文字字号 */
@property (nonatomic, strong) UIFont *rightBtnFont;
/** 右边按钮文字颜色 */
@property (nonatomic, strong) UIColor *rightBtnTitleColor;
/** 右边按钮图片 */
@property (nonatomic, strong) UIImage *rightBtnImage;

/** 导航栏分割线颜色 */
@property (nonatomic, strong) UIColor *seperateColor;
/** 导航栏分割线图片 */
@property (nonatomic, strong) UIImage *seperateImage;

+ (instancetype)shopView;

/** 导航栏按钮点击 */
@property (nonatomic, copy) void(^didNavBtnClickHandle)(YYNavBtnClickType type, UIButton *btn);

@end

NS_ASSUME_NONNULL_END
