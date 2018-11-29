//
//  UITextView+Placeholder.m
//  YYProject
//
//  Created by 于优 on 2018/11/29.
//  Copyright © 2018 SuperYu. All rights reserved.
//

#import "UITextView+Placeholder.h"
#import <objc/runtime.h>

static const char placehodler_key;

@interface UITextView ()

@property (weak, nonatomic) UILabel *placeholderLB;

@end

@implementation UITextView (Placeholder)

- (void)addPlaceholerLabel {
    UILabel *placeHolderLabel = [[UILabel alloc] init];
    placeHolderLabel.textAlignment = self.textAlignment;
    placeHolderLabel.numberOfLines = 0;
    placeHolderLabel.font = self.font;
    placeHolderLabel.textColor = [UIColor lightGrayColor];
    [placeHolderLabel sizeToFit];
    self.placeholderLB = placeHolderLabel;
    [self addSubview:placeHolderLabel];
    [self setValue:placeHolderLabel forKeyPath:@"_placeholderLabel"];
}

- (void)setPlaceholderLB:(UILabel *)placeholderLB {
    if (placeholderLB) {
        objc_setAssociatedObject(self, &placehodler_key, placeholderLB, OBJC_ASSOCIATION_ASSIGN);
    }
}

- (UILabel *)placeholderLB {
    return objc_getAssociatedObject(self, &placehodler_key);
}

- (void)setPlaceholder:(NSString *)placeholder {
    if (!self.placeholderLB) {
        [self addPlaceholerLabel];
    }
    self.placeholderLB.text = placeholder;
}

- (NSString *)placeholder {
    return self.placeholderLB.text;
}

- (void)setPlaceholderColor:(UIColor *)placeholderColor {
    if (!self.placeholderLB) {
        [self addPlaceholerLabel];
    }
    
    self.placeholderLB.textColor = placeholderColor;
}

- (UIColor *)placeholderColor {
    return self.placeholderLB.textColor;
}


@end
