//
//  YYModuleViewController.m
//  YYProject
//
//  Created by 于优 on 2018/12/6.
//  Copyright © 2018 SuperYu. All rights reserved.
//

#import "YYModuleViewController.h"
#import "FZMTimeLineView.h"
#import "FZMTradeKLineView.h"
#import "YYMarketModel.h"
#import "YYWebSockeIO.h"
#import "HWWeakTimer.h"
#import "YYPolling.h"
#import "YYNetwork.h"

@interface YYModuleViewController ()
/** 分时图 */
@property (nonatomic, strong) FZMTimeLineView *timeLineView;
/** k线 */
@property (nonatomic, strong) FZMTradeKLineView *kLineView;
/** 分时数据 */
@property (nonatomic, strong) NSMutableArray<YYMarketModel *> *timeLineArray;
/** K线历史数据源 */
@property (nonatomic, strong) NSMutableArray<YYMarketModel *> *kLineHistoryArray;
/** K线数据源 */
@property (nonatomic, strong) NSMutableArray<YYMarketModel *> *kLineArray;
/** 定时器 */
@property (nonatomic, strong) NSTimer *timer;
/** 是否可以网络请求 */
@property (nonatomic, assign) BOOL canRequest;
/** 是否进行轮询 */
@property (nonatomic, assign) BOOL canPolling;

@end

@implementation YYModuleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self requestData:5]; // 获取分时图
    
    [self createView];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadWebSocketMessage:) name:kWebSocketdidReceiveMessageNote object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadPollingMessage:) name:kPollingdidReceiveMessageNote object:nil];
    self.canRequest = YES;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [UIView setAnimationsEnabled:YES];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    
    // 开起socket
    [[YYWebSockeIO sharedWebSockeIO]webSocketOpenWithURLString:MARKET_WebSocket];
    
    // 开启轮询
    WEAKSELF;
    _timer = [HWWeakTimer scheduledTimerWithTimeInterval:10 block:^(id userInfo) {
        // 获取分时图
        [weakSelf requestData:5];
        
    } userInfo:nil repeats:YES];
    
    [[YYPolling sharedPolling] pollingOpen];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    [[YYWebSockeIO sharedWebSockeIO]webSocketClose];
    
    [_timer invalidate];
    _timer = nil;
    
    [[YYPolling sharedPolling] pollingClose];
}


- (void)createView {
    
    self.navView.title = @"功能模块";
    self.navView.seperateColor = kFontColor_Gray;
    
    [self.view addSubview:self.timeLineView];
    [self.timeLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.navView.mas_bottom).offset(-13);
        make.left.right.mas_equalTo(self.view);
        make.height.mas_equalTo(300);
    }];
    
    [self.view addSubview:self.kLineView];
    [self.kLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.timeLineView.mas_bottom).offset(0);
        make.left.right.mas_equalTo(self.view);
        make.height.mas_equalTo(270);
    }];
}

- (void)requestData:(NSInteger)type {
    
    [[YYNetwork sharedNetwork] requestWithPath:BASEURL(MARKET_GetKines) method:RequestTypeGet parameters:@{@"type":@(type),@"size":@(24)} success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        
        self.timeLineArray = [YYMarketModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
        
        NSArray<YYMarketModel *> *newArray = [[self.timeLineArray reverseObjectEnumerator] allObjects];
        
        // 给分时线赋值
        self.timeLineView.markeModel = (NSMutableArray *)newArray;
        
        self.kLineHistoryArray = [NSMutableArray arrayWithArray:newArray];
        [self requestNewData];
        
    } failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error) {
        
    }];
}

- (void)requestNewData {
    WEAKSELF;
    
    [[YYNetwork sharedNetwork] requestWithPath:BASEURL(MARKET_GetTicker5m) method:RequestTypeGet parameters:@{} success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        
        YYMarketModel *lastModel = [YYMarketModel mj_objectWithKeyValues:responseObject[@"data"]];
        
        weakSelf.kLineArray  = [self.kLineHistoryArray mutableCopy];
        
        [weakSelf.kLineArray addObject:lastModel];
        
        // 给K线赋值
        weakSelf.kLineView.markeModel = weakSelf.kLineArray;
        
        if (weakSelf.canPolling) {
            // 开启轮询
            [weakSelf openPolling];
        }
    } failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error) {
        // 如果请求失败，暂时显示39条历史数据
        self.kLineView.markeModel = self.kLineArray;
    }];
    
}

- (void)openPolling {
    
    self.canPolling = NO;
    // 开启轮询
    WEAKSELF;
    _timer = [HWWeakTimer scheduledTimerWithTimeInterval:10 block:^(id userInfo) {
        // 获取最新数据
        [weakSelf requestNewData];
        
    } userInfo:nil repeats:YES];
}


- (void)reloadWebSocketMessage:(NSNotification *)noti {
    
    YYMarketModel *lastModel = noti.userInfo[@"key"];
    
    // 显示买入和卖出价
    self.timeLineView.dataArray = @[lastModel.market.buy, lastModel.market.sell];
}

- (void)reloadPollingMessage:(NSNotification *)noti {
    
    YYMarketModel *lastModel = noti.userInfo[@"key"];
    
    // 显示买入和卖出价
    self.timeLineView.dataArray = @[lastModel.market.buy, lastModel.market.sell];
}

- (FZMTimeLineView *)timeLineView {
    if (!_timeLineView) {
        _timeLineView = [FZMTimeLineView shopView];
    }
    return _timeLineView;
}

- (FZMTradeKLineView *)kLineView {
    if (!_kLineView) {
        _kLineView = [FZMTradeKLineView shopView];
        WEAKSELF;
        _kLineView.didRequestKLineHandle = ^(NSInteger index) {
            [weakSelf requestData:index];
        };
    }
    return _kLineView;
}

- (NSMutableArray<YYMarketModel *> *)timeLineArray {
    if (!_timeLineArray) {
        _timeLineArray = [NSMutableArray new];
    }
    return _timeLineArray;
}

- (NSMutableArray<YYMarketModel *> *)kLineArray {
    if (!_kLineArray) {
        _kLineArray = [NSMutableArray new];
    }
    return _kLineArray;
}

- (NSMutableArray<YYMarketModel *> *)kLineHistoryArray {
    if (!_kLineHistoryArray) {
        _kLineHistoryArray = [NSMutableArray new];
    }
    return _kLineHistoryArray;
}

@end
