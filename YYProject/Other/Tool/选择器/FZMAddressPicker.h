//
//  FZMAddressPicker.h
//  BlockChainFinance
//
//  Created by 于优 on 2018/4/10.
//  Copyright © 2018年 fuzamei. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^adressBlock)(NSString *province, NSString *city);

@interface FZMAddressPicker : UIView

@property (nonatomic, copy) adressBlock block;

- (instancetype)initWithFrame:(CGRect)frame Data:(NSArray *)dataArr;

@end
