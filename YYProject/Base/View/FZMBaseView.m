
//
//  FZMBaseView.m
//  FZMGoldExchange
//
//  Created by 于优 on 2018/4/24.
//  Copyright © 2018年 FZM. All rights reserved.
//

#import "FZMBaseView.h"

@implementation FZMBaseView

+ (UIView *)createNormalView:(UIColor *)backgroundColor cornerRadius:(CGFloat)cornerRadius {
    
    UIView *view = [UIView new];
    view.backgroundColor = backgroundColor;
    if (cornerRadius > 0) {
        view.layer.cornerRadius = cornerRadius;
    }
    
    return view;
}

+ (UIImageView *)createNormalImageView:(UIImage *)image cornerRadius:(CGFloat)cornerRadius {
    
    UIImageView *imageView = [[UIImageView alloc] init];
    if (image) {
        imageView.image = image;
    }
    if (cornerRadius > 0) {
        imageView.layer.cornerRadius = cornerRadius;
    }
    return imageView;
}

+ (UITextField *)createNormalTextField:(NSString *)placeholder placeholderSize:(NSInteger)placeholderSize placeholderColor:(UIColor *)placeholderColor textSize:(NSInteger)textSize textColor:(UIColor *)textColor {
    
    UITextField *textField = [UITextField new];
    textField.font = FONT_SIZE(textSize);
    textField.textColor = textColor;
    
    textField.placeholder = placeholder;
    [textField setValue:placeholderColor forKeyPath:@"_placeholderLabel.textColor"];
    [textField setValue:FONT_SIZE(placeholderSize) forKeyPath:@"_placeholderLabel.font"];

    textField.borderStyle = UITextBorderStyleNone;
    textField.clearButtonMode = UITextFieldViewModeWhileEditing;
//    textField.keyboardType = UIKeyboardTypeURL;
    
    return textField;
}

+ (UILabel *)createNormalLab:(NSString *)title font:(UIFont *)font titleColor:(UIColor *)titleColor textAlignment:(NSTextAlignment)textAlignment {
    
    UILabel *lab = [UILabel new];
    lab.text = title;
    lab.font = font;
    lab.textColor = titleColor;
    lab.textAlignment = textAlignment;
    
    return lab;
}


+ (UIButton *)createImgBtn:(UIImage *)image_N image_S:(UIImage *)image_S {
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [btn setImage:image_N forState:UIControlStateNormal];

    if (image_S) {
        [btn setImage:image_S forState:UIControlStateSelected];
    }
//    if (cornerRadius > 0) {
//        btn.layer.masksToBounds = YES;
//        btn.layer.cornerRadius = cornerRadius;
//    }
    
    return btn;
}

+ (UIButton *)createNormalBtn:(NSString *)title fontSize:(CGFloat)fontSize titleColor:(UIColor *)titleColor backgroundColor:(UIColor *)backgroundColor cornerRadius:(CGFloat)cornerRadius {
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:titleColor forState:UIControlStateNormal];
    btn.titleLabel.font = FONT_SIZE(fontSize);
    
    if (backgroundColor) {
        btn.backgroundColor = backgroundColor;
    }
    if (cornerRadius > 0) {
        btn.layer.masksToBounds = YES;
        btn.layer.cornerRadius = cornerRadius;
    }
    
    return btn;
}

+ (UISegmentedControl *)createSegmentedControl:(NSArray<NSString *> *)titleArray {
    
    UISegmentedControl *segmentedControl = [[UISegmentedControl alloc] initWithItems:titleArray];
    segmentedControl.selectedSegmentIndex = 0;
    segmentedControl.tintColor = kBlackColor;
    
    // 选择后的字体颜色
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:kFontColor_Gray,
                         NSForegroundColorAttributeName,
                         [UIFont systemFontOfSize:14],
                         NSFontAttributeName,nil];
    
    [segmentedControl setTitleTextAttributes:dic forState:UIControlStateSelected];
    
    // 默认字体颜色
    NSDictionary *dic1 = [NSDictionary dictionaryWithObjectsAndKeys:kFontColor,
                          NSForegroundColorAttributeName,
                          [UIFont systemFontOfSize:14],
                          NSFontAttributeName,nil];
    
    [segmentedControl setTitleTextAttributes:dic1 forState:UIControlStateNormal];
    
    return segmentedControl;
}


@end
