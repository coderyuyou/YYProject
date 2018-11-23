//
//  NSString+Empty.m
//  MZB
//
//  Created by 吴文拼 on 2017/11/10.
//  Copyright © 2017年 吴文拼. All rights reserved.
//

#import "NSString+Empty.h"

@implementation NSString (Empty)

+ (BOOL)isValidString:(NSString *)string {
    if (string == nil) {
        return YES;
    }
    if (string == NULL) {
        return YES;
    }
    if (    [string isEqual:nil]
        ||  [string isEqual:Nil]){
        return YES;
    }
    if (![string isKindOfClass:[NSString class]]) {
        return YES;
    }
    if (0 == [string length]){
        return YES;
    }
    if ([[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] length]==0) {
        return YES;
    }
    
    if ([string isKindOfClass:[NSNull class]]) {
        return YES;
    }
    
    if([string isEqualToString:@"(null)"]){
        return YES;
    }
    if ([string isEqualToString:@"nullnull"]) {
        return YES;
    }
    
    return NO;
}

@end
