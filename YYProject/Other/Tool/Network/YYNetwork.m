//
//  YYNetwork.m
//  YYProject
//
//  Created by 于优 on 2018/12/4.
//  Copyright © 2018 SuperYu. All rights reserved.
//

#import "YYNetwork.h"
#import "YYProgressHUD.h"

@interface YYNetwork ()

@property (nonatomic, strong) AFHTTPSessionManager *manager;

@end

@implementation YYNetwork

YYSingletonM(Network)

- (instancetype)init {
    
    if (self = [super init]) {
        
        self.manager = [AFHTTPSessionManager manager];
        // 请求参数序列化类型
        self.manager.requestSerializer = [AFHTTPRequestSerializer serializer];
        // 响应结果序列化类型
        self.manager.responseSerializer = [AFJSONResponseSerializer serializer];
        // 接受内容类型
        self.manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", @"text/plain", nil];
        // timeout
        self.manager.requestSerializer.timeoutInterval = 30.0f;
        
        [self.manager.requestSerializer setValue:@"application/x-www-form-urlencoded; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
        // https相关
        AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
        [securityPolicy setValidatesDomainName:NO];
        [securityPolicy setAllowInvalidCertificates:YES];
        self.manager.securityPolicy = securityPolicy;
        
        //    if ([FZMUserInfoManager sharedManager].cookie) {
        //        [self.manager.requestSerializer setValue:[FZMUserInfoManager sharedManager].cookie forHTTPHeaderField:@"Cookie"];
        //    }
        
        // self.manager.requestSerializer.HTTPMethodsEncodingParametersInURI = [NSSet setWithObjects:@"GET", @"HEAD",nil];
        //设备相关信息
        // NSString *userAgent = [NSString stringWithFormat:@"%@/%@ (%@; iOS %@; Scale/%0.2f)", [[NSBundle mainBundle] infoDictionary][(__bridge NSString *)kCFBundleNameKey] ?: [[NSBundle mainBundle] infoDictionary][(__bridge NSString *)kCFBundleIdentifierKey], [[NSBundle mainBundle] infoDictionary][@"CFBundleShortVersionString"] ?: [[NSBundle mainBundle] infoDictionary][(__bridge NSString *)kCFBundleVersionKey], [[UIDevice currentDevice] model], [[UIDevice currentDevice] systemVersion], [[UIScreen mainScreen] scale]];
        
        // [self.manager.requestSerializer setValue:userAgent forHTTPHeaderField:@"User-Agent"];
    }
    
    return self;
}

- (void)requestWithPath:(NSString *)url method:(NSInteger)method parameters:(id)parameters success:(void (^)(NSURLSessionDataTask *task, id responseObject))success failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure {
    
    //网络检查
    [YYNetwork checkingNetworkResult:^(NetworkStatus status) {
        if (status == StatusNotReachable) return;
    }];
    
    NSLog(@"--请求详情--\n请求头: %@\n请求URL: %@\n请求param: %@\n\n",self.manager.requestSerializer.HTTPRequestHeaders, url, parameters);
    
    switch (method) {
        case RequestTypeGet: {
            [self.manager POST:url parameters:parameters progress:nil success:success failure:failure];
        }
            break;
        case RequestTypePost: {
            [self.manager POST:url parameters:parameters progress:nil success:success failure:failure];
        }
            break;
        case RequestTypeDelete: {
            [self.manager DELETE:url parameters:parameters success:success failure:failure];
        }
            break;
        case RequestTypePut: {
            [self.manager PUT:url parameters:parameters success:success failure:false];
        }
            break;
    }
}


- (void)uploadFile:(NSString *)url
         parameter:(NSDictionary *)parameter
          fileData:(NSData *)fileData
              name:(NSString *)name
          fileName:(NSString *)fileName
          progress:(void (^)(NSProgress *progress))progress
           success:(void(^)(id responseObject))success
           failure:(void(^)(NSError *error))failure {
    //网络检查
    [YYNetwork checkingNetworkResult:^(NetworkStatus status) {
        if (status == StatusNotReachable) return;
    }];
    
    [self.manager POST:url parameters:parameter constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        NSString *mimeType = @"image/jpg";
        /**
         拼接data到 HTTP body
         mimeType JPG:image/jpg, PNG:image/png, JSON:application/json
         */
        [formData appendPartWithFileData:fileData name:name fileName:fileName mimeType:mimeType];
        
        //表单拼接参数data
        [parameter enumerateKeysAndObjectsUsingBlock:^(id key, id  obj, BOOL *stop) {
            NSString *objStr = [NSString stringWithFormat:@"%@", obj];
            NSData *objData = [objStr dataUsingEncoding:NSUTF8StringEncoding];
            [formData appendPartWithFormData:objData name:key];
        }];
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
        progress(uploadProgress);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        success(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        failure(error);
    }];
}

- (void)uploadFileSet:(NSString *)url
            parameter:(NSDictionary *)parameter
            fileDatas:(NSArray<NSData *> *)fileDatas
                names:(NSArray<NSString *> *)names
            fileNames:(NSArray *)fileNames
             progress:(void (^)(NSProgress * _Nonnull))progress
              success:(void (^)(id _Nonnull))success
              failure:(void (^)(NSError * _Nonnull))failure {
    //网络检查
    [YYNetwork checkingNetworkResult:^(NetworkStatus status) {
        if (status == StatusNotReachable) return;
    }];
    
    [self.manager POST:url parameters:parameter constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        NSString *mimeType = @"image/jpg";
        /**
         拼接data到 HTTP body
         mimeType JPG:image/jpg, PNG:image/png, JSON:application/json
         */
        for (int i = 0; i < fileNames.count; i ++) {
            [formData appendPartWithFileData:fileDatas[i] name:names[i] fileName:fileNames[i] mimeType:mimeType];
        }

    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
        progress(uploadProgress);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        success(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        failure(error);
    }];
}

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
- (void)uploadGroupFile:(NSString *)url
   Parameter:(NSDictionary *)parameter
       Datas:(NSArray<NSArray<NSData *> *> *)fileDatas
  FieldNames:(NSArray<NSArray<NSString *> *> *)fieldNames
     Success:(void(^)(id responseObject))success
     Failure:(void(^)(NSError *error))failure {
    
    //网络检查
    [YYNetwork checkingNetworkResult:^(NetworkStatus status) {
        if (status == StatusNotReachable) return;
    }];
    
    [self.manager POST:url parameters:parameter constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        // 准备图片数据
        NSMutableArray *imgAry = [[NSMutableArray alloc] init];
        for (NSArray<NSData *> *array  in fileDatas) {
            for (NSData *data in array) {
                [imgAry addObject:data];
            }
        }
        // 准备服务器名称地址
        NSMutableArray *nameAry = [[NSMutableArray alloc] init];
        for (NSArray<NSString *> *array  in fieldNames) {
            for (NSString *name in array) {
                [nameAry addObject:name];
            }
        }
        
        NSAssert(imgAry.count != nameAry.count, @"数据源不匹配！！！");
        for (NSInteger i = 0; i < imgAry.count; i ++) {
            // 设置时间戳
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            formatter.dateFormat = @"yyyyMMddHHmmssSSS";
            NSString *str = [formatter stringFromDate:[NSDate date]];
            NSString *fileName = [NSString stringWithFormat:@"%@.jpg", str];
            
            [formData appendPartWithFileData:imgAry[i] name:nameAry[i] fileName:fileName mimeType:@"image/jpeg"];
        }
        
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        if (success) success(responseObject);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {

        if (failure) failure(error);
    }];
    
}

/**
 监听网络状态的变化
 */
+ (void)checkingNetworkResult:(void (^)(NetworkStatus))result {
    
    AFNetworkReachabilityManager *reachabilityManager = [AFNetworkReachabilityManager sharedManager];
    [reachabilityManager startMonitoring];
    [reachabilityManager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        
        switch (status) {
            case AFNetworkReachabilityStatusUnknown:
                if (result) result(StatusUnknown);
                break;
            case AFNetworkReachabilityStatusNotReachable:
                if (result) result(StatusNotReachable);
                [YYProgressHUD showPlainText:@"请检查网络连接！" view:nil];
                break;
            case AFNetworkReachabilityStatusReachableViaWWAN:
                if (result) result(StatusReachableViaWWAN);
                break;
            case AFNetworkReachabilityStatusReachableViaWiFi:
                if (result) result(StatusReachableViaWiFi);
                break;
        }
    }];
}


@end

@implementation ResponseModel

- (instancetype)initWithResponse:(NSDictionary *)response {
    if (self = [super init]) {
        self.statusCode = [response[@"code"] integerValue];
        self.responseData = response[@"data"]&&![response[@"data"] isEqual:[NSNull null]]?response[@"data"]:nil;
        self.message = response[@"message"]&&![response[@"message"] isEqual:[NSNull null]]?response[@"message"]:@"";
        self.success = [response[@"success"] boolValue];
        self.originalData = response;
    }
    return self;
}


@end
