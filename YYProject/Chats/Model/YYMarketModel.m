//
//  YYMarketModel.m
//  YYProject
//
//  Created by 于优 on 2018/12/6.
//  Copyright © 2018 SuperYu. All rights reserved.
//

#import "YYMarketModel.h"
#import "YYDataValueFormatter.h"

#import "NSDecimalNumber+Addtion.h"

@implementation YYMarketModel

+ (CandleChartDataSet *)candlestickOption:(NSMutableArray<YYMarketModel *> *)array {
    
    NSMutableArray *yVals1 = [[NSMutableArray alloc] init];
    
    for (NSInteger i = 0; i < array.count; i++) {
        
        YYMarketModel *model = array[i];
        
        CGFloat high = model.high;
        CGFloat low = model.low;
        CGFloat open = model.open;
        CGFloat close = model.close;
        
        //        CandleChartDataEntry *dataEntry = [[CandleChartDataEntry alloc] initWithX:i shadowH:high shadowL:low open:open close:close icon: [UIImage imageNamed:@"icon"]];
        
        CandleChartDataEntry *dataEntry = [[CandleChartDataEntry alloc] initWithX:i shadowH:high shadowL:low open:open close:close];
        
        [yVals1 addObject:dataEntry];
    }
    
    CandleChartDataSet *dataSet = [[CandleChartDataSet alloc] initWithValues:yVals1 label:@"Data dataSet"];
    dataSet.axisDependency = AxisDependencyRight;
    [dataSet setColor:[UIColor colorWithWhite:80/255.f alpha:1.f]];
    
    dataSet.drawIconsEnabled = NO;
    dataSet.drawValuesEnabled = NO;
    
    dataSet.shadowColor = UIColor.darkGrayColor;
    dataSet.shadowWidth = 0.7;
    dataSet.decreasingColor = kCandlestickRedColor;
    dataSet.decreasingFilled = YES;
    dataSet.increasingColor = kCandlestickGreenColor;
    dataSet.increasingFilled = YES;
    dataSet.neutralColor = UIColor.blueColor;
    
    return dataSet;
}

+ (LineChartDataSet *)timeLineOption:(NSMutableArray<YYMarketModel *> *)array {
    
    NSMutableArray *arr = [NSMutableArray array];
    
    for (NSInteger i = 0; i < array.count; i++) {
        // @[收盘价]
        YYMarketModel *model = array[i];
        ChartDataEntry *entry = [[ChartDataEntry alloc] initWithX:i y:model.close];
        [arr addObject:entry];
    }
    LineChartDataSet *setData = [[LineChartDataSet alloc] initWithValues:arr];
    
    //    LineChartDataSet *setData = [[LineChartDataSet alloc] initWithValues:arr label:@""];
    //对于线的各种设置
    setData.lineWidth = 4;
    setData.drawValuesEnabled = NO;//不显示文字
    //    set.highlightEnabled = YES;//选中拐点,是否开启高亮效果(显示十字线)
    //    set.highlightColor = [UIColor clearColor];// 十字线颜色
    setData.drawCirclesEnabled = NO;//是否绘制拐点
    //    set.cubicIntensity = 0.2;// 曲线弧度
    //    set.circleRadius = 5.0f;//拐点半径
    //    set.drawCircleHoleEnabled = NO;//是否绘制中间的空心
    //    set.circleHoleRadius = 4.0f;//空心的半径
    //    set.circleHoleColor = [UIColor whiteColor];//空心的颜色
    setData.circleColors = @[[UIColor colorWithRed:0.114 green:0.812 blue:1.000 alpha:1.000]];
    setData.mode = LineChartModeCubicBezier;// 模式为曲线模式
    setData.drawFilledEnabled = YES;//是否填充颜色
    // 设置渐变效果
    [setData setColor:kThemeColor];//折线颜色     self.graph.fillColors = @[UIColorFromRGB(0xfaf6ea),UIColorFromRGB(0xfefdf9)];
    
    NSArray *gradientColors = @[(id)[ChartColorTemplates colorFromString:@"#faf6ea"].CGColor,
                                (id)[ChartColorTemplates colorFromString:@"#fefdf9"].CGColor];
    CGGradientRef gradientRef = CGGradientCreateWithColors(nil, (CFArrayRef)gradientColors, nil);
    setData.fillAlpha = 1.0f;//透明度
    setData.fill = [ChartFill fillWithLinearGradient:gradientRef angle:90.0f];//赋值填充颜色对象
    CGGradientRelease(gradientRef);//释放gradientRef
    // 把线放到LineChartData里面,因为只有一条线，所以集合里面放一个就好了，多条线就需要不同的 set 啦
    
    return setData;
}

+ (id)timeLineXValueFormatter:(NSMutableArray<YYMarketModel *> *)array {
    NSMutableArray *timeArray = [NSMutableArray new];
    for (YYMarketModel *model in array) {
        
        NSDate *date = [NSDate dateWithTimeIntervalSince1970:(model.actualtime / 1000)];
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"HH:mm"];
        NSString *timeStr = [formatter stringFromDate:date];
        
        [timeArray addObject:timeStr];
    }
    
    return [[YYDataValueFormatter alloc]initWithXAxisArr:timeArray];
}

+ (id)chartViewYValueFormatter:(NSInteger)length {
    
    //    NSString * max = [NSString stringWithFormat:@"%.3f",[self timeLineYMaxValue:array]];
    //    NSString * min = [NSString stringWithFormat:@"%.3f",[self timeLineYMinValue:array]];
    //
    //    NSString *baseStr = [NSString stringWithFormat:@"%@", handlerDecimalNumber(SNDiv(SNSub(max, min), @"5"), NSRoundDown, 3)];
    //
    //    NSMutableArray *timeArray = [NSMutableArray new];
    //    for (NSInteger i = 0; i < 5; i++) {
    //        NSDecimalNumber *resultNumber = [[NSDecimalNumber alloc]initWithString:@"0"];
    //
    //        resultNumber = SNAdd(min, SNMul(baseStr, [NSString stringWithFormat:@"%ld",(i + 1)]));
    //
    //        NSString *valueStr = [NSString stringWithFormat:@"%@",resultNumber];
    //
    //        [timeArray addObject:valueStr];
    //    }
    
    
    return [[YYDataValueFormatter alloc]initWithYAxisLength:length];
}

+ (double)timeLineYMinValue:(NSMutableArray<YYMarketModel *> *)array {
    
    NSMutableArray *valueArray = [NSMutableArray new];
    for (YYMarketModel *model in array) {
        // @[收盘]
        [valueArray addObject:@(model.close)];
    }
    NSArray *result = [valueArray sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        return [obj1 compare:obj2]; //升序
    }];
    
    double minValue = [result.firstObject doubleValue] * 0.99;
    
    return minValue;
    
}

+ (double)timeLineYMaxValue:(NSMutableArray<YYMarketModel *> *)array {
    NSMutableArray *valueArray = [NSMutableArray new];
    for (YYMarketModel *model in array) {
        // @[收盘]
        [valueArray addObject:@(model.close)];
    }
    NSArray *result = [valueArray sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        return [obj1 compare:obj2]; //升序
    }];
    
    double maxValue = [result.lastObject doubleValue];
    
    return maxValue;
}

/** 构造K线图Y轴最小值方法 */

+ (void)kLineYMinValue:(NSMutableArray<YYMarketModel *> *)array chartView:(CandleStickChartView *)chartView completion:(void (^)(double, CGFloat))completion {
    NSMutableArray *valueArray = [NSMutableArray new];
    for (YYMarketModel *model in array) {
        // @[收盘]
        [valueArray addObject:@(model.low)];
    }
    NSArray *result = [valueArray sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        return [obj1 compare:obj2]; //升序
    }];
    
    double minValue = [result.firstObject doubleValue];
    
    CGFloat lowLeft = 0;
    CGFloat rightM = chartView.viewPortHandler.offsetRight;
    CGFloat leftM = chartView.viewPortHandler.offsetLeft;
    
    for (NSInteger i = 0; i < valueArray.count; i++) {
        
        if ([valueArray[i] doubleValue] == minValue) {
            lowLeft = leftM + (((kScreen_Width - rightM - leftM) / valueArray.count) * 0.5) * (2 * i + 1);
        }
    }
    
    if (completion) {
        completion(minValue, lowLeft);
    }
}
/** 构造K线图Y轴最大值方法 */
+ (void)kLineYMaxValue:(NSMutableArray<YYMarketModel *> *)array chartView:(CandleStickChartView *)chartView completion:(void (^)(double, CGFloat))completion {
    NSMutableArray *valueArray = [NSMutableArray new];
    for (YYMarketModel *model in array) {
        // @[收盘]
        [valueArray addObject:@(model.high)];
    }
    NSArray *result = [valueArray sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        return [obj1 compare:obj2]; //升序
    }];
    
    double maxValue = [result.lastObject doubleValue];
    
    CGFloat highLeft = 0;
    CGFloat rightM = chartView.viewPortHandler.offsetRight;
    CGFloat leftM = chartView.viewPortHandler.offsetLeft;
    
    for (NSInteger i = 0; i < valueArray.count; i++) {
        
        if ([valueArray[i] doubleValue] == maxValue) {
            highLeft = leftM + (((kScreen_Width - rightM - leftM) / valueArray.count) * 0.5) * (2 * i + 1);
        }
    }
    
    if (completion) {
        completion(maxValue, highLeft);
    }
}


@end

@implementation YYDealModel

@end
