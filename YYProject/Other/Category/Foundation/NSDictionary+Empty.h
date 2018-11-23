//
//  NSDictionary+Empty.h
//  MZB
//
//  Created by 吴文拼 on 2017/11/10.
//  Copyright © 2017年 吴文拼. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (Empty)

- (id)safeValueForKey:(NSString *)key;

@end
