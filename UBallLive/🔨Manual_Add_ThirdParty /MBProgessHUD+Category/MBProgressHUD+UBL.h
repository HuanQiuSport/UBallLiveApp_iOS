//
//  MBProgressHUD+UBL.h
//  UBallLive
//
//  Created by John on 2020/11/18.
//


#import <MBProgressHUD/MBProgressHUD.h>

NS_ASSUME_NONNULL_BEGIN

@interface MBProgressHUD (UBL)

// 显示成功
+ (void)showSuccess:(NSString *)success;
+ (void)showSuccess:(NSString *)success toView:(UIView *)view;

// 显示错误
+ (void)showError:(NSString *)error;
+ (void)showError:(NSString *)error toView:(UIView *)view;

// 显示加载中
+ (MBProgressHUD *)showLoadingMessage:(NSString *)message;
+ (MBProgressHUD *)showLoadingMessage:(NSString *)message toView:(UIView *)view;
+ (MBProgressHUD *)showLoadingMessage:(NSString *)message toView:(UIView *)view delay:(float)delay;

// 隐藏
+ (void)hideHUD;
+ (void)hideHUDForView:(UIView *)view;

// 显示文案 加延迟时间
- (void)showText:(NSString *)text;
- (void)showText:(NSString *)text delay:(float)delay;

@end

NS_ASSUME_NONNULL_END
