//
//  YYUnitTextField.m
//  YYProject
//
//  Created by 于优 on 2018/11/29.
//  Copyright © 2018 SuperYu. All rights reserved.
//

#import "YYUnitTextField.h"

@interface YYUnitTextField ()<UITextFieldDelegate>

@property (nonatomic, strong) UILabel *unitLab;

@property (nonatomic, strong) UITextField *textField;

@end

@implementation YYUnitTextField {
    UIColor *_placeholderColor;
    UIColor *_textColor;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        _placeholderColor = kFontColor_Gray;
        _textColor = kFontColor;
        [self createView];
    }
    return self;
}

- (void)createView {
    
    CGFloat rightLabWidth = [self stringWidthWithText:self.unitLab.text font:[UIFont systemFontOfSize:24]];
    self.unitLab.frame = CGRectMake(0, 0, rightLabWidth, 30);
    self.textField.rightView = self.unitLab;
    self.textField.rightViewMode = UITextFieldViewModeAlways;
    
    CGFloat textFieldWidth = [self stringWidthWithText:@"0.00" font:[UIFont systemFontOfSize:24]] + rightLabWidth;
    [self addSubview:self.textField];
    [self.textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self).offset(0);
        make.centerX.mas_equalTo(self);
        make.width.mas_offset(textFieldWidth);
    }];
}

#pragma mark - Delegate

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    //    if ([textField.text isEqualToString:@"0.00"]) {
    //        textField.text = @"";
    //    }
    
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    
    self.contentNumber = textField.text;
}

- (void)textValueDidChanged:(UITextField *)textField {
    
    if (textField.text.length < 1) {
        self.unitLab.textColor = _placeholderColor;
    }
    else {
        self.unitLab.textColor = _textColor;
    }
    if (self.didTextValueDidChangedHandle) {
        self.didTextValueDidChangedHandle(textField);
    }
    
    [self changeTextFieldWidth:textField];
}

#pragma mark - Action

- (void)changeTextFieldWidth:(UITextField *)textField {
    
    NSString *text = (textField.text.length > 1)?textField.text:@"0.00";
    
    CGFloat textFieldWidth = [self stringWidthWithText:text font:[UIFont systemFontOfSize:24]] + [self stringWidthWithText:self.unitLab.text font:[UIFont systemFontOfSize:24]];
    
    if (textFieldWidth <= self.frame.size.width) {
        [self.textField mas_updateConstraints:^(MASConstraintMaker *make) {
            make.width.mas_offset(textFieldWidth);
        }];
        UIFont *font = [UIFont systemFontOfSize:24];
        CGFloat labWidth = [self stringWidthWithText:@"CNY" font:font];
        self.unitLab.frame = CGRectMake(0, 0, labWidth, 30);
        self.textField.font = font;
        self.unitLab.font = font;
    } else {
        [self.textField mas_updateConstraints:^(MASConstraintMaker *make) {
            make.width.mas_offset(self.frame.size.width);
        }];
        UIFont *font = [self getFontWithText:text];
        CGFloat labWidth = [self stringWidthWithText:@"CNY" font:font];
        self.unitLab.frame = CGRectMake(0, 0, labWidth, 30);
        self.textField.font = font;
        self.unitLab.font = font;
    }
}

- (CGFloat)stringWidthWithText:(NSString *)text font:(UIFont *)font {
    
    CGFloat margin = 4;
    if (kDevice_iPhonePlus) {
        margin = 4;
    }
    else if (kDevice_iPhoneX) {
        
    }
    
    return [text boundingRectWithSize:CGSizeMake(MAXFLOAT, font.lineHeight) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font} context:nil].size.width + margin;
}

- (UIFont *)getFontWithText:(NSString *)text {
    
    NSString *content = [NSString stringWithFormat:@"%@CNY",text];
    CGFloat fontValue = 24;
    
    CGFloat strWidth = [self stringWidthWithText:content font:[UIFont systemFontOfSize:fontValue]];
    CGFloat selfWidth = self.frame.size.width;
    
    while(strWidth >= selfWidth) {
        
        fontValue = fontValue - 0.5;
        if (fontValue < 13) {
            return [UIFont systemFontOfSize:13];
        }
        strWidth = [self stringWidthWithText:content font:[UIFont systemFontOfSize:fontValue]];
    }
    
    return [UIFont systemFontOfSize:fontValue];
}
#pragma mark - setter & getter

- (void)setContentNumber:(NSString *)contentNumber {
    _contentNumber = contentNumber;
    
    self.textField.text = contentNumber;
    [self changeTextFieldWidth:self.textField];
}

- (UITextField *)textField {
    if (!_textField) {
        _textField = [[UITextField alloc] init];
        //        _textField.text = @"0.00";
        _textField.font = [UIFont systemFontOfSize:24];
        _textField.textColor = _textColor;
        _textField.placeholder = @"0.00";
        [_textField setValue:_placeholderColor forKeyPath:@"_placeholderLabel.textColor"];
        _textField.keyboardType = UIKeyboardTypeDecimalPad;
        //        _textField.adjustsFontSizeToFitWidth = YES;
        //        [_textField setMinimumFontSize:8];
        _textField.textAlignment = NSTextAlignmentRight;
        _textField.delegate = self;
        [_textField addTarget:self action:@selector(textValueDidChanged:) forControlEvents:UIControlEventEditingChanged];
    }
    return _textField;
}

- (UILabel *)unitLab {
    if (!_unitLab) {
        _unitLab = [[UILabel alloc] init];
        _unitLab.text = @"CNY";
        _unitLab.font = [UIFont systemFontOfSize:24];
        _unitLab.textAlignment = NSTextAlignmentRight;
        _unitLab.textColor = _placeholderColor;
    }
    return _unitLab;
}


@end
