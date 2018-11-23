//
//  NSString+UrlCode.h
//  BBP
//
//  Created by 吴文拼 on 2017/5/25.
//  Copyright © 2017年 BBPP. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (UrlCode)

-(NSString *)URLEncodedString:(NSString *)str;

-(NSString *)URLDecodedString:(NSString *)str;

@end
