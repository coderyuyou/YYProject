//
//  YYDataValueFormatter.h
//  YYProject
//
//  Created by 于优 on 2018/12/6.
//  Copyright © 2018 SuperYu. All rights reserved.
//

#import <Foundation/Foundation.h>
@import Charts;

NS_ASSUME_NONNULL_BEGIN

@interface YYDataValueFormatter : NSObject <IChartAxisValueFormatter>

- (id)initWithXAxisArr:(NSArray *)arr;

- (id)initWithYAxisLength:(NSInteger)length;

@end

NS_ASSUME_NONNULL_END
