//
//  NSString+CommonUseTool.h
//  BBP
//
//  Created by zczhao on 16/11/16.
//  Copyright © 2016年 TangYunfei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (CommonUseTool)


+(BOOL)isPhoneNumber:(NSString *)phoneNum;
+(NSString *)getSecurityPhoneNumber:(NSString *)phoneNum;
+ (BOOL)stringIsOnlyInNumberAndLetter:(NSString *)password;
- (instancetype)removedEmojiString;
+(NSString *)cleanString:(NSString *)content;

//获取中文首字母,如果空字符串返回#
+ (NSString *)firstCharactor:(NSString *)aString;
//汉字转英文字母 每个字空格分开
+ (NSString *)transformEnglishWithChinese:(NSString *)chinese;

@end
