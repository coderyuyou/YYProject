//
//  YYDataValueFormatter.m
//  YYProject
//
//  Created by 于优 on 2018/12/6.
//  Copyright © 2018 SuperYu. All rights reserved.
//

#import "YYDataValueFormatter.h"

@interface YYDataValueFormatter ()

/** 数据源 */
@property (nonatomic, strong) NSArray *xArr;
/** 数据源 */
@property (nonatomic, assign) NSInteger length;

@end

@implementation YYDataValueFormatter

- (id)initWithXAxisArr:(NSArray *)arr {
    
    self = [super init];
    
    if (self) {
        _xArr = arr;
    }
    
    return self;
}

- (id)initWithYAxisLength:(NSInteger)length {
    self = [super init];
    
    if (self) {
        _length = length;
    }
    
    return self;
}

- (NSString *)stringForValue:(double)value axis:(ChartAxisBase *)axis {
    
    if ([axis isKindOfClass:[ChartXAxis class]]) {
        return _xArr[(NSInteger)value];
    }
    
    else if ([axis isKindOfClass:[ChartYAxis class]]) {
        if (_length == 3) {
            return [NSString stringWithFormat:@"%.3f",value];
        }
        else if (_length == 4) {
            return [NSString stringWithFormat:@"%.4f",value];
        }
    }
    return @"";
}

@end
