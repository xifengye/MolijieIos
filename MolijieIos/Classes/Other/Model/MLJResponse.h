

#import <Foundation/Foundation.h>

typedef NS_OPTIONS(long long, ErrorCode) {
     InternalError = 999,//内部异常
     AppUnknown = 1000,//无法识别的客户端
     HeaderMissError = 1001,//缺少头部信息
     AppTokenError = 1002,//APP令牌异常
     UserTokenError = 1003,//用户令牌异常
     UserNotFound = 1004,//用户不存在
     ArgumentMissError = 1005,//缺少参数
     ArgumentDecodeError = 1006,//参数解码异常
     ActivateError = 1007,//账户激活异常
     OutOfStockError = 1008,//库存不足
};
@interface MLJResponse : NSObject

@property(nonatomic,copy)NSString* Message;
@property(nonatomic,assign)BOOL HasError;
@property(nonatomic,strong)id Data;
@property(nonatomic,assign)ErrorCode ErrorCode;

@end
