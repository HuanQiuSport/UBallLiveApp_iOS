//
//  MBProgressHUD+UBL.m
//  UBallLive
//
//  Created by John on 2020/11/18.
//

#import "MBProgressHUD+UBL.h"

//默认2秒
#define kDefaultTimer 2
@interface MBProgressHUD ()


@end
@implementation MBProgressHUD (UBL)

#pragma mark - 显示成功
#pragma mark -- showSuccess
+ (void)showSuccess:(NSString *)success{
    [self showSuccess:success toView:nil];
}

+ (void)showSuccess:(NSString *)success toView:(UIView *)view{
    [self show:success icon:@"" view:view];
}

#pragma mark - 显示错误信息
#pragma mark -- showError
+ (void)showError:(NSString *)error{
    [self showError:error toView:nil];
}

+ (void)showError:(NSString *)error toView:(UIView *)view{
    if(!error || [@"" isEqualToString:error])return;
    [self show:error icon:@"" view:view];
}

#pragma mark - 显示信息
#pragma mark -- showLoadingMessage
+ (MBProgressHUD *)showLoadingMessage:(NSString *)message{
    return [self showLoadingMessage:message toView:nil];
}

+ (MBProgressHUD *)showLoadingMessage:(NSString *)message toView:(UIView *)view {
    return [self showLoadingMessage:message toView:view delay:0];
}

+ (MBProgressHUD *)showLoadingMessage:(NSString *)message toView:(UIView *)view delay:(float)delay {
    if (view == nil) view = [UIApplication sharedApplication].keyWindow;
    [MBProgressHUD hideHUDForView:view];
    MBProgressHUD *hud = [[MBProgressHUD alloc] initWithView:view];
    hud.graceTime = delay;
    hud.bezelView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.7];
    hud.contentColor = [UIColor colorWithWhite:1 alpha:0.8];
    hud.label.text = message;
    hud.label.font = kFontSize(14);
    hud.label.numberOfLines = 0;
    hud.removeFromSuperViewOnHide = YES;
    hud.margin = 15;
    hud.userInteractionEnabled = YES;
    [view addSubview:hud];
    [hud showAnimated:YES];
    return hud;
}

#pragma mark - 显示信息
#pragma mark -- show
+ (void)show:(NSString *)text icon:(NSString *)icon view:(UIView *)view {
    if (view == nil)
        view = [UIApplication sharedApplication].keyWindow;
    // 快速显示一个提示信息
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];

    [hud showText:text delay:kDefaultTimer];
}

#pragma mark - 隐藏
#pragma mark -- hideHUD
+ (void)hideHUD{
    [self hideHUDForView:nil];
}

+ (void)hideHUDForView:(UIView *)view{
    if (view == nil)
    view = [UIApplication sharedApplication].keyWindow;
    [self hideHUDForView:view animated:YES];
}

#pragma mark - 根据文案长度调整显示时间，最短2秒
#pragma mark -- showText
- (void)showText:(NSString *)text {
    [self showText:text delay:MIN(kDefaultTimer, text.length/5.0)];
}
#pragma mark - 延迟
#pragma mark -- showText
- (void)showText:(NSString *)text delay:(float)delay {
    self.bezelView.style = MBProgressHUDBackgroundStyleSolidColor;
    self.bezelView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.7];
    self.contentColor = [UIColor colorWithWhite:1 alpha:0.8];
    self.label.font = kFontSize(14);
    self.label.text = text;
    self.label.numberOfLines = 0;
    self.mode = MBProgressHUDModeText;
    self.removeFromSuperViewOnHide = YES;
    self.userInteractionEnabled = NO;
    [self hideAnimated:YES afterDelay:delay];
}


@end
