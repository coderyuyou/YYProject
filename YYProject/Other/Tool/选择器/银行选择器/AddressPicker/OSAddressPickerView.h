//
//  OSAddressPickerView.h
//  AddressPicker
//
//  Created by mac on 16/8/2.
//  Copyright © 2016年 筒子家族. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^adressBlock)(NSString *name, NSString *Id);

@interface OSAddressPickerView : UIView

@property (nonatomic, copy) adressBlock block;

- (instancetype)initWithFrame:(CGRect)frame Data:(NSArray *)dataArr;


@end
