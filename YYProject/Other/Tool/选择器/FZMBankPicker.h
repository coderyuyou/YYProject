//
//  FZMBankPicker.h
//  BlockChainFinance
//
//  Created by 于优 on 2018/4/11.
//  Copyright © 2018年 fuzamei. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^bankBlock)(NSString *name, NSString *Id);

@interface FZMBankPicker : UIView

@property (nonatomic, copy) bankBlock block;

- (instancetype)initWithFrame:(CGRect)frame Data:(NSArray *)dataArr;

@end
