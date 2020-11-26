//
//  ForgetCodeVC+VM.h
//  MonkeyKingVideo
//
//  Created by Jobs on 2020/9/12.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import "ForgetCodeVC.h"

NS_ASSUME_NONNULL_BEGIN

@interface ForgetCodeVC (VM)

///找回密码接口-修改密码
-(void)MKLoginChangePassword_netWorkingWithAccount:(NSString *)account
                                          telPhone:(NSString *)telPhone
                                           smsCode:(NSString *)smsCode
                                          password:(NSString *)password
                                   confirmPassword:(NSString *)confirmPassword
                                        originType:(originType)originType;
///找回密码接口-身份验证
-(void)MKLoginCheckIdentity_netWorkingWithTel:(NSString *)tel
                                      account:(NSString *)account;
///找回密码—发送短信
-(void)MKLoginSendSmsCode_netWorkingWithTel:(NSString *)tel
                                 clockBlock:(MKDataBlock)clockBlock;


@end

NS_ASSUME_NONNULL_END
