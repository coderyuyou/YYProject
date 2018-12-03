//
//  YYHUDAnimationView.h
//  YYProject
//
//  Created by 于优 on 2018/12/3.
//  Copyright © 2018 SuperYu. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, YYHUDAnimationType) {
    YYHUDAnimationTypeNone,
    YYHUDAnimationTypeSuccess, // 成功
    YYHUDAnimationTypeError, // 失败
};

@interface YYHUDAnimationView : UIImageView <CAAnimationDelegate>

/**
 操作成功还是失败类型的动画
 */
@property(nonatomic, assign) YYHUDAnimationType animationType;


@end

NS_ASSUME_NONNULL_END
