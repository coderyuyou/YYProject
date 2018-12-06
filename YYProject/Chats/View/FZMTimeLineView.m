//
//  FZMTimeLineView.m
//  FZMGoldExchange
//
//  Created by 于优 on 2018/5/10.
//  Copyright © 2018年 FZM. All rights reserved.
//

#import "FZMTimeLineView.h"
#import "YYMarketModel.h"
@import Charts;

@interface FZMTimeLineView ()<ChartViewDelegate>

@property (nonatomic, strong) LineChartView *chartView;

/** 买入 */
@property (nonatomic, strong) UILabel *buyLab;
/** 卖出 */
@property (nonatomic, strong) UILabel *sellLab;

@end

@implementation FZMTimeLineView

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
    
    UIView *topView = [UIView new];
    [self addSubview:topView];
    [topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.mas_equalTo(0);
        make.height.mas_equalTo(80);
    }];
    
    // ----
    UILabel *titleLab = [UILabel new];
    titleLab.text = @"BTY /";
    titleLab.textColor = kFontColor_Gray;
    titleLab.font = FONT_SIZE(14);
    titleLab.textAlignment = NSTextAlignmentLeft;
    [topView addSubview:titleLab];
    [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(25);
        make.left.mas_equalTo(15);
        make.size.mas_equalTo(CGSizeMake(60, 20));
    }];
    
    UILabel *subLab = [UILabel new];
    subLab.text = @"USDG";
    subLab.textColor = kBrownColor;
    subLab.font = FONT_SIZE(15);
    subLab.textAlignment = NSTextAlignmentLeft;
    [topView addSubview:subLab];
    [subLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(titleLab.mas_bottom).offset(6);
        make.left.mas_equalTo(titleLab.mas_left);
        make.size.mas_equalTo(CGSizeMake(60, 20));
    }];
    
    // ----
    UILabel *titleLab1 = [UILabel new];
    titleLab1.text = @"买入价";
    titleLab1.textColor = kFontColor_Gray;
    titleLab1.font = FONT_SIZE(14);
    titleLab1.textAlignment = NSTextAlignmentLeft;
    [topView addSubview:titleLab1];
    [titleLab1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(titleLab);
        make.left.equalTo(titleLab.mas_right).offset(0);
        make.size.mas_equalTo(CGSizeMake(90, 20));
    }];

    
    [topView addSubview:self.buyLab];
    [self.buyLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(subLab);
        make.left.mas_equalTo(titleLab1.mas_left);
        make.size.mas_equalTo(CGSizeMake(100, 20));
    }];
//    [self.buyLab setSingleLineAutoResizeWithMaxWidth:100];
    
    // ----
    UILabel *titleLab2 = [UILabel new];
    titleLab2.text = @"卖出价";
    titleLab2.textColor = kFontColor_Gray;
    titleLab2.font = FONT_SIZE(14);
    titleLab2.textAlignment = NSTextAlignmentLeft;
    [topView addSubview:titleLab2];
    [titleLab2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(titleLab);
        make.left.equalTo(titleLab1.mas_right).offset(10);
        make.size.mas_equalTo(CGSizeMake(90, 20));
    }];
    
    [topView addSubview:self.sellLab];
    [self.sellLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(subLab);
        make.left.mas_equalTo(titleLab2.mas_left);
        make.size.mas_equalTo(CGSizeMake(100, 20));
    }];
//    [self.sellLab setSingleLineAutoResizeWithMaxWidth:100];
    
    UILabel *timeLab = [UILabel new];
    timeLab.layer.backgroundColor = kThemeColor.CGColor;
    timeLab.layer.cornerRadius = 4;
    timeLab.text = @"24H";
    timeLab.textColor = kFontColor;
    timeLab.font = FONT_SIZE(14);
    timeLab.textAlignment = NSTextAlignmentCenter;
    [topView addSubview:timeLab];
    [timeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(titleLab);
        make.right.mas_equalTo(-10);
        make.size.mas_equalTo(CGSizeMake(50, 20));
    }];
    
    [self addSubview:self.chartView];
    [self.chartView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(80);
        make.right.left.mas_equalTo(0);
        make.bottom.mas_equalTo(-6);
    }];
}

#pragma mark - ***************  setter & getter  ***************

- (void)setMarkeModel:(NSMutableArray<YYMarketModel *> *)markeModel {
    
    LineChartDataSet *dataSet = [YYMarketModel timeLineOption:markeModel];
    LineChartData *data = [[LineChartData alloc] initWithDataSet:dataSet];
    self.chartView.data = data;
    
    [self.chartView.leftAxis setAxisMinimum:[YYMarketModel timeLineYMinValue:markeModel]];
//    [self.chartView.leftAxis setAxisMaximum:[FZMmarketModel timeLineYMaxValue:markeModel]];
    
    self.chartView.xAxis.valueFormatter = [YYMarketModel timeLineXValueFormatter:markeModel];
    self.chartView.leftAxis.valueFormatter = [YYMarketModel chartViewYValueFormatter:3];
}

- (void)setDataArray:(NSArray *)dataArray {
    _dataArray = dataArray;
    
    double buy = [dataArray.firstObject doubleValue];
    double sell = [dataArray.lastObject doubleValue];
    self.buyLab.text = [NSString stringWithFormat:@"%.8f",buy];
    self.sellLab.text = [NSString stringWithFormat:@"%.8f",sell];
}

- (UILabel *)buyLab {
    if (!_buyLab) {
        _buyLab = [UILabel new];
        _buyLab.textColor = kBrownColor;
        _buyLab.font = BOLDFONT_SIZE(15);
        _buyLab.textAlignment = NSTextAlignmentLeft;
        _buyLab.text = @"--";
    }
    return _buyLab;
}

- (UILabel *)sellLab {
    if (!_sellLab) {
        _sellLab = [UILabel new];
        _sellLab.textColor = kBrownColor;
        _sellLab.font = BOLDFONT_SIZE(15);
        _sellLab.textAlignment = NSTextAlignmentLeft;
        _sellLab.text = @"--";
    }
    return _sellLab;
}

- (LineChartView *)chartView {
    if (!_chartView) {
        _chartView = [[LineChartView alloc] init];
        _chartView.backgroundColor = [UIColor clearColor];//设置背景颜色
        _chartView.chartDescription.enabled = NO;
        _chartView.noDataText = @"暂时没有数据";// 设置没有数据的显示内容
        _chartView.legend.enabled = NO;//不显示图例说明
        _chartView.scaleYEnabled = NO;//取消Y轴缩放
        _chartView.scaleXEnabled = NO;//取消X轴缩放
        _chartView.scaleEnabled = NO;// 缩放
        _chartView.doubleTapToZoomEnabled = NO;//取消双击缩放
        _chartView.dragDecelerationEnabled = NO;//拖拽后是否有惯性效果
        _chartView.dragDecelerationFrictionCoef = 0;//拖拽后惯性效果的摩擦系数(0~1)，数值越大越明显
        _chartView.rightAxis.enabled = NO;//不绘制右边轴的信息
//        _chartView.leftAxis.enabled = NO;//不绘制左边轴的信息
//        _chartView.leftAxis.labelCount = 6;
//        _chartView.leftAxis.labelFont = FONT_SIZE(8);
//        _chartView.leftAxis.minWidth = 60;
        _chartView.leftAxis.drawGridLinesEnabled = NO;
        
        _chartView.xAxis.drawGridLinesEnabled = NO;//不绘制网络线
        _chartView.xAxis.labelPosition = XAxisLabelPositionBottom;// X轴的位置
//        _chartView.xAxis.granularity = 1;// 间隔为1
        
    }
    return _chartView;
}


@end
