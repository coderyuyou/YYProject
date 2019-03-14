//
//  YYCountDownManager.m
//  YYProject
//
//  Created by 于优 on 2019/3/13.
//  Copyright © 2019 SuperYu. All rights reserved.
//

#import "YYCountDownManager.h"

@interface OYTimeInterval ()

@property (nonatomic, assign) NSInteger timeInterval;

+ (instancetype)timeInterval:(NSInteger)timeInterval;

@end

@implementation OYTimeInterval

+ (instancetype)timeInterval:(NSInteger)timeInterval {
    OYTimeInterval *object = [OYTimeInterval new];
    object.timeInterval = timeInterval;
    return object;
}

@end


@interface YYCountDownManager ()

@property (nonatomic, strong) NSTimer *timer;

/// 时间差字典(单位:秒)(使用字典来存放, 支持多列表或多页面使用)
@property (nonatomic, strong) NSMutableDictionary<NSString *, OYTimeInterval *> *timeIntervalDict;

/// 后台模式使用, 记录进入后台的绝对时间
@property (nonatomic, assign) BOOL backgroudRecord;
@property (nonatomic, assign) CFAbsoluteTime lastTime;

@end

@implementation YYCountDownManager

+(instancetype)share
{
    static YYCountDownManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[YYCountDownManager alloc]init];
    });
    return manager;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        // 监听进入前台与进入后台的通知
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationDidEnterBackgroundNotification) name:UIApplicationDidEnterBackgroundNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationWillEnterForegroundNotification) name:UIApplicationWillEnterForegroundNotification object:nil];
    }
    return self;
}

- (void)start {
    // 启动定时器
    [self timer];
}

- (void)reload {
    // 刷新只要让时间差为0即可
    _timeInterval = 0;
}

- (void)invalidate {
    [self.timer invalidate];
    self.timer = nil;
}

- (void)timerAction {
    // 定时器每次加1
    [self timerActionWithTimeInterval:1];
}

- (void)timerActionWithTimeInterval:(NSInteger)timeInterval {
    // 时间差+
    self.timeInterval += timeInterval;
    [self.timeIntervalDict enumerateKeysAndObjectsUsingBlock:^(NSString * _Nonnull key, OYTimeInterval * _Nonnull obj, BOOL * _Nonnull stop) {
        obj.timeInterval += timeInterval;
    }];
    //回到主线程 发出通知
    dispatch_async(dispatch_get_main_queue(), ^{
        [[NSNotificationCenter defaultCenter] postNotificationName:OYCountDownNotification object:nil userInfo:nil];
    });
    
}

- (void)addSourceWithIdentifier:(NSString *)identifier {
    OYTimeInterval *timeInterval = self.timeIntervalDict[identifier];
    if (timeInterval)
    {
        timeInterval.timeInterval = 0;
    }else
    {
        [self.timeIntervalDict setObject:[OYTimeInterval timeInterval:0] forKey:identifier];
    }
}

- (NSInteger)timeIntervalWithIdentifier:(NSString *)identifier
{
    return self.timeIntervalDict[identifier].timeInterval;
}

- (void)reloadSourceWithIdentifier:(NSString *)identifier {
    self.timeIntervalDict[identifier].timeInterval = 0;
}

- (void)reloadAllSource {
    [self.timeIntervalDict enumerateKeysAndObjectsUsingBlock:^(NSString * _Nonnull key, OYTimeInterval * _Nonnull obj, BOOL * _Nonnull stop) {
        obj.timeInterval = 0;
    }];
}

- (void)removeSourceWithIdentifier:(NSString *)identifier
{
    [self.timeIntervalDict removeObjectForKey:identifier];
}

- (void)removeAllSource
{
    [self.timeIntervalDict removeAllObjects];
}

- (void)applicationDidEnterBackgroundNotification {
    self.backgroudRecord = (_timer != nil);
    if (self.backgroudRecord) {
        self.lastTime = CFAbsoluteTimeGetCurrent();
        [self invalidate];
    }
}

- (void)applicationWillEnterForegroundNotification {
    if (self.backgroudRecord) {
        CFAbsoluteTime timeInterval = CFAbsoluteTimeGetCurrent() - self.lastTime;
        // 取整
        [self timerActionWithTimeInterval:(NSInteger)timeInterval];
        [self start];
    }
}

- (NSTimer *)timer {
    if (_timer == nil) {
        WEAKSELF;
        dispatch_queue_t queue = dispatch_queue_create("timer_queue", DISPATCH_QUEUE_CONCURRENT);
        //将计时器加入子线程
        dispatch_async(queue, ^{
            weakSelf.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timerAction) userInfo:nil repeats:YES];
            NSLog(@"thread____%@", [NSThread currentThread]);
            [[NSRunLoop currentRunLoop] addTimer:weakSelf.timer forMode:NSRunLoopCommonModes];
            [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]];
        });
        
    }
    return _timer;
}

- (NSMutableDictionary *)timeIntervalDict {
    if (!_timeIntervalDict) {
        _timeIntervalDict = [NSMutableDictionary dictionary];
    }
    return _timeIntervalDict;
}

NSString *const OYCountDownNotification = @"OYCountDownNotification";

@end

