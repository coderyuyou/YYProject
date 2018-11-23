//
//  FZMBaseView.h
//  FZMGoldExchange
//
//  Created by 于优 on 2018/4/24.
//  Copyright © 2018年 FZM. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FZMBaseView : UIView

+ (UIView *)createNormalView:(UIColor *)backgroundColor cornerRadius:(CGFloat)cornerRadius;

+ (UIImageView *)createNormalImageView:(UIImage *)image cornerRadius:(CGFloat)cornerRadius;

+ (UITextField *)createNormalTextField:(NSString *)placeholder placeholderSize:(NSInteger)placeholderSize placeholderColor:(UIColor *)placeholderColor textSize:(NSInteger)textSize textColor:(UIColor *)textColor;

+ (UILabel *)createNormalLab:(NSString *)title font:(UIFont *)font titleColor:(UIColor *)titleColor textAlignment:(NSTextAlignment)textAlignment;

/** 图片按钮 */
+ (UIButton *)createImgBtn:(UIImage *)image_N image_S:(UIImage *)image_S;
/** 一般按钮 */
+ (UIButton *)createNormalBtn:(NSString *)title fontSize:(CGFloat)fontSize titleColor:(UIColor *)titleColor backgroundColor:(UIColor *)backgroundColor cornerRadius:(CGFloat)cornerRadius;

+ (UISegmentedControl *)createSegmentedControl:(NSArray<NSString *> *)titleArray;

@end
