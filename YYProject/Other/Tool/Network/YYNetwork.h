//
//  YYNetwork.h
//  YYProject
//
//  Created by 于优 on 2018/12/4.
//  Copyright © 2018 SuperYu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"
@class ResponseModel;

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, NetworkStatus) {
    StatusUnknown = 0,      //未知状态
    StatusNotReachable,     //无网状态
    StatusReachableViaWWAN, //手机网络
    StatusReachableViaWiFi, //Wifi网络
};

typedef NS_ENUM(NSInteger, RequestType) {
    RequestTypeGet,
    RequestTypePost,
    RequestTypeDelete,
    RequestTypePut,
};

@interface YYNetwork : NSObject

/** 定义请求成功的 block */
typedef void(^ResponseSuccess)(ResponseModel * response);
/** 定义请求失败的 block */
typedef void(^ResponseFail)(NSError *error);

+ (instancetype)sharedNetwork;

/**
 网络请求（Post）
 
 @param url 请求地址
 @param method 请求类型
 @param parameters 请求参数
 @param success 请求成功回调block
 @param failure 请求失败回调block
 */
- (void)requestWithPath:(NSString *)url
                 method:(NSInteger)method
             parameters:(id)parameters
                success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure;

- (void)requestWithPost:(NSString *)urlString
             parameters:(NSDictionary *)parameters
           successBlock:(ResponseSuccess)successBlock
           failureBlock:(ResponseFail)failureBlock;

/**
 *  向服务器上传单文件
 *
 *  @param url       要上传的文件接口
 *  @param parameter 上传的参数
 *  @param fileData  上传的文件\数据
 *  @param success   成功执行，block的参数为服务器返回的内容
 *  @param failure   执行失败，block的参数为错误信息
 */
- (void)POST:(NSString *)url
   Parameter:(NSDictionary *)parameter
        Data:(NSData *)fileData
     Success:(void(^)(id responseObject))success
     Failure:(void(^)(NSError *error))failure;


/**
 *  向服务器上传多文件
 *
 *  @param url       要上传的文件接口
 *  @param parameter 上传的参数
 *  @param fileDatas  上传的文件\数据的数组
 *  @param fieldNames 服务对应的字段
 *  @param fileNames  上传到时服务器的文件名的数组
 *  @param mimeType  上传的文件类型
 *  @param success   成功执行，block的参数为服务器返回的内容
 *  @param failure   执行失败，block的参数为错误信息
 */
- (void)POST:(NSString *)url
   Parameter:(NSDictionary *)parameter
       Datas:(NSArray<NSData *> *)fileDatas
  FieldNames:(NSArray<NSString *> *)fieldNames
   FileNames:(NSArray *)fileNames
    MimeType:(NSString *)mimeType
     Success:(void(^)(id responseObject))success
     Failure:(void(^)(NSError *error))failure;

/**
 *  向服务器上传多组多文件
 *
 *  @param url         要上传的文件接口
 *  @param parameter   上传的参数
 *  @param fileDatas   上传的文件\数据的数组
 *  @param fieldNames  服务对应的字段
 *  @param success     成功执行，block的参数为服务器返回的内容
 *  @param failure     执行失败，block的参数为错误信息
 */
- (void)POST:(NSString *)url
   Parameter:(NSDictionary *)parameter
       Datas:(NSArray<NSArray<NSData *> *> *)fileDatas
  FieldNames:(NSArray<NSArray<NSString *> *> *)fieldNames
     Success:(void(^)(id responseObject))success
     Failure:(void(^)(NSError *error))failure;

@end

@interface ResponseModel : NSObject

@property (nonatomic, assign) NSInteger statusCode;
@property (nonatomic, strong) id responseData;
@property (nonatomic, copy) NSString *message;
@property (nonatomic, assign) BOOL success;
@property (nonatomic, strong) NSDictionary *originalData;

- (instancetype)initWithResponse:(NSDictionary *)response;

NS_ASSUME_NONNULL_END
