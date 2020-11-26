//
//  DoorVC.h
//  Shooting
//
//  Created by Jobs on 2020/9/3.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import "UBLDoor.h"
#import "CustomZFPlayerControlView.h"
#import "UBLForgetCodeVC.h"

NS_ASSUME_NONNULL_BEGIN
//注册和登录共用一个控制器DoorVC；忘记密码单独一个控制器
@interface UBLDoorVC : UIViewController

@property(nonatomic,strong,nullable)UBLLoginContentView *loginContentView;//登录页面
@property(nonatomic,strong)NSString *captchaKey;

-(void)overUI;

@end

NS_ASSUME_NONNULL_END
