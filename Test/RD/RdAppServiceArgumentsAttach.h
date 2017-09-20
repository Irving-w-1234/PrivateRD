//
//  RdAppServiceArgumentsAttach.h
//  Pods
//
//  Created by aaaa on 16/8/28.
//
//

#import <Foundation/Foundation.h>
#import "RdAppService/RdAppServiceConfig.h"
/**
 *  附加公共参数
 */
@interface RdAppServiceArgumentsAttach : NSObject<RdAppServiceConfigArgumentsProtocol>

@property (nonatomic, strong) NSString *appSecret;

@property (nonatomic, strong) NSString *appKey;

+(RdAppServiceArgumentsAttach *)sharedInstance;

- (NSString *)validateMD5EncryptionBody:(NSString *)bodyStr;   //appkey+提交参数 MD5加密  (例如验证短信验证码接口中)

/**
 *  初始化构造方法
 *
 *  @param bodyArguments   body公共参数
 *  @param headerArguments header公共参数
 *
 *  @return 返回实例对象
 */
- (instancetype)initWithBodyArguments:(NSDictionary *)bodyArguments headerArguments:(NSDictionary *)headerArguments;

+ (NSString *)md5WithString:(NSString *)str;
+ (NSString *)md5WithUpperString:(NSString *)str; //md5加密后转大写

#pragma mark -RdAppServiceConfigArgumentsProtocol 实现

- (NSDictionary *)rdAppServiceBodyArgumentsAttach:(NSDictionary *)sourceBody;

- (NSDictionary *)rdAppServiceHeaderArgumentsAttach:(NSDictionary *)sourceHeader;

- (BOOL)validationExpression:(NSString *)inputStr;

@end
