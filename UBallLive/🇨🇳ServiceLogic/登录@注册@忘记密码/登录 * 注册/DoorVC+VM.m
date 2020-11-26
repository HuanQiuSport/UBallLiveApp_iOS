//
//  DoorVC+VM.m
//  MonkeyKingVideo
//
//  Created by Jobs on 2020/9/12.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import "DoorVC+VM.h"

@implementation DoorVC (VM)

-(void)clearTF{//不能写在弹框里面否则会崩  performSelector、withObject不能写在分类里面
    DoorInputViewStyle_3 *用户名 = (DoorInputViewStyle_3 *)self.loginContentView.inputViewMutArr[0];
    DoorInputViewStyle_3 *密码 = (DoorInputViewStyle_3 *)self.loginContentView.inputViewMutArr[1];
    用户名.tf.text = @"";
    密码.tf.text = @"";
}

///登录 
-(void)login_networkingWithUserName:(NSString *)account
                           passWord:(NSString *)password
                         originType:(originType)originType{

    NSDictionary *easyDict = @{
        @"account":account,//账号
        @"password":[password md5String],//密码
        @"originType":@(originType),
        @"deviceId":UDID,
        @"version":HDAppVersion
    };
    ///
//    NSLog(@"%@",easyDict);
    FMHttpRequest *req = [FMHttpRequest urlParametersWithMethod:HTTTP_METHOD_POST
                                                           path:[URL_Manager sharedInstance].MkLoginPOST
                                                     parameters:easyDict];
    self.reqSignal = [[FMARCNetwork sharedInstance] requestNetworkData:req];
    @weakify(self)
    [self.reqSignal subscribeNext:^(FMHttpResonse *response) {
        @strongify(self)
        if (response.isSuccess) {
//            NSLog(@"%@",response.reqResult);
            if ([response.reqResult isKindOfClass:NSDictionary.class]) {
                @try {
                    //登录成功走以下代码
                    //登陆成功以后记住账号和密码
                    [self.loginContentView storeAcc_Code];
                    NSError *error;
                    MKLoginModel *model = [[MKLoginModel alloc]initWithDictionary:(NSDictionary *)response.reqResult
                                                                            error:&error];
                    model.sex = [model.sex intValue] ? @"女" :@"男";//0、男;1、女
                    if (!error) {
                        [[MKLoginModel getUsingLKDBHelper] insertToDB:model callback:^(BOOL result) {
//                            NSLog(@"%@",result?@"成功":@"失败");
                        }];
                    }
//                    NSLog(@"登录成功%@",response.reqResult);
                    [MKTools shared]._isReloadRequest = YES;
                    [[NSNotificationCenter defaultCenter] postNotificationName:KLoginSuccessNotifaction object:nil];
                    [self overUI];
                    [self backBtnClickEvent:nil];
                    [SceneDelegate sharedInstance].customSYSUITabBarController.selectedIndex = 0;
                    
                    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
                    [userDefault setObject:model.nickName forKey:@"nickName"];
                    [userDefault setObject:model.uid forKey:@"UID"];
                    [userDefault synchronize];
                } @catch(NSException *exception) {
//                    NSLog(@"exception = %@", exception);
                } @finally {
                    self.loginContentView.userInteractionEnabled = YES;
                }
            }else{
                self.loginContentView.userInteractionEnabled = YES;
                [MBProgressHUD wj_showError:response.reqResult];
                //                [self clearTF];
            }
        }
    }];
}
///注册
-(void)register_networkingWithAccount:(NSString *)account
                             password:(NSString *)password
                      confirmPassword:(NSString *)confirmPassword
                           captchaKey:(NSString *)captchaKey
                              imgCode:(NSString *)imgCode
                           originType:(originType)originType{
    ///
    if([MKTools isBlankString:account]){
        [MBProgressHUD wj_showError:@"请输入账号"];
        return;
    }
    if([MKTools isBlankString:password]){
        [MBProgressHUD wj_showError:@"请输入密码"];
        return;
    }
    if([MKTools isBlankString:confirmPassword]){
        [MBProgressHUD wj_showError:@"请输入确认密码"];
        return;
    }
    if([MKTools isBlankString:imgCode]){
        [MBProgressHUD wj_showError:@"请输入验证码"];
        return;
    }
    if([MKTools isBlankString:account]
       ||[MKTools isBlankString:password]
       ||[MKTools isBlankString:confirmPassword]
       ||[MKTools isBlankString:captchaKey]
       ||[MKTools isBlankString:imgCode]){
        [MBProgressHUD wj_showError:@"您好,请填写注册信息"];
        return;
    }
    if([MKTools isBlankNULL:account]
       ||[MKTools isBlankNULL:password]
       ||[MKTools isBlankNULL:confirmPassword]
       ||[MKTools isBlankNULL:captchaKey]
       ||[MKTools isBlankNULL:imgCode]){
        [MBProgressHUD wj_showError:@"您好,请注册信息不能有空格"];
        return;
    }
    if([MKTools mkHanziCountCharNumber:account] != 0
       || [MKTools mkHanziCountCharNumber:password] != 0
       || [MKTools mkHanziCountCharNumber:confirmPassword] != 0
       || [MKTools mkHanziCountCharNumber:captchaKey] != 0
       || [MKTools mkHanziCountCharNumber:imgCode] != 0){
//        [MBProgressHUD wj_showError:@"您好,注册信息不能有中文"];
         [MBProgressHUD wj_showError:@"注册信息不能有中文"];
        return;
    }
    if( MIN(MAX([MKTools mkAlphaCountCharNumber:account],3),12)==3
       || MIN(MAX([MKTools mkAlphaCountCharNumber:account],3),12)== 12 ){
//        [MBProgressHUD wj_showError:@"您好,用户长度4～11"];
         [MBProgressHUD wj_showError:@"用户名长度为4-11位,请使用字母和数字"];
        return;
    }
    if( MIN(MAX([MKTools mkAlphaCountCharNumber:password],5),13)  ==  5
       || MIN(MAX([MKTools mkAlphaCountCharNumber:password],5),13) == 13 ){
//        [MBProgressHUD wj_showError:@"您好,用户密码长度6～12"];
         [MBProgressHUD wj_showError:@"密码长度为6-12位,请使用字母和数字"];
        return;
    }
    if( MIN(MAX([MKTools mkAlphaCountCharNumber:confirmPassword],5),13)  ==  5
       || MIN(MAX([MKTools mkAlphaCountCharNumber:confirmPassword],5),13) == 13 ){
//        [MBProgressHUD wj_showError:@"您好,确认密码长度6～12"];
        [MBProgressHUD wj_showError:@"确认密码长度为6-12位,请使用字母和数字"];
        return;
    }
    if( [MKTools mkAlphaCountCharNumber:imgCode] != 4 ){
//        [MBProgressHUD wj_showError:@"您好,图片验证吗长度是4个"];
        [MBProgressHUD wj_showError:@"验证码错误"];
        return;
    }

    
    NSDictionary *easyDict = @{
        @"account":account,//账号
        @"password":[password md5String],//密码
        @"confirmPassword":[confirmPassword md5String],
        @"captchaKey":captchaKey,
        @"imgCode":imgCode,
        @"originType":@(originType),
        @"deviceId":UDID,
        @"version":HDAppVersion,
        @"channelUrl":@""
    };
    ///
    FMHttpRequest *req = [FMHttpRequest urlParametersWithMethod:HTTTP_METHOD_POST
                                                           path:[URL_Manager sharedInstance].MKLoginRegisterPOST
                                                     parameters:easyDict];
    self.reqSignal = [[FMARCNetwork sharedInstance] requestNetworkData:req];
    @weakify(self)
    [self.reqSignal subscribeNext:^(FMHttpResonse *response) {
        @strongify(self)
        if (response.isSuccess) {
//            NSLog(@"%@",response.reqResult);
            //注册成功即登录
            if ([response.reqResult isKindOfClass:NSDictionary.class]) {
                //登录成功走以下代码
                NSError *error;
                MKLoginModel *model = [[MKLoginModel alloc]initWithDictionary:(NSDictionary *)response.reqResult
                                                                        error:&error];
                model.sex = [model.sex intValue] ? @"女" :@"男";//0、男;1、女
                if (!error) {
                    [[MKLoginModel getUsingLKDBHelper] insertToDB:model callback:^(BOOL result) {
//                        NSLog(@"%@",result?@"成功":@"失败");
                    }];
                }
//                NSLog(@"登录成功%@",response.reqResult);
//                NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
//                [userDefault setObject:model.nickName forKey:@"nickName"];
//                [userDefault synchronize];
//                 DLog(@"用户名%@",model.nickName);
                [MBProgressHUD wj_showSuccess:@"登录成功"];
                [MKTools shared]._isReloadRequest = YES;
                [[NSNotificationCenter defaultCenter] postNotificationName:KLoginSuccessNotifaction object:nil];
                self.loginContentView = nil;
                [self backBtnClickEvent:nil];
             
                [SceneDelegate sharedInstance].customSYSUITabBarController.selectedIndex = 0;
                [[self.view subviews] makeObjectsPerformSelector:@selector(removeFromSuperview)];
            }else{
                [MBProgressHUD wj_showError:response.reqResult];
                [self clearTF];
            }
        }
    }];
}

@end
