//
//  NSDictionary+Empty.m
//  MZB
//
//  Created by 吴文拼 on 2017/11/10.
//  Copyright © 2017年 吴文拼. All rights reserved.
//

#import "NSDictionary+Empty.h"
#import "NSObject+Empty.h"
@implementation NSDictionary (Empty)

- (id)safeValueForKey:(NSString *)key {
    if (key == nil) {
        return nil;
    }
    if (([NSObject empty:self] || [NSObject empty:[self valueForKey:key]] || [self isKindOfClass:[NSNull class]]) && ![[self valueForKey:key] isEqual:@""]) {
        return nil;
    }
    
    return [self valueForKey:key];
}

@end
