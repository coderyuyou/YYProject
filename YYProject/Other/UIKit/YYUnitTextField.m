//
//  YYUnitTextField.m
//  YYProject
//
//  Created by 于优 on 2018/11/29.
//  Copyright © 2018 SuperYu. All rights reserved.
//

#import "YYUnitTextField.h"

@interface YYUnitTextField () <UITextFieldDelegate>

@property (nonatomic, strong) UILabel *unitLab;
@property (nonatomic, strong) UITextField *textField;
@property (nonatomic, copy) NSString *unit;
@property (nonatomic, assign) YYUnitAlignment alignment;

@end

@implementation YYUnitTextField

@synthesize placeholderColor =_placeholderColor;
@synthesize textColor =_textColor;

- (instancetype)initUnitTextFieldWith:(YYUnitAlignment)alignment unit:(NSString *)unit {
    self = [super init];
    if (self) {
        self.unit = unit;
        self.alignment = alignment;
        [self createView];
    }
    return self;
}

- (void)createView {
    
    CGFloat rightLabWidth = [self stringWidthWithText:self.unitLab.text font:[UIFont systemFontOfSize:24]];
    self.unitLab.frame = CGRectMake(0, 0, rightLabWidth, 30);
    
    switch (self.alignment) {
            case YYUnitAlignmentLeft:
            self.textField.leftView = self.unitLab;
            self.textField.leftViewMode = UITextFieldViewModeAlways;
            self.textField.textAlignment = NSTextAlignmentRight;
            self.unitLab.textAlignment = NSTextAlignmentRight;
            break;
            
            case YYUnitAlignmentRight:
            self.textField.rightView = self.unitLab;
            self.textField.rightViewMode = UITextFieldViewModeAlways;
            self.textField.textAlignment = NSTextAlignmentRight;
            self.unitLab.textAlignment = NSTextAlignmentRight;
            break;
    }
    
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
        self.unitLab.textColor = self.placeholderColor;
    }
    else {
        self.unitLab.textColor = self.textColor;
    }
    if (self.didTextValueDidChangedHandle) {
        self.didTextValueDidChangedHandle(textField);
    }
    
    [self changeTextFieldWidth:textField];
}

#pragma mark - Action

- (void)changeTextFieldWidth:(UITextField *)textField {
    
    NSString *text = (textField.text.length > 0)?textField.text:@"0.00";
    
    CGFloat textFieldWidth = [self stringWidthWithText:text font:[UIFont systemFontOfSize:24]] + [self stringWidthWithText:self.unitLab.text font:[UIFont systemFontOfSize:24]];
    
    if (textFieldWidth <= self.frame.size.width) {
        [self.textField mas_updateConstraints:^(MASConstraintMaker *make) {
            make.width.mas_offset(textFieldWidth);
        }];
        UIFont *font = [UIFont systemFontOfSize:24];
        CGFloat labWidth = [self stringWidthWithText:self.unit font:font];
        self.unitLab.frame = CGRectMake(0, 0, labWidth, 30);
        self.textField.font = font;
        self.unitLab.font = font;
    } else {
        [self.textField mas_updateConstraints:^(MASConstraintMaker *make) {
            make.width.mas_offset(self.frame.size.width);
        }];
        UIFont *font = [self getFontWithText:text];
        CGFloat labWidth = [self stringWidthWithText:self.unit font:font];
        self.unitLab.frame = CGRectMake(0, 0, labWidth, 30);
        self.textField.font = font;
        self.unitLab.font = font;
    }
}

- (CGFloat)stringWidthWithText:(NSString *)text font:(UIFont *)font {
    
    CGFloat margin = 2;
    
    if (self.alignment == YYUnitAlignmentLeft) {
        margin = 6;
    }
    
    return [text boundingRectWithSize:CGSizeMake(MAXFLOAT, font.lineHeight) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font} context:nil].size.width + margin;
}

- (UIFont *)getFontWithText:(NSString *)text {
    
    NSString *content = [NSString stringWithFormat:@"%@%@",text,self.unit];
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

- (void)setPlaceholderColor:(UIColor *)placeholderColor {
    _placeholderColor = placeholderColor;
    
    self.unitLab.textColor = placeholderColor;
    [self.textField setValue:placeholderColor forKeyPath:@"_placeholderLabel.textColor"];
}

- (void)setTextColor:(UIColor *)textColor {
    _textColor = textColor;
    
    self.unitLab.textColor = textColor;
    self.textField.textColor = textColor;
}

- (UIColor *)placeholderColor {
    if (!_placeholderColor) {
        _placeholderColor = kFontColor_Gray;
    }
    return _placeholderColor;
}

- (UIColor *)textColor {
    if (!_textColor) {
        _textColor = kFontColor;
    }
    return _textColor;
}

- (UITextField *)textField {
    if (!_textField) {
        _textField = [[UITextField alloc] init];
        _textField.font = [UIFont systemFontOfSize:24];
        _textField.placeholder = @"0.00";
        _textField.textColor = self.textColor;
        [_textField setValue:self.placeholderColor forKeyPath:@"_placeholderLabel.textColor"];
        _textField.keyboardType = UIKeyboardTypeDecimalPad;
        _textField.delegate = self;
        [_textField addTarget:self action:@selector(textValueDidChanged:) forControlEvents:UIControlEventEditingChanged];
    }
    return _textField;
}

- (UILabel *)unitLab {
    if (!_unitLab) {
        _unitLab = [[UILabel alloc] init];
        _unitLab.text = self.unit;
        _unitLab.font = [UIFont systemFontOfSize:24];
        _unitLab.textColor = self.placeholderColor;
    }
    return _unitLab;
}


@end
