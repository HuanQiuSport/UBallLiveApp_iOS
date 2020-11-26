//
//  ForgetCodeVC+VM.m
//  MonkeyKingVideo
//
//  Created by Jobs on 2020/9/12.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import "ForgetCodeVC+VM.h"

@implementation ForgetCodeVC (VM)
///找回密码接口-修改密码
-(void)MKLoginChangePassword_netWorkingWithAccount:(NSString *)account
                                          telPhone:(NSString *)telPhone
                                           smsCode:(NSString *)smsCode
                                          password:(NSString *)password
                                   confirmPassword:(NSString *)confirmPassword
                                        originType:(originType)originType{
    NSDictionary *easyDict = @{
        @"account":account,//账号
        @"tel":telPhone,//手机号
        @"smsCode":smsCode,//手机验证码
        @"password":[password md5String],//密码，MD5加密
        @"confirmPassword":[confirmPassword md5String],//确认密码，MD5加密
        @"originType":@(originType_Apple),
        @"deviceId":UDID
    };
    ///
    FMHttpRequest *req = [FMHttpRequest urlParametersWithMethod:HTTTP_METHOD_POST
                                                           path:[URL_Manager sharedInstance].MKLoginChangePasswordPOST
                                                     parameters:easyDict];
    self.reqSignal = [[FMARCNetwork sharedInstance] requestNetworkData:req];
    @weakify(self)
    [self.reqSignal subscribeNext:^(FMHttpResonse *response) {
        @strongify(self)
        if (response.isSuccess) {
            if ([response.reqResult isKindOfClass:NSString.class]) {
                if (response.code == 200){
                    [self.step_02 removeForgetCodeStep_02ViewWithOffsetY:0];
                    [UIView animationAlert:self.successBtn];
                    DoorInputViewStyle_1 *doorInputViewStyle_1 = (DoorInputViewStyle_1 *)self.step_02.inputViewMutArr[0];
                    [doorInputViewStyle_1.countDownBtn timerDestroy];//销毁倒计时的定时器
                    self.Step += 1;
                    if (self.currentFlowSerialNum < self.flowNum - 1) {
                        self.currentFlowSerialNum += 1;
                        [self.findCodeFlowChartView removeFromSuperview];
                        self.findCodeFlowChartView = nil;
                        self.findCodeFlowChartView.currentFlowSerialNum = self.currentFlowSerialNum;
                        
                        [self.nextStepBtn setTitle:@"去登录"
                                            forState:UIControlStateNormal];
                        @weakify(self)
                        [[self.nextStepBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
                            @strongify(self)
                            [self removeAll];
                            [self backBtnClickEvent:x];
                        }];
                    }
                }else{
                    [MBProgressHUD wj_showError:response.reqResult];
                }
            }
        }
    }];
}
///找回密码接口-身份验证
-(void)MKLoginCheckIdentity_netWorkingWithTel:(NSString *)tel
                                      account:(NSString *)account{
    NSDictionary *easyDict = @{
        @"tel":tel,//手机号码
        @"account":account,//账号
    };
    ///
    FMHttpRequest *req = [FMHttpRequest urlParametersWithMethod:HTTTP_METHOD_POST
                                                           path:[URL_Manager sharedInstance].MKLoginCheckIdentityPOST
                                                     parameters:easyDict];
    self.reqSignal = [[FMARCNetwork sharedInstance] requestNetworkData:req];
    @weakify(self)
    [self.reqSignal subscribeNext:^(FMHttpResonse *response) {
        @strongify(self)
        if (response.isSuccess) {
            if ([response.reqResult isKindOfClass:NSString.class]) {//response.isSuccess
                NSString *str = (NSString *)response.reqResult;
                if ([str isEqualToString:@"验证成功"]) {
                    //成功了 跳转下一步 的同时请求验证码接口
                    DoorInputViewStyle_3 *手机号码 = self.step_01.inputViewMutArr[1];
                    [self MKLoginSendSmsCode_netWorkingWithTel:手机号码.tf.text
                                                    clockBlock:^(id data) {
                        
                    }];
                    self.Step += 1;
                    
                    if (self.currentFlowSerialNum < self.flowNum - 1) {
                        self.currentFlowSerialNum += 1;
                        [self.findCodeFlowChartView removeFromSuperview];
                        self.findCodeFlowChartView = nil;
                        self.findCodeFlowChartView.currentFlowSerialNum = self.currentFlowSerialNum;
                    }
                    
                    self.nextStepBtn.enabled = NO;
                    self.nextStepBtn.alpha = 0.7;
                }else{
//                    [MBProgressHUD wj_showError:response.reqResult];
                }
            }
        }
    }];
}
///找回密码—发送短信
-(void)MKLoginSendSmsCode_netWorkingWithTel:(NSString *)tel
                                 clockBlock:(MKDataBlock)clockBlock{
    NSDictionary *easyDict = @{
        @"tel":tel,//手机号码
        @"areaCode":@"86",//手机号区号
        @"sendType":[NSNumber numberWithInt:2],//发送短信类型 0、注册登录;1、绑定银行卡;2、找回密码；3、绑定手机号
        @"originType":@(originType_Apple),
        @"deviceId":UDID
    };
    ///
    FMHttpRequest *req = [FMHttpRequest urlParametersWithMethod:HTTTP_METHOD_POST
                                                           path:[URL_Manager sharedInstance].MKLoginSendSmsCodePOST
                                                     parameters:easyDict];
    self.reqSignal = [[FMARCNetwork sharedInstance] requestNetworkData:req];
    @weakify(self)
    [self.reqSignal subscribeNext:^(FMHttpResonse *response) {
        @strongify(self)
        if (response.isSuccess) {
            if ([response.reqResult isKindOfClass:NSString.class]) {

                [self.step_01 removeForgetCodeStep_01ViewWithOffsetY:0];
                [self.step_02 showForgetCodeStep_02ViewWithOffsetY:0];
                if (clockBlock) {
                    clockBlock(response.reqResult);
                }
                //
                [[NSNotificationCenter defaultCenter] postNotificationName:@"短信验证码时间"
                                                                    object:response.reqResult];
            }
        }
    }];
}

@end
