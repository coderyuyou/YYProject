//
//  NSObject+Empty.m
//  MZB
//
//  Created by 吴文拼 on 2017/11/10.
//  Copyright © 2017年 吴文拼. All rights reserved.
//

#import "NSObject+Empty.h"
#import "NSString+Empty.h"
@implementation NSObject (Empty)

+ (BOOL)empty:(NSObject *)o{
    if (o==nil) {
        return YES;
    }
    if (o==NULL) {
        return YES;
    }
    if (o==[NSNull new]) {
        return YES;
    }
    if ([o isKindOfClass:[NSString class]]) {
        return [NSString isValidString:(NSString *)o];
    }
    if ([o isKindOfClass:[NSData class]]) {
        return [((NSData *)o) length]<=0;
    }
    if ([o isKindOfClass:[NSDictionary class]]) {
        return [((NSDictionary *)o) count]<=0;
    }
    if ([o isKindOfClass:[NSArray class]]) {
        return [((NSArray *)o) count]<=0;
    }
    if ([o isKindOfClass:[NSSet class]]) {
        return [((NSSet *)o) count]<=0;
    }
    return NO;
}

@end
