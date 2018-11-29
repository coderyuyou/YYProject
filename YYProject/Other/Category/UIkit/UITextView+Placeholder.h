//
//  UITextView+Placeholder.h
//  YYProject
//
//  Created by 于优 on 2018/11/29.
//  Copyright © 2018 SuperYu. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UITextView (Placeholder)

/** placeholder的文字 */
@property (nonatomic, copy) NSString *placeholder;

/** placeholder文字的颜色 */
@property (nonatomic, weak) UIColor *placeholderColor;

@end

NS_ASSUME_NONNULL_END
