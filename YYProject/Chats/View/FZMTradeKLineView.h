//
//  FZMTradeKLineView.h
//  FZMGoldExchange
//
//  Created by 于优 on 2018/5/10.
//  Copyright © 2018年 FZM. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YYMarketModel;

@interface FZMTradeKLineView : UIView

+ (instancetype)shopView;

/** 获取数据 */
@property (nonatomic, copy) void(^didRequestKLineHandle)(NSInteger index);

/** 数据源 */
@property (nonatomic, strong) NSMutableArray<YYMarketModel *> *markeModel;

@end
