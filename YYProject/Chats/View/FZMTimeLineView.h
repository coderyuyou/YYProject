//
//  FZMTimeLineView.h
//  FZMGoldExchange
//
//  Created by 于优 on 2018/5/10.
//  Copyright © 2018年 FZM. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YYMarketModel;

@interface FZMTimeLineView : UIView

+ (instancetype)shopView;

/** 数据 */
@property (nonatomic, strong) NSArray *dataArray;

/** 数据源 */
@property (nonatomic, strong) NSMutableArray<YYMarketModel *> *markeModel;

@end
