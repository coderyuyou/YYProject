//
//  NSArray+Empty.m
//  MZB
//
//  Created by 吴文拼 on 2017/11/10.
//  Copyright © 2017年 吴文拼. All rights reserved.
//

#import "NSArray+Empty.h"

@implementation NSArray (Empty)

- (id)safeObjectAtIndex:(NSUInteger)index
{
    if ( index >= self.count )
        return nil;
    
    return [self objectAtIndex:index];
}

@end
