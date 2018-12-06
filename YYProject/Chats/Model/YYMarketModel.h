//
//  YYMarketModel.h
//  YYProject
//
//  Created by 于优 on 2018/12/6.
//  Copyright © 2018 SuperYu. All rights reserved.
//

#import <Foundation/Foundation.h>
@import Charts;
@class YYDealModel,FZMDataValueFormatter;

NS_ASSUME_NONNULL_BEGIN

@interface YYMarketModel : NSObject
/** 当前时间 */
@property (nonatomic, assign) NSInteger actualtime;
/** 时间 */
@property (nonatomic, assign) NSInteger ceatetime;
/** 收盘价 */
@property (nonatomic, assign) double close;
/** 最高 */
@property (nonatomic, assign) double high;
/** 最低 */
@property (nonatomic, assign) double low;
/** 开盘价 */
@property (nonatomic, assign) double open;
/** 浮动 */
@property (nonatomic, copy) NSString *sort;

// 最新一条的新增属性
/** 开盘价 */
@property (nonatomic, assign) double originBuy;
/** 开盘价 */
@property (nonatomic, assign) double originSell;
/** 买入卖出 */
@property (nonatomic, strong) YYDealModel *market;

/** 构造K线数据方法 */
+ (CandleChartDataSet *)candlestickOption:(NSMutableArray<YYMarketModel *> *)array;

/** 构造分时图数据方法 */
+ (LineChartDataSet *)timeLineOption:(NSMutableArray<YYMarketModel *> *)array;

/** 构造分时图X轴数据方法 */
+ (id)timeLineXValueFormatter:(NSMutableArray<YYMarketModel *> *)array;

/** 构造图表Y轴数据方法 */
+ (id)chartViewYValueFormatter:(NSInteger)length;

/** 构造分时图Y轴最小值方法 */
+ (double)timeLineYMinValue:(NSMutableArray<YYMarketModel *> *)array;
/** 构造分时图Y轴最大值方法 */
+ (double)timeLineYMaxValue:(NSMutableArray<YYMarketModel *> *)array;

/** 构造K线图Y轴最小值方法 */
+ (void)kLineYMinValue:(NSMutableArray<YYMarketModel *> *)array chartView:(CandleStickChartView *)chartView completion:(void (^)(double minValue, CGFloat lowLeft))completion;
/** 构造K线图Y轴最大值方法 */
+ (void)kLineYMaxValue:(NSMutableArray<YYMarketModel *> *)array chartView:(CandleStickChartView *)chartView completion:(void (^)(double maxValue, CGFloat highLeft))completion;

@end

@interface YYDealModel : NSObject

/** 浮动 */
@property (nonatomic, copy) NSString *buy;
/** 浮动 */
@property (nonatomic, copy) NSString *sell;
/** 时间 */
@property (nonatomic, assign) NSInteger time;

@end

NS_ASSUME_NONNULL_END
