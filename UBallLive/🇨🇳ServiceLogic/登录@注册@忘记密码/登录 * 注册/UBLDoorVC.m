//
//  DoorVC.m
//  Shooting
//
//  Created by Jobs on 2020/9/3.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import "UBLDoorVC.h"

ZFPlayerController *ZFPlayer_DoorVC;

@interface UBLDoorVC ()

@property(nonatomic,strong)UIButton *backBtn;
@property(nonatomic,strong)ZFPlayerController *player;
@property(nonatomic,strong)ZFAVPlayerManager *playerManager;
@property(nonatomic,strong,nullable)CustomZFPlayerControlView *customPlayerControlView;
@property(nonatomic,strong,nullable)UBLRegisterContentView *registerContentView;//注册页面
@property(nonatomic,strong,nullable)UBLLogoContentView *logoContentView;

@end

@implementation UBLDoorVC

- (void)dealloc {
//    NSLog(@"Running self.class = %@;NSStringFromSelector(_cmd) = '%@';__FUNCTION__ = %s", self.class, NSStringFromSelector(_cmd),__FUNCTION__);
    PrintRetainCount(self);
    [self overUI];
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.player.currentPlayerManager play];
    [UIView animationAlert:self.backBtn];
    self.loginContentView.alpha = 1;
    [UIView animationAlert:self.logoContentView];
    IQKeyboardManager.sharedManager.enable = NO;
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self.loginContentView showLoginContentViewWithOffsetY:0];

}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.player.currentPlayerManager pause];
//    [self overUI];
}

-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches
          withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}

-(void)overUI{
    [_logoContentView removeFromSuperview];
    [_loginContentView removeFromSuperview];
    [_registerContentView removeFromSuperview];
    [_backBtn removeFromSuperview];
    
    _logoContentView = nil;
    _loginContentView = nil;
    _registerContentView = nil;
    _backBtn = nil;
    
    [_customPlayerControlView removeFromSuperview];
    _customPlayerControlView = nil;
    [_player.currentPlayerManager stop];
    _playerManager = nil;
    _player = nil;
}
#pragma mark —— LazyLoad
-(UBLLoginContentView *)loginContentView{
    if (!_loginContentView) {
        _loginContentView = UBLLoginContentView.new;
        _loginContentView.backgroundColor = [UIColor clearColor];
        @weakify(self)
        [_loginContentView actionLoginContentViewBlock:^(id data) {
            @strongify(self)
            if ([data isKindOfClass:UIButton.class]) {
                UIButton *btn = (UIButton *)data;
                if ([btn.titleLabel.text isEqualToString:@"新\n用\n户\n注\n册"]) {
                    [self.registerContentView showRegisterContentViewWithOffsetY:0];
                    [self.loginContentView removeLoginContentViewWithOffsetY:0];
                }else if ([btn.titleLabel.text isEqualToString:@"记住密码"]){
                }else if ([btn.titleLabel.text  isEqualToString:@"忘记密码"]){
                    [UIViewController comingFromVC:self
                                              toVC:UBLForgetCodeVC.new
                                       comingStyle:ComingStyle_PUSH
                                 presentationStyle:UIModalPresentationAutomatic
                                     requestParams:@""
                                           success:^(id data) {}
                                          animated:YES];
                    
                }else if ([btn.titleLabel.text isEqualToString:@"登录"]){
//                    [self.view endEditing:YES];
                    self.loginContentView.userInteractionEnabled = NO;
                    UBLDoorInputViewStyle_3 *用户名 = (UBLDoorInputViewStyle_3 *)self.loginContentView.inputViewMutArr[0];
                    UBLDoorInputViewStyle_3 *密码 = (UBLDoorInputViewStyle_3 *)self.loginContentView.inputViewMutArr[1];
                    
//                    [self login_networkingWithUserName:用户名.tf.text
//                                              passWord:密码.tf.text//lowerMD5_32Salt(密码.tf.text)//md5_32bits(密码.tf.text, YES)
//                                            originType:originType_Apple];
                }else if ([btn.titleLabel.text isEqualToString:@"先去逛逛"]){
                    [self overUI];
                    [self backBtnClickEvent:nil];
//                    [[NSNotificationCenter defaultCenter]postNotificationName:KLoginExitNotifaction object:nil];
                }else{
                    
                }
            }
        }];
        
        [_loginContentView actionLoginContentViewKeyboardBlock:^(id data) {
            @strongify(self)
            if ([data isKindOfClass:NSNumber.class]) {
                NSNumber *b = (NSNumber *)data;
//                NSLog(@"%@",b);
                if (b.floatValue > 0) {
//                    NSLog(@"开始编辑");
                    self.logoContentView.alpha = 0;
                }else if(b.floatValue < -100){
//                    NSLog(@"正常模式");
                    self.logoContentView.alpha = 1;
                }else{}
            }
        }];
        [self.view addSubview:_loginContentView];
        _loginContentView.frame = CGRectMake(MAINSCREEN_WIDTH,
                                             225,
                                             MAINSCREEN_WIDTH - 48,
                                             315);
    }return _loginContentView;
}

-(UBLRegisterContentView *)registerContentView{
    if (!_registerContentView) {
        _registerContentView = UBLRegisterContentView.new;
        @weakify(self)
        [_registerContentView actionRegisterContentViewBlock:^(id data) {
            @strongify(self)
            if ([data isKindOfClass:UIButton.class]) {
                UIButton *btn = (UIButton *)data;
                if ([btn.titleLabel.text isEqualToString:@"返\n回\n登\n录"]) {
                    [self.loginContentView showLoginContentViewWithOffsetY:0];
                    [self.registerContentView removeRegisterContentViewWithOffsetY:0];
                }else if ([btn.titleLabel.text isEqualToString:@"注册"]) {
                    //注册成功即登录
                    UBLDoorInputViewStyle_3 *用户名 = (UBLDoorInputViewStyle_3 *)self.registerContentView.inputViewMutArr[0];
                    UBLDoorInputViewStyle_3 *密码 = (UBLDoorInputViewStyle_3 *)self.registerContentView.inputViewMutArr[1];
                    UBLDoorInputViewStyle_3 *确认密码 = (UBLDoorInputViewStyle_3 *)self.registerContentView.inputViewMutArr[2];
                    UBLDoorInputViewStyle_2 *填写验证码 = (UBLDoorInputViewStyle_2 *)self.registerContentView.inputViewMutArr[3];
//                    [self register_networkingWithAccount:用户名.tf.text
//                                                password:密码.tf.text
//                                         confirmPassword:确认密码.tf.text
//                                              captchaKey:self.captchaKey
//                                                 imgCode:填写验证码.tf.text
//                                              originType:originType_Apple];//来源:0、苹果；1、安卓；2、H5
                    
                    if (![NSString isNullString:用户名.tf.text] && ![NSString isNullString:密码.tf.text]) {
                        //存密码
                        SetUserDefaultKeyWithValue(@"Acc", 用户名.tf.text);
                        SetUserDefaultKeyWithValue(@"Password", 密码.tf.text);
                        UserDefaultSynchronize;
                    }
                }else{}
            }
        }];
        
        [_registerContentView actionRegisterContentViewKeyboardBlock:^(id data) {
            @strongify(self)
            if ([data isKindOfClass:NSNumber.class]) {
                NSNumber *b = (NSNumber *)data;
//                NSLog(@"%@",b);
                if (b.floatValue > 0) {
//                    NSLog(@"开始编辑");
                    self.logoContentView.alpha = 0;
                }else if(b.floatValue < -100){
//                    NSLog(@"正常模式");
                    self.logoContentView.alpha = 1;
                }else{}
            }
        }];
        
        [_registerContentView actionRegisterContentViewAuthcodeBlock:^(id data) {
            @strongify(self)
            if ([data isKindOfClass:NSDictionary.class]) {
                NSDictionary *dic = (NSDictionary *)data;
                self.captchaKey = dic[@"captchaKey"];
            }
        }];
        
        [self.view addSubview:_registerContentView];
        _registerContentView.frame = CGRectMake(MAINSCREEN_WIDTH,
                                                225,
                                                MAINSCREEN_WIDTH - 48,
                                                315);
    }return _registerContentView;
}

-(void)reInputCode{
    UBLDoorInputViewStyle_3 *密码 = (UBLDoorInputViewStyle_3 *)self.registerContentView.inputViewMutArr[1];
    UBLDoorInputViewStyle_3 *确认密码 = (UBLDoorInputViewStyle_3 *)self.registerContentView.inputViewMutArr[2];
    密码.tf.text = @"";
    确认密码.tf.text = @"";
}

-(ZFAVPlayerManager *)playerManager{
    if (!_playerManager) {
        _playerManager = ZFAVPlayerManager.new;
        _playerManager.shouldAutoPlay = YES;

        if (isiPhoneX_series()) {
            _playerManager.assetURL = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"iph_X"
                                                                                             ofType:@"mp4"]];
        }else{
            _playerManager.assetURL = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"非iph_X"
                                                                                             ofType:@"mp4"]];
        }
    }return _playerManager;
}

-(ZFPlayerController *)player{
    if (!_player) {
        @weakify(self)
        _player = [[ZFPlayerController alloc] initWithPlayerManager:self.playerManager
                                                      containerView:self.view];
        _player.controlView = self.customPlayerControlView;
        ZFPlayer_DoorVC = _player;
        [_player setPlayerDidToEnd:^(id<ZFPlayerMediaPlayback>  _Nonnull asset) {
            @strongify(self)
            [self.playerManager replay];//设置循环播放
        }];
    }return _player;
}

-(CustomZFPlayerControlView *)customPlayerControlView{
    if (!_customPlayerControlView) {
        _customPlayerControlView = CustomZFPlayerControlView.new;
        @weakify(self)
        [_customPlayerControlView actionCustomZFPlayerControlViewBlock:^(id data, id data2) {
            @strongify(self)
            [self.view endEditing:YES];
        }];
    }return _customPlayerControlView;
}

-(UBLLogoContentView *)logoContentView{
    if (!_logoContentView) {
        _logoContentView = UBLLogoContentView.new;
        [self.view addSubview:_logoContentView];
        [_logoContentView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(150, 50));
            make.bottom.equalTo(self.loginContentView.mas_top).offset(-50);
            make.centerX.equalTo(self.view);
        }];
    }return _logoContentView;
}

-(UIButton *)backBtn{
    if (!_backBtn) {
        _backBtn = UIButton.new;
        [_backBtn setImage:KBuddleIMG(@"⚽️PicResource", @"登录@注册@忘记密码", nil, @"登录注册关闭")
                  forState:UIControlStateNormal];
        @weakify(self)
        [[_backBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
            @strongify(self)
            [self.player.currentPlayerManager pause];
            [self overUI];
            [self backBtnClickEvent:x];
        }];
        [self.view addSubview:_backBtn];
        [_backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(50, 50));
            make.top.mas_equalTo(@50);
            make.right.equalTo(self.view).offset(-25);
        }];
    }return _backBtn;
}

@end
