//
//  FZMTradeKLineView.m
//  FZMGoldExchange
//
//  Created by 于优 on 2018/5/10.
//  Copyright © 2018年 FZM. All rights reserved.
//

#import "FZMTradeKLineView.h"
#import "SGPagingView.h"
@import Charts;
#import "YYMarketModel.h"

@interface FZMTradeKLineView ()<SGPageTitleViewDelegate,ChartViewDelegate>

@property (nonatomic, strong) SGPageTitleView *pageTitleView;

@property (nonatomic, strong) CandleStickChartView *chartView;
@property (nonatomic, strong) ChartLimitLine *highLine;
@property (nonatomic, strong) ChartLimitLine *lowLine;
@property (nonatomic, strong) UILabel *highLab;
@property (nonatomic, strong) UILabel *lowLab;

@end

@implementation FZMTradeKLineView

+ (instancetype)shopView {
    return [[self alloc] init];
}

- (instancetype)init {
    self = [super init];
    if (self) {
        self.backgroundColor = kWhiteColor;
        [self createView];
    }
    return self;
}

- (void)createView {
    
    UILabel *titleLab = [UILabel new];
    titleLab.text = @"BTY/USDG";
    titleLab.textColor = kBrownColor;
    titleLab.font = BOLDFONT_SIZE(14);
    [self addSubview:titleLab];
    [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.left.mas_equalTo(10);
        make.right.mas_equalTo(0);
        make.height.mas_equalTo(39);
    }];
    
    UIView *topLine = [UIView new];
    topLine.backgroundColor = kBackgroundColor;
    [self addSubview:topLine];
    [topLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(titleLab.mas_bottom).offset(0);
        make.left.right.mas_equalTo(self);
        make.height.mas_equalTo(1);
    }];
    
    [self addSubview:self.pageTitleView];
    
//    UIView *bottomLine = [UIView new];
//    bottomLine.backgroundColor = kBackgroundColor;
//    [self addSubview:bottomLine];
//    [bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.bottom.equalTo(self.pageTitleView.mas_bottom).offset(0);
//        make.left.mas_equalTo(0);
//        make.right.mas_equalTo(0);
//        make.height.mas_equalTo(1);
//    }];
    
    [self addSubview:self.chartView];
    [self.chartView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(titleLab.mas_bottom).offset(1);
        make.left.right.mas_equalTo(0);
        make.bottom.equalTo(self.pageTitleView.mas_top).offset(-1);
    }];
}

#pragma mark - ***************  pageView  ***************

- (void)pageTitleView:(SGPageTitleView *)pageTitleView selectedIndex:(NSInteger)selectedIndex {

    if (self.didRequestKLineHandle) {
        self.didRequestKLineHandle(selectedIndex + 1);
    }
}

#pragma mark - ***************  setter & getter  ***************

- (void)setMarkeModel:(NSMutableArray<YYMarketModel *> *)markeModel {
    
    CandleChartDataSet *dataSet = [YYMarketModel candlestickOption:markeModel];
    
    CandleChartData *data = [[CandleChartData alloc] initWithDataSet:dataSet];
    self.chartView.data = data;
    
    self.chartView.rightAxis.valueFormatter = [YYMarketModel chartViewYValueFormatter:4];
    
    /*
    double high = [FZMmarketModel kLineYMaxValue:markeModel];
    self.highLine.limit = high;
    self.highLine.label = [NSString stringWithFormat:@"%.6f",high];
    
    double low = [FZMmarketModel kLineYMinValue:markeModel];
    self.lowLine.limit = low;
    self.lowLine.label = [NSString stringWithFormat:@"%.6f",low];
    
    [self.chartView.rightAxis removeAllLimitLines];
    [self.chartView.rightAxis addLimitLine:self.highLine];
    [self.chartView.rightAxis addLimitLine:self.lowLine];
     */
    
    CGFloat rightM = self.chartView.viewPortHandler.offsetRight;
    CGFloat leftM = self.chartView.viewPortHandler.offsetLeft;
    
    [YYMarketModel kLineYMaxValue:markeModel chartView:self.chartView completion:^(double maxValue, CGFloat highLeft) {
        if (highLeft + 70 > kScreen_Width - rightM - leftM) {
            self.highLab.text = [NSString stringWithFormat:@"%.6f--",maxValue];
            self.highLab.textAlignment = NSTextAlignmentRight;
            highLeft = highLeft - 70;
        }
        else {
            self.highLab.text = [NSString stringWithFormat:@"--%.6f",maxValue];
            self.highLab.textAlignment = NSTextAlignmentLeft;
        }
        [self.chartView addSubview: self.highLab];

        self.highLab.frame = CGRectMake(highLeft, 0, 70, 16);
    }];
    
    [YYMarketModel kLineYMinValue:markeModel chartView:self.chartView completion:^(double minValue, CGFloat lowLeft) {
        
        if (lowLeft + 70 > kScreen_Width - rightM - leftM) {
            self.lowLab.text = [NSString stringWithFormat:@"%.8f--",minValue];
            self.lowLab.textAlignment = NSTextAlignmentRight;
            lowLeft = lowLeft - 70;
        }
        else {
            self.lowLab.text = [NSString stringWithFormat:@"--%.8f",minValue];
            self.lowLab.textAlignment = NSTextAlignmentLeft;
        }
        [self.chartView addSubview: self.lowLab];

        self.lowLab.frame = CGRectMake(lowLeft, 173, 70, 16);
    }];
}


- (SGPageTitleView *)pageTitleView {
    if (!_pageTitleView) {
        
        SGPageTitleViewConfigure *configure = [SGPageTitleViewConfigure pageTitleViewConfigure];
        configure.indicatorAdditionalWidth = 40;
        configure.showBottomSeparator = YES;
        configure.bottomSeparatorColor = kFontColor;
        configure.titleColor = kFontColor_Gray;
        configure.titleSelectedColor = kThemeColor;
        configure.indicatorColor = kThemeColor;
        configure.titleFont = FONT_SIZE(12);
        configure.titleSelectedFont = FONT_SIZE(12);
        
        NSArray *titleArray = @[@"1分钟", @"5分钟", @"15分钟", @"30分钟", @"1小时", @"2小时", @"日线", @"周线"];
//        , FZMLocalizedString(@"月线", nil)
        _pageTitleView = [SGPageTitleView pageTitleViewWithFrame:CGRectMake(0, 230, kScreen_Width, 40) delegate:self titleNames:titleArray configure:configure];
    }
    return _pageTitleView;
}

- (CandleStickChartView *)chartView {
    if (!_chartView) {
        _chartView = [[CandleStickChartView alloc] init];
        _chartView.delegate = self;
        
        _chartView.noDataText = @"暂时没有数据";
        _chartView.chartDescription.enabled = NO;
        
        _chartView.maxVisibleCount = 40;
        _chartView.pinchZoomEnabled = NO;
        _chartView.drawGridBackgroundEnabled = NO;
        
//        ChartXAxis *xAxis = _chartView.xAxis;
//        xAxis.labelPosition = XAxisLabelPositionBottom;
//        xAxis.drawGridLinesEnabled = NO;
        
        _chartView.rightAxis.labelCount = 7;
        _chartView.rightAxis.drawGridLinesEnabled = NO;
//        _chartView.rightAxis.drawAxisLineEnabled = NO;
        
        _chartView.leftAxis.enabled = NO;
        
        _chartView.xAxis.enabled = NO;
        _chartView.legend.enabled = NO;
    }
    return _chartView;
}

- (ChartLimitLine *)highLine {
    if (!_highLine) {
//        ChartLimitLine *ll1 = [[ChartLimitLine alloc] initWithLimit:0.6702 label:@"Upper Limit"];
        _highLine = [[ChartLimitLine alloc] init];
        
        _highLine.lineWidth = 1.0;
        //        ll1.lineDashLengths = @[@0.f, @5.f];
        _highLine.lineColor = kLineColor;
        _highLine.labelPosition = ChartLimitLabelPositionRightTop;
        _highLine.valueFont = [UIFont systemFontOfSize:10.0];
        _highLine.valueTextColor = kLineColor;
    }
    return _highLine;
}

- (ChartLimitLine *)lowLine {
    if (!_lowLine) {
        _lowLine = [[ChartLimitLine alloc] init];
        _lowLine.lineWidth = 1.0;
        //        ll2.lineDashLengths = @[@0.f, @5.f];
        _lowLine.lineColor = kLineColor;
        _lowLine.labelPosition = ChartLimitLabelPositionRightBottom;
        _lowLine.valueFont = [UIFont systemFontOfSize:10.0];
        _lowLine.valueTextColor = kLineColor;
    }
    return _lowLine;
}

- (UILabel *)highLab {
    if (!_highLab) {
        _highLab = [UILabel new];
        _highLab.textColor = kFontColor_Gray;
        _highLab.font = FONT_SIZE(10);
    }
    return _highLab;
}

- (UILabel *)lowLab {
    if (!_lowLab) {
        _lowLab = [UILabel new];
        _lowLab.textColor = kFontColor_Gray;
        _lowLab.font = FONT_SIZE(10);
    }
    return _lowLab;
}

@end
