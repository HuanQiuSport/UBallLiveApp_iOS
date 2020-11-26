//
//  UBLUserInfo.h
//  UBallLive
//
//  Created by Jobs on 2020/11/18.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface UBLUserInfoModel : NSObject

@property(nonatomic,copy)NSString *usernameStr;
@property(nonatomic,copy)NSString *userIDStr;
@property(nonatomic,copy)NSString *userLoginTimeStr;
@property(nonatomic,copy)NSString *userToken;
@property(nonatomic,strong)UIImage *userHeaderIconIMG;

@end

@interface UBLUserInfo : NSObject

@property(nonatomic,strong)UBLUserInfoModel *userInfoModel;

+(instancetype)sharedInstance;

@end

NS_ASSUME_NONNULL_END
