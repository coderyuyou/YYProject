//
//  NSUserDefaults+FZMUser.m
//  MZB
//
//  Created by 吴文拼 on 2017/12/12.
//  Copyright © 2017年 吴文拼. All rights reserved.
//

#import "NSUserDefaults+FZMUser.h"

@implementation NSUserDefaults (FZMUser)


- (NSString *)fzm_keyForCurrentUser:(NSString *)key
{
    return [NSString stringWithFormat:@"%@-%@",[self fzm_currentUsid], key];
}

- (NSString *)fzm_currentUsid
{
    NSString *usidInString = @"";
    
//    NSNumber *usid = [JTBLoginManager sharedInstance].currentUser.userId;
//
//    if (usid) {
//
//        if ([usid isKindOfClass:[NSNumber class]]) {
//            usidInString = [[JTBLoginManager sharedInstance].currentUser.userId stringValue];
//        } else {
//            usidInString = (NSString *)usid;
//        }
//    }

    return usidInString;
}





- (NSArray *)fzm_arrayForKey:(NSString *)defaultName
{
    NSString *keyForCurrentUser = [self fzm_keyForCurrentUser:defaultName];

    return [self arrayForKey:keyForCurrentUser];
}

- (BOOL)fzm_boolForKey:(NSString *)defaultName
{
    NSString *keyForCurrentUser = [self fzm_keyForCurrentUser:defaultName];

    return [self boolForKey:keyForCurrentUser];
}

- (NSData *)fzm_dataForKey:(NSString *)defaultName
{
    NSString *keyForCurrentUser = [self fzm_keyForCurrentUser:defaultName];

    return [self dataForKey:keyForCurrentUser];
}

- (NSDictionary *)fzm_dictionaryForKey:(NSString *)defaultName
{
    NSString *keyForCurrentUser = [self fzm_keyForCurrentUser:defaultName];

    return [self dictionaryForKey:keyForCurrentUser];
}

- (float)fzm_floatForKey:(NSString *)defaultName
{
    NSString *keyForCurrentUser = [self fzm_keyForCurrentUser:defaultName];

    return [self floatForKey:keyForCurrentUser];
}

- (NSInteger)fzm_integerForKey:(NSString *)defaultName
{
    NSString *keyForCurrentUser = [self fzm_keyForCurrentUser:defaultName];

    return [self integerForKey:keyForCurrentUser];
}

- (id)fzm_objectForKey:(NSString *)defaultName
{
    NSString *keyForCurrentUser = [self fzm_keyForCurrentUser:defaultName];

    return [self objectForKey:keyForCurrentUser];
}

- (NSArray *)fzm_stringArrayForKey:(NSString *)defaultName
{
    NSString *keyForCurrentUser = [self fzm_keyForCurrentUser:defaultName];

    return [self stringArrayForKey:keyForCurrentUser];
}

- (NSString *)fzm_stringForKey:(NSString *)defaultName
{
    NSString *keyForCurrentUser = [self fzm_keyForCurrentUser:defaultName];

    return [self stringForKey:keyForCurrentUser];
}

- (double)fzm_doubleForKey:(NSString *)defaultName
{
    NSString *keyForCurrentUser = [self fzm_keyForCurrentUser:defaultName];

    return [self doubleForKey:keyForCurrentUser];
}

- (NSURL *)fzm_URLForKey:(NSString *)defaultName
{
    NSString *keyForCurrentUser = [self fzm_keyForCurrentUser:defaultName];

    return [self URLForKey:keyForCurrentUser];
}

- (void)fzm_setBool:(BOOL)value forKey:(NSString *)defaultName
{
    NSString *keyForCurrentUser = [self fzm_keyForCurrentUser:defaultName];

    [self setBool:value forKey:keyForCurrentUser];
}

- (void)fzm_setFloat:(float)value forKey:(NSString *)defaultName
{
    NSString *keyForCurrentUser = [self fzm_keyForCurrentUser:defaultName];

    [self setFloat:value forKey:keyForCurrentUser];
}

- (void)fzm_setInteger:(NSInteger)value forKey:(NSString *)defaultName
{
    NSString *keyForCurrentUser = [self fzm_keyForCurrentUser:defaultName];

    [self setInteger:value forKey:keyForCurrentUser];
}

- (void)fzm_setObject:(id)value forKey:(NSString *)defaultName
{
    NSString *keyForCurrentUser = [self fzm_keyForCurrentUser:defaultName];

    [self setObject:value forKey:keyForCurrentUser];
}

- (void)fzm_setDouble:(double)value forKey:(NSString *)defaultName
{
    NSString *keyForCurrentUser = [self fzm_keyForCurrentUser:defaultName];

    [self setDouble:value forKey:keyForCurrentUser];
}

- (void)fzm_setURL:(NSURL *)url forKey:(NSString *)defaultName
{
    NSString *keyForCurrentUser = [self fzm_keyForCurrentUser:defaultName];

    [self setURL:url forKey:keyForCurrentUser];
}



- (void)fzm_removeObjectForKey:(NSString *)defaultName
{
    NSString *keyForCurrentUser = [self fzm_keyForCurrentUser:defaultName];

    [self removeObjectForKey:keyForCurrentUser];
}



@end

