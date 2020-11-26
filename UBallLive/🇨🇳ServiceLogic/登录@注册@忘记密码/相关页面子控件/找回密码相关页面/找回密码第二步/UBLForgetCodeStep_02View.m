//
//  ForgetCodeStep_02.m
//  Shooting
//
//  Created by Jobs on 2020/9/6.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import "UBLForgetCodeStep_02View.h"

@interface UBLForgetCodeStep_02View ()

@property(nonatomic,copy)MKDataBlock forgetCodeStep_02ViewKeyboardBlock;
@property(nonatomic,copy)MKDataBlock forgetCodeStep_02inputViewBlock;
@property(nonatomic,copy)MKDataBlock forgetCodeStep_02ViewEnabledBlock;

@property(nonatomic,strong)NSMutableArray <UIImage *>*headerImgMutArr;
@property(nonatomic,strong)NSMutableArray <UIImage *>*btnSelectedImgMutArr;
@property(nonatomic,strong)NSMutableArray <UIImage *>*btnUnselectedImgMutArr;
@property(nonatomic,strong)NSMutableArray <NSString *>*placeHolderMutArr;
@property(nonatomic,strong)NSMutableArray <NSString *>*titleStrMutArr;

@property(nonatomic,assign)BOOL isOpen;
@property(nonatomic,assign)BOOL isEdit;//本页面是否当下正处于编辑状态
@property(nonatomic,assign)CGRect registerContentViewRect;

@end

@implementation UBLForgetCodeStep_02View

- (void)dealloc {
//    NSLog(@"Running self.class = %@;NSStringFromSelector(_cmd) = '%@';__FUNCTION__ = %s", self.class, NSStringFromSelector(_cmd),__FUNCTION__);
}

-(instancetype)init{
    if (self = [super init]) {
        self.backgroundColor = kBlackColor;
        [self keyboard];
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(doorInputViewStyle_1Notification:)
                                                     name:@"短信验证码时间"
                                                   object:nil];
    }return self;
}

-(void)drawRect:(CGRect)rect{
    [super drawRect:rect];
    [self makeInputView];
    self.registerContentViewRect = self.frame;
}

-(void)keyboard{
#warning 此处必须禁用IQKeyboardManager，因为框架的原因，弹出键盘的时候是整个VC全部向上抬起，一个是弹出的高度不对，第二个是弹出的逻辑不正确，就只是需要评论页向上同步弹出键盘高度即可。可是一旦禁用IQKeyboardManager这里就必须手动监听键盘弹出高度，再根据这个高度对评论页做二次约束
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillChangeFrameNotification:)
                                                 name:UIKeyboardWillChangeFrameNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardDidChangeFrameNotification:)
                                                 name:UIKeyboardDidChangeFrameNotification
                                               object:nil];
}

-(void)doorInputViewStyle_1Notification:(NSNotification *)notification{
    NSString *info = notification.object;
    self.time = info.intValue;
}

-(void)keyboardWillChangeFrameNotification:(NSNotification *)notification{//键盘 弹出 和 收回 走这个方法
    NSDictionary *userInfo = notification.userInfo;
    CGRect beginFrame = [userInfo[UIKeyboardFrameBeginUserInfoKey] CGRectValue];
    CGRect endFrame = [userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
//    CGFloat KeyboardOffsetY = beginFrame.origin.y - endFrame.origin.y;
    
    CGFloat offset = 40;
    
    UBLDoorInputViewStyle_1 *验证码 = (UBLDoorInputViewStyle_1 *)self.inputViewMutArr[0];
    UBLDoorInputViewStyle_3 *新密码 = (UBLDoorInputViewStyle_3 *)self.inputViewMutArr[1];
    UBLDoorInputViewStyle_3 *确认新密码 = (UBLDoorInputViewStyle_3 *)self.inputViewMutArr[2];
    
    self.isEdit = 验证码.tf.editing | 新密码.tf.editing | 确认新密码.tf.editing;
    
//    NSLog(@"SSS = %d",self.isEdit);
    
    if (self.isOpen){
        if (self.isEdit) {
            if (self.registerContentViewRect.origin.y == self.mj_y) {
                [self showForgetCodeStep_02ViewWithOffsetY:offset];
            }
        }else{
            if (self.registerContentViewRect.origin.y != self.mj_y) {
                [self showForgetCodeStep_02ViewWithOffsetY:-offset];
            }
        }
    }
}

-(void)keyboardDidChangeFrameNotification:(NSNotification *)notification{
    if (self.isOpen) {
//        NSLog(@"键盘弹出");
//        NSLog(@"键盘关闭");
    }
}

-(void)makeInputView{
    for (int t = 0; t < self.headerImgMutArr.count; t++) {
        if (t == 0) {
            UBLDoorInputViewStyle_1 *inputView = UBLDoorInputViewStyle_1.new;
            inputView.time = self.time;
            inputView.titleStr = self.titleStrMutArr[t];
            inputView.inputViewWidth = MAINSCREEN_WIDTH - 64;
            inputView.inputViewHeight = 42;
            inputView.tf.offset= 0.01;
            inputView.tf.ZYtextFont = [UIFont systemFontOfSize:14
                                                        weight:UIFontWeightRegular];
            inputView.tf.ZYtextColor = kWhiteColor;
            inputView.tf.ZYtintColor = kWhiteColor;
            inputView.tf.ZYplaceholderLabelFont_1 = inputView.tf.ZYtextFont;
            inputView.tf.ZYplaceholderLabelFont_2 = inputView.tf.ZYtextFont;
            inputView.tf.ZYplaceholderLabelTextColor_1 = kGrayColor;
            inputView.tf.ZYplaceholderLabelTextColor_2 = kGrayColor;
            
            inputView.tf.leftViewMode = UITextFieldViewModeNever;
            inputView.tf.rightViewMode = UITextFieldViewModeNever;
            inputView.tf.placeholder = self.placeHolderMutArr[t];
            inputView.tf.keyboardType = UIKeyboardTypePhonePad;
            inputView.tf.backgroundColor = kBlackColor;
            
            [inputView.tf addTarget:self
                      action:@selector(textFieldDidChange:)
            forControlEvents:UIControlEventEditingChanged];
            
            [self.inputViewMutArr addObject:inputView];
            [self addSubview:inputView];
            [inputView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self).offset(0);
                make.left.mas_equalTo(0);
                make.size.mas_equalTo(CGSizeMake(MAINSCREEN_WIDTH - 64, 54));
            }];
            
            [self layoutIfNeeded];
            [self addSubview:[self lineView: 55]];
            
//有点意思
            [UIView appointCornerCutToCircleWithTargetView:inputView
                                         byRoundingCorners:UIRectCornerBottomLeft
                                               cornerRadii:CGSizeMake((inputView.tf.mj_h) / 4, (inputView.tf.mj_h) / 4)];
            
            [UIView appointCornerCutToCircleWithTargetView:inputView.tf
                                         byRoundingCorners:UIRectCornerTopLeft
                                               cornerRadii:CGSizeMake((inputView.tf.mj_h) / 4, (inputView.tf.mj_h) / 4)];
            
            @weakify(self)
            [inputView actionBlockDoorInputViewStyle_1CountDownBtnClick:^(id data) {
                @strongify(self)
                if (self.forgetCodeStep_02inputViewBlock) {
                    self.forgetCodeStep_02inputViewBlock(data);
                }
            }];
        }else{
            UBLDoorInputViewStyle_3 *inputView = UBLDoorInputViewStyle_3.new;
            inputView.limitLength = 12;
            inputView.isShowSecurityMode = NO;
            inputView.titleStr = self.titleStrMutArr[t];
            inputView.inputViewWidth = MAINSCREEN_WIDTH - 64;
            inputView.tf.offset = 0.01;
            inputView.tf.ZYtextFont = [UIFont systemFontOfSize:14
                                                        weight:UIFontWeightRegular];
            inputView.tf.ZYtextColor = kWhiteColor;
            inputView.tf.ZYtintColor = kWhiteColor;
            inputView.tf.ZYplaceholderLabelFont_1 = inputView.tf.ZYtextFont;
            inputView.tf.ZYplaceholderLabelFont_2 = inputView.tf.ZYtextFont;
            inputView.tf.ZYplaceholderLabelTextColor_1 = kGrayColor;
            inputView.tf.ZYplaceholderLabelTextColor_2 = kGrayColor;
            
            inputView.tf.leftViewMode = UITextFieldViewModeNever;
            inputView.tf.rightViewMode = UITextFieldViewModeNever;
            inputView.tf.keyboardType = UIKeyboardTypeAlphabet;
            inputView.tf.backgroundColor = kBlackColor;
            inputView.tf.secureTextEntry = YES;
            inputView.tf.placeholder = self.placeHolderMutArr[t];
            
            inputView.btnSelectedIMG = self.btnSelectedImgMutArr[t];
            inputView.btnUnSelectedIMG = self.btnUnselectedImgMutArr[t];
            [self.inputViewMutArr addObject:inputView];
            
            [inputView.tf addTarget:self
                             action:@selector(textFieldDidChange:)
                   forControlEvents:UIControlEventEditingChanged];
            
            [self addSubview:inputView];
            [inputView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(0);
                make.size.mas_equalTo(CGSizeMake(MAINSCREEN_WIDTH - 64, 54));
                UBLDoorInputViewStyle_3 *InputView = (UBLDoorInputViewStyle_3 *)self.inputViewMutArr[t - 1];
                make.top.equalTo(InputView.mas_bottom).offset(31);
            }];
            
            [self addSubview:[self lineView:  32 * t + 54 * (t + 1) ]];
            [self layoutIfNeeded];
        }
    }
}

- (void)textFieldDidChange:(UITextField *)textField {
    UBLDoorInputViewStyle_1 *code = (UBLDoorInputViewStyle_1 *)self.inputViewMutArr[0];
    UBLDoorInputViewStyle_3 *pwd = (UBLDoorInputViewStyle_3 *)self.inputViewMutArr[1];
    UBLDoorInputViewStyle_3 *cpwd = (UBLDoorInputViewStyle_3 *)self.inputViewMutArr[2];
    bool enable = (pwd.tf.text.length > 0 && cpwd.tf.text.length > 0 && code.tf.text.length > 0) ? YES : NO;
    if(self.forgetCodeStep_02ViewEnabledBlock){
        self.forgetCodeStep_02ViewEnabledBlock(@(enable));
    }
}

- (UIView *)lineView:(CGFloat)y{
    UIView *line = [[UIView alloc]init];
    line.backgroundColor = COLOR_RGB(216, 216, 216, 1);
    line.frame = CGRectMake(0, y, self.width, 1);
    return line;
}

/*
 *    使用弹簧的描述时间曲线来执行动画 ,当dampingRatio == 1 时,动画会平稳的减速到最终的模型值,而不会震荡.
 *    小于1的阻尼比在达到完全停止之前会震荡的越来越多.
 *    如果你可以使用初始的 spring velocity 来 指定模拟弹簧末端的对象在加载之前移动的速度.
 *    他是一个单位坐标系统,其中2被定义为在一秒内移动整个动画距离.
 *    如果你在动画中改变一个物体的位置,你想在动画开始前移动到 100 pt/s 你会超过0.5,
 *    dampingRatio 阻尼
 *    velocity 速度
 */
-(void)showForgetCodeStep_02ViewWithOffsetY:(CGFloat)offsetY{
    [UIView animateWithDuration:2
                          delay:0.1
         usingSpringWithDamping:0.3
          initialSpringVelocity:10
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
//        self.centerX = SCREEN_WIDTH / 2;
        self.x = 64;
        self.centerY -= offsetY;
    } completion:^(BOOL finished) {
        self.isOpen = YES;
    }];
}

-(void)removeForgetCodeStep_02ViewWithOffsetY:(CGFloat)offsetY{
    [UIView animateWithDuration:2
                          delay:0.1
         usingSpringWithDamping:0.3
          initialSpringVelocity:10
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
        self.mj_x = -self.mj_w;
    } completion:^(BOOL finished) {
        self.isOpen = NO;
    }];
}

-(void)actionForgetCodeStep_02ViewKeyboardBlock:(MKDataBlock)forgetCodeStep_02ViewKeyboardBlock{
    _forgetCodeStep_02ViewKeyboardBlock = forgetCodeStep_02ViewKeyboardBlock;
}

-(void)acrtionBlockForgetCodeStep_02inputView:(MKDataBlock)forgetCodeStep_02inputViewBlock{
    _forgetCodeStep_02inputViewBlock = forgetCodeStep_02inputViewBlock;
}

- (void)actionForgetCodeStep_02ViewEnbleBlock:(MKDataBlock)forgetCodeStep_02ViewEnabledBlock{
    _forgetCodeStep_02ViewEnabledBlock = forgetCodeStep_02ViewEnabledBlock;
}

#pragma mark —— lazyLoad
-(NSMutableArray<UIImage *> *)headerImgMutArr{
    if (!_headerImgMutArr) {
        _headerImgMutArr = NSMutableArray.array;
        [_headerImgMutArr addObject:KBuddleIMG(@"⚽️PicResource", @"登录@注册@忘记密码", nil, @"验证ICON")];
        [_headerImgMutArr addObject:KBuddleIMG(@"⚽️PicResource", @"登录@注册@忘记密码", nil, @"Lock")];
        [_headerImgMutArr addObject:KBuddleIMG(@"⚽️PicResource", @"登录@注册@忘记密码", nil, @"Lock")];
    }return _headerImgMutArr;
}

-(NSMutableArray<NSString *> *)placeHolderMutArr{
    if (!_placeHolderMutArr) {
        _placeHolderMutArr = NSMutableArray.array;
        [_placeHolderMutArr addObject:@"请输入验证码"];
        [_placeHolderMutArr addObject:@"请输入6-12位字母或数字的密码"];
        [_placeHolderMutArr addObject:@"请再次输入密码"];
    }return _placeHolderMutArr;
}

-(NSMutableArray<UIImage *> *)btnSelectedImgMutArr{
    if (!_btnSelectedImgMutArr) {
        _btnSelectedImgMutArr = NSMutableArray.array;
        [_btnSelectedImgMutArr addObject:KBuddleIMG(@"⚽️PicResource", @"登录@注册@忘记密码", nil, @"空白图")];
        [_btnSelectedImgMutArr addObject:KBuddleIMG(@"⚽️PicResource", @"登录@注册@忘记密码", nil, @"codeDecode")];
        [_btnSelectedImgMutArr addObject:KBuddleIMG(@"⚽️PicResource", @"登录@注册@忘记密码", nil, @"codeDecode")];
    }return _btnSelectedImgMutArr;
}

-(NSMutableArray<UIImage *> *)btnUnselectedImgMutArr{
    if (!_btnUnselectedImgMutArr) {
        _btnUnselectedImgMutArr = NSMutableArray.array;
        [_btnUnselectedImgMutArr addObject:KBuddleIMG(@"⚽️PicResource", @"登录@注册@忘记密码", nil, @"closeCircle")];
        [_btnUnselectedImgMutArr addObject:KBuddleIMG(@"⚽️PicResource", @"登录@注册@忘记密码", nil, @"codeEncode")];
        [_btnUnselectedImgMutArr addObject:KBuddleIMG(@"⚽️PicResource", @"登录@注册@忘记密码", nil, @"codeEncode")];
    }return _btnUnselectedImgMutArr;
}

-(NSMutableArray<UBLDoorInputViewBaseStyle *> *)inputViewMutArr{
    if (!_inputViewMutArr) {
        _inputViewMutArr = NSMutableArray.array;
    }return _inputViewMutArr;
}

-(NSMutableArray<NSString *> *)titleStrMutArr{
    if (!_titleStrMutArr) {
        _titleStrMutArr = NSMutableArray.array;
        [_titleStrMutArr addObject:@"验证码"];
        [_titleStrMutArr addObject:@"新密码"];
        [_titleStrMutArr addObject:@"确认新密码"];
    }return _titleStrMutArr;
}


@end
