//
//  ForgetCodeVC.m
//  Shooting
//
//  Created by Jobs on 2020/9/3.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import "UBLForgetCodeVC.h"

ZFPlayerController *ZFPlayer_ForgetCodeVC;

@interface UBLForgetCodeVC ()

@property(nonatomic,strong)ZFPlayerController *player;
@property(nonatomic,strong)ZFAVPlayerManager *playerManager;
@property(nonatomic,strong)UILabel *tipsLab;
@property(nonatomic,strong)CustomZFPlayerControlView *customPlayerControlView;

@property(nonatomic,strong)NSMutableArray <NSString *>*titleMutArr;
@property(nonatomic,strong)NSMutableArray <NSString *>*subTitleMutArr;
@property(nonatomic,strong)NSMutableArray <UIImage *>*backImageMutArr;

@end

@implementation UBLForgetCodeVC

- (void)dealloc {
//    NSLog(@"Running self.class = %@;NSStringFromSelector(_cmd) = '%@';__FUNCTION__ = %s", self.class, NSStringFromSelector(_cmd),__FUNCTION__);
    [self removeAll];
    
    [_customPlayerControlView removeFromSuperview];
    _customPlayerControlView = nil;
    [_player.currentPlayerManager stop];
    _playerManager = nil;
    _player = nil;
    PrintRetainCount(self);
}

- (void)removeAll{
    [_step_01 removeFromSuperview];
    [_step_02 removeFromSuperview];
    [_findCodeFlowChartView removeFromSuperview];
    [_successBtn removeFromSuperview];
    [_tipsLab removeFromSuperview];
    [_nextStepBtn removeFromSuperview];
    _step_01 = nil;
    _step_02 = nil;
    _findCodeFlowChartView = nil;
    _successBtn = nil;
    _tipsLab = nil;
    _nextStepBtn = nil;
}

-(void)viewDidLoad{
    [super viewDidLoad];
    self.view.backgroundColor = kBlackColor;
    
    //    self.gk_navLeftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.backBtn];
    self.gk_backStyle = GKNavigationBarBackStyleWhite;
    self.gk_navLineHidden = YES;
    self.gk_navTitle = @"密码找回";
    self.gk_navTitleColor = kWhiteColor;
    self.gk_navTitleFont = [UIFont systemFontOfSize:17
                                             weight:UIFontWeightBold];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    //    [self.player.currentPlayerManager play];
    self.step_01.alpha = 0.7;
    IQKeyboardManager.sharedManager.enable = NO;
    [self.view bringSubviewToFront:self.gk_navigationBar];
    self.currentFlowSerialNum = 0;
    self.flowNum = 3;
    self.findCodeFlowChartView.alpha = 1;
    self.findCodeFlowChartView.currentFlowSerialNum = self.currentFlowSerialNum;//步骤从0开始
    
    self.tipsLab.alpha = 1;
    self.nextStepBtn.alpha = 0.7;
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self.step_01 showForgetCodeStep_01ViewWithOffsetY:0];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    //    [self.player.currentPlayerManager pause];
    [self removeAll];
}

-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}

#pragma mark —— LazyLoad
-(UBLFindCodeFlowChartView *)findCodeFlowChartView{
    if (!_findCodeFlowChartView) {
        _findCodeFlowChartView = UBLFindCodeFlowChartView.new;
        _findCodeFlowChartView.flowNum = self.flowNum;
        _findCodeFlowChartView.titleMutArr = self.titleMutArr;
        _findCodeFlowChartView.subTitleMutArr = self.subTitleMutArr;
        _findCodeFlowChartView.backImageMutArr = self.backImageMutArr;
        [self.view addSubview:_findCodeFlowChartView];
        [_findCodeFlowChartView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self.view);
            make.top.equalTo(self.gk_navigationBar.mas_bottom).offset(8);
            make.height.mas_equalTo(65);
        }];
    }return _findCodeFlowChartView;
}

-(UILabel *)tipsLab{
    if (!_tipsLab) {
        _tipsLab = UILabel.new;
        _tipsLab.hidden = YES;
        _tipsLab.font = [UIFont systemFontOfSize:10
                                          weight:UIFontWeightRegular];
        _tipsLab.textColor = kWhiteColor;
        _tipsLab.text = @"如用户名没有绑定手机号\n请去环球体育APP联系客服找回密码";
        _tipsLab.numberOfLines = 0;
        _tipsLab.textAlignment = NSTextAlignmentCenter;
        [_tipsLab sizeToFit];
        [self.view addSubview:_tipsLab];
        [_tipsLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.view);
            make.bottom.equalTo(self.view).offset(-21);
            make.width.mas_equalTo(MAINSCREEN_WIDTH / 2);
        }];
    }return _tipsLab;
}

-(void)startStep_01{
    UBLDoorInputViewStyle_3 *用户名 = self.step_01.inputViewMutArr[0];
    UBLDoorInputViewStyle_3 *手机号码 = self.step_01.inputViewMutArr[1];
    
    if (![NSString isNullString:手机号码.tf.text] &&
        ![NSString isNullString:用户名.tf.text]) {
        
        if (用户名.tf.text.length < 4 &&
            用户名.tf.text.length > 11) {
            [WHToast showErrorWithMessage:@"请输入4-11位字母或数字的用户名"
                                             duration:2
                                        finishHandler:^{
                          
            }];
        }else{
            if (手机号码.tf.text.length < 4 &&
                手机号码.tf.text.length > 11) {
                [WHToast showErrorWithMessage:@"请输入4-11位字母或数字的手机号码"
                                                 duration:2
                                            finishHandler:^{
                              
                }];
            }else{
                self.telStr = 手机号码.tf.text;
//                [self MKLoginCheckIdentity_netWorkingWithTel:手机号码.tf.text
//                                                     account:用户名.tf.text];
            }
        }
    }else{
        [WHToast showErrorWithMessage:@"请完善资料"
                                         duration:2
                                    finishHandler:^{
                      
        }];
    }
}

-(void)startStep_02{
    UBLDoorInputViewStyle_3 *用户名 = self.step_01.inputViewMutArr[0];
    UBLDoorInputViewStyle_3 *手机号码 = self.step_01.inputViewMutArr[1];
    
    UBLDoorInputViewStyle_1 *验证码 = (UBLDoorInputViewStyle_1 *)self.step_02.inputViewMutArr[0];
    UBLDoorInputViewStyle_3 *新密码 = (UBLDoorInputViewStyle_3 *)self.step_02.inputViewMutArr[1];
    UBLDoorInputViewStyle_3 *新密码确认 = (UBLDoorInputViewStyle_3 *)self.step_02.inputViewMutArr[2];
    
    if (![NSString isNullString:验证码.tf.text] &&
        ![NSString isNullString:新密码.tf.text] &&
        ![NSString isNullString:新密码确认.tf.text]) {
        if (新密码确认.tf.text.length < 6 &&
            新密码确认.tf.text.length > 12) {
            [WHToast showErrorWithMessage:@"两次密码输入不一致,请重新输入"
                                 duration:2
                            finishHandler:^{
                          
            }];
        }else{
//            [self MKLoginChangePassword_netWorkingWithAccount:用户名.tf.text
//                                                     telPhone:手机号码.tf.text
//                                                      smsCode:验证码.tf.text
//                                                     password:新密码.tf.text
//                                              confirmPassword:新密码确认.tf.text
//                                                   originType:originType_Apple];
        }
    }else{
//        [MBProgressHUD wj_showError:@"请完善资料"];
         [MBProgressHUD showError:@"请完善资料"];
    }
}

-(UIButton *)nextStepBtn{
    if (!_nextStepBtn) {
        _nextStepBtn = UIButton.new;
        _nextStepBtn.enabled = NO;
        [self.view addSubview:_nextStepBtn];
        [_nextStepBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.view);
            make.left.mas_equalTo(92);
            make.right.mas_equalTo(-92);
            make.height.mas_equalTo(44);
            make.top.equalTo(self.step_01.mas_bottom).offset(100);
        }];
        [self.view layoutIfNeeded];
        [UIView setView:_nextStepBtn
                  layer:_nextStepBtn.titleLabel.layer
          gradientLayer:RGBCOLOR(247,
                                 131,
                                 97)
               endColor:RGBCOLOR(245,
                                 75,
                                 100)];
        [_nextStepBtn setTitle:@"下一步"
                      forState:UIControlStateNormal];
        [_nextStepBtn setTitleColor:kWhiteColor
                           forState:UIControlStateNormal];
        @weakify(self)
        [[_nextStepBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
            @strongify(self)
            [self.view endEditing:YES];
            
            switch (self.Step) {
                case 0:{
                    [self startStep_01];
                }break;
                case 1:{
                    [self startStep_02];
                }break;
                    
                default:
                    break;
            }
        }];
        [UIView cornerCutToCircleWithView:_nextStepBtn
                          AndCornerRadius:22];
    }return _nextStepBtn;
}

-(UBLForgetCodeStep_01View *)step_01{
    if (!_step_01) {
        _step_01 = UBLForgetCodeStep_01View.new;
        
        @weakify(self)
        [_step_01 actionForgetCodeStep_01ViewKeyboardBlock:^(id data) {
        }];
        
        [_step_01 actionForgetCodeStep_01ViewEnbleBlock:^(id data) {
            bool enable = [data boolValue];
            weak_self.nextStepBtn.enabled = enable;
            weak_self.nextStepBtn.alpha = self.nextStepBtn.enabled ? 1 : 0.7;
        }];
        
        [self.view addSubview:_step_01];
        _step_01.frame = CGRectMake(MAINSCREEN_WIDTH,
                                    200,
                                    MAINSCREEN_WIDTH - 64,
                                    144);
    }return _step_01;
}

-(UBLForgetCodeStep_02View *)step_02{
    if (!_step_02) {
        _step_02 = UBLForgetCodeStep_02View.new;
        _step_02.alpha = 0.7;
        @weakify(self)
        [_step_02 actionForgetCodeStep_02ViewKeyboardBlock:^(id data) {
        }];
        
        [_step_02 acrtionBlockForgetCodeStep_02inputView:^(id data) {
            if ([data isKindOfClass:UIButton.class]) {
                UIButton *__block btn = (UIButton *)data;
                @strongify(self)
                //请求验证码
                if (![NSString isNullString:self.telStr]) {
//                    [self MKLoginSendSmsCode_netWorkingWithTel:self.telStr
//                                                    clockBlock:^(id data) {
//                        [btn timeFailBeginFrom:60];
//                    }];
                }else{
//                    NSLog(@"手机号为空");
                }
            }
        }];
        
        [_step_02 actionForgetCodeStep_02ViewEnbleBlock:^(id data) {
            bool enable = [data boolValue];
            weak_self.nextStepBtn.enabled = enable;
            weak_self.nextStepBtn.alpha = self.nextStepBtn.enabled ? 1 : 0.7;
        }];
        
        [self.view addSubview:_step_02];
        _step_02.frame = CGRectMake(MAINSCREEN_WIDTH,
                                    200,
                                    MAINSCREEN_WIDTH - 64,
                                    228);
    }return _step_02;
}

-(NSMutableArray<NSString *> *)titleMutArr{
    if (!_titleMutArr) {
        _titleMutArr = NSMutableArray.array;
        [_titleMutArr addObject:@"01"];
        [_titleMutArr addObject:@"02"];
        [_titleMutArr addObject:@"03"];
    }return _titleMutArr;
}

-(NSMutableArray<NSString *> *)subTitleMutArr{
    if (!_subTitleMutArr) {
        _subTitleMutArr = NSMutableArray.array;
        [_subTitleMutArr addObject:@"身份登录"];
        [_subTitleMutArr addObject:@"修改密码"];
        [_subTitleMutArr addObject:@"完成"];
    }return _subTitleMutArr;
}

-(NSMutableArray<UIImage *> *)backImageMutArr{
    if (!_backImageMutArr) {
        _backImageMutArr = NSMutableArray.array;
        [_backImageMutArr addObject:KBuddleIMG(@"⚽️PicResource", @"登录@注册@忘记密码", @"找回密码流程图", @"di_1")];
        [_backImageMutArr addObject:KBuddleIMG(@"⚽️PicResource", @"登录@注册@忘记密码", @"找回密码流程图", @"di_2")];
        [_backImageMutArr addObject:KBuddleIMG(@"⚽️PicResource", @"登录@注册@忘记密码", @"找回密码流程图", @"di_3")];
        [_backImageMutArr addObject:KBuddleIMG(@"⚽️PicResource", @"登录@注册@忘记密码", @"找回密码流程图", @"di_4")];
    }return _backImageMutArr;
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
        _player = [[ZFPlayerController alloc] initWithPlayerManager:self.playerManager
                                                      containerView:self.view];
        _player.controlView = self.customPlayerControlView;
        ZFPlayer_ForgetCodeVC = _player;
        @weakify(self)
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

-(UIButton *)successBtn{
    if (!_successBtn) {
        _successBtn = UIButton.new;
        [_successBtn setTitle:@"密码修改成功"
                     forState:UIControlStateNormal];
        _successBtn.titleLabel.font = [UIFont systemFontOfSize:17
                                                        weight:UIFontWeightLight];
        [_successBtn setImage:KIMG(@"密码修改成功")
                     forState:UIControlStateNormal];
        @weakify(self)
        [[_successBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
            @strongify(self)
//            NSLog(@"密码修改成功");
        }];
        [self.view addSubview:_successBtn];
        [_successBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            //            make.center.equalTo(self.view);
            make.centerX.equalTo(self.view);
            make.top.mas_equalTo(228);
        }];
        [_successBtn layoutButtonWithEdgeInsetsStyle:GLButtonEdgeInsetsStyleTop
                                     imageTitleSpace:8];
    }return _successBtn;
}

@end
