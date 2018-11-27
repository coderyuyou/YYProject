//
//  YYAlignmentButton.h
//  YYProject
//
//  Created by 于优 on 2018/11/27.
//  Copyright © 2018 SuperYu. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,UIImgAlignment){
    UIImgAlignmentTop     = 0,
    UIImgAlignmentLeft    = 1,
    UIImgAlignmentBottom  = 2,
    UIImgAlignmentRight   = 3
};

@interface YYAlignmentButton : UIButton

/** 文字图片间距 */
@property (nonatomic, assign) CGFloat interval;
/** 图文类型 */
@property (nonatomic, assign) UIImgAlignment imgAlignment;

@end

