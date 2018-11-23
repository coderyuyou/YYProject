//
//  NSUserDefaults+FZMUser.h
//  MZB
//
//  Created by 吴文拼 on 2017/12/12.
//  Copyright © 2017年 吴文拼. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSUserDefaults (FZMUser)

- (NSArray *)fzm_arrayForKey:(NSString *)defaultName;

- (BOOL)fzm_boolForKey:(NSString *)defaultName;

- (NSData *)fzm_dataForKey:(NSString *)defaultName;

- (NSDictionary *)fzm_dictionaryForKey:(NSString *)defaultName;

- (float)fzm_floatForKey:(NSString *)defaultName;

- (NSInteger)fzm_integerForKey:(NSString *)defaultName;

- (id)fzm_objectForKey:(NSString *)defaultName;

- (NSArray *)fzm_stringArrayForKey:(NSString *)defaultName;

- (NSString *)fzm_stringForKey:(NSString *)defaultName;

- (double)fzm_doubleForKey:(NSString *)defaultName;

- (NSURL *)fzm_URLForKey:(NSString *)defaultName;



- (void)fzm_setBool:(BOOL)value forKey:(NSString *)defaultName;

- (void)fzm_setFloat:(float)value forKey:(NSString *)defaultName;

- (void)fzm_setInteger:(NSInteger)value forKey:(NSString *)defaultName;

- (void)fzm_setObject:(id)value forKey:(NSString *)defaultName;

- (void)fzm_setDouble:(double)value forKey:(NSString *)defaultName;

- (void)fzm_setURL:(NSURL *)url forKey:(NSString *)defaultName;



- (void)fzm_removeObjectForKey:(NSString *)defaultName;

@end

