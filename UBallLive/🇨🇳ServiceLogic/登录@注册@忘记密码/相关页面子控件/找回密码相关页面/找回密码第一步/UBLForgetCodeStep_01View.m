//
//  ForgetCodeStep_01.m
//  Shooting
//
//  Created by Jobs on 2020/9/6.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import "UBLForgetCodeStep_01View.h"

@interface UBLForgetCodeStep_01View ()

@property(nonatomic,copy)MKDataBlock forgetCodeStep_01ViewBlock;
@property(nonatomic,copy)MKDataBlock forgetCodeStep_01ViewKeyboardBlock;
@property(nonatomic,copy)MKDataBlock forgetCodeStep_01ViewEnabledBlock;

@property(nonatomic,strong)NSMutableArray <UIImage *>*headerImgMutArr;
@property(nonatomic,strong)NSMutableArray <UIImage *>*btnSelectedImgMutArr;
@property(nonatomic,strong)NSMutableArray <UIImage *>*btnUnselectedImgMutArr;
@property(nonatomic,strong)NSMutableArray <NSString *>*placeHolderMutArr;
@property(nonatomic,strong)NSMutableArray <NSString *>*titleStrMutArr;

@property(nonatomic,assign)BOOL isOpen;
@property(nonatomic,assign)BOOL isEdit;//本页面是否当下正处于编辑状态
@property(nonatomic,assign)CGRect registerContentViewRect;

@end

@implementation UBLForgetCodeStep_01View

- (void)dealloc {
//    NSLog(@"Running self.class = %@;NSStringFromSelector(_cmd) = '%@';__FUNCTION__ = %s", self.class, NSStringFromSelector(_cmd),__FUNCTION__);
}

-(instancetype)init{
    if (self = [super init]) {
         self.backgroundColor = kBlackColor;
        [self keyboard];
        [UIView cornerCutToCircleWithView:self
                          AndCornerRadius:8];
    }return self;
}

-(void)drawRect:(CGRect)rect{
    [super drawRect:rect];
    [self makeInputView];
    self.registerContentViewRect = self.frame;
}

-(void)makeInputView{
    for (int t = 0; t < self.headerImgMutArr.count; t++) {
        UBLDoorInputViewStyle_3 *inputView = UBLDoorInputViewStyle_3.new;
        inputView.limitLength = 11;
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
        inputView.tf.placeholder = self.placeHolderMutArr[t];
        inputView.tf.backgroundColor = kBlackColor;
        
        inputView.btnSelectedIMG = self.btnSelectedImgMutArr[t];
        inputView.btnUnSelectedIMG = self.btnUnselectedImgMutArr[t];
        [self.inputViewMutArr addObject:inputView];
        
        inputView.tf.keyboardType = UIKeyboardTypeAlphabet;
        if (t == 1) {
            inputView.tf.keyboardType = UIKeyboardTypePhonePad;
        }
        [inputView.tf addTarget:self
                         action:@selector(textFieldDidChange:)
               forControlEvents:UIControlEventEditingChanged];
        
        [self addSubview:inputView];
        [inputView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(0);
            make.size.mas_equalTo(CGSizeMake(MAINSCREEN_WIDTH - 64, 54));
            if (t == 0) {
                make.top.equalTo(self).offset(0);
            }else{
                UBLDoorInputViewStyle_3 *InputView = (UBLDoorInputViewStyle_3 *)self.inputViewMutArr[t - 1];
                make.top.equalTo(InputView.mas_bottom).offset(33);
            }
        }];
        
        UIView *line = [[UIView alloc]init];
        line.backgroundColor = COLOR_RGB(216, 216, 216, 1);
        line.frame = CGRectMake(0, 32 * t + 54 * (t + 1), self.width, 1);
        [self addSubview:line];
        
        [self layoutIfNeeded];
    }
}

- (void)textFieldDidChange:(UITextField *)textField {
    UBLDoorInputViewStyle_3 *用户名 = self.inputViewMutArr[0];
    UBLDoorInputViewStyle_3 *手机号码 = self.inputViewMutArr[1];
    bool enable = (用户名.tf.text.length >= 4 && 手机号码.tf.text.length > 0) ? YES : NO;
    if(self.forgetCodeStep_01ViewEnabledBlock){
        self.forgetCodeStep_01ViewEnabledBlock(@(enable));
    }
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

-(void)keyboardWillChangeFrameNotification:(NSNotification *)notification{//键盘 弹出 和 收回 走这个方法
    NSDictionary *userInfo = notification.userInfo;
    CGRect beginFrame = [userInfo[UIKeyboardFrameBeginUserInfoKey] CGRectValue];
    CGRect endFrame = [userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGFloat KeyboardOffsetY = beginFrame.origin.y - endFrame.origin.y;
    
    CGFloat offset = 40;
    
    UBLDoorInputViewStyle_3 *用户名 = self.inputViewMutArr[0];
    UBLDoorInputViewStyle_3 *手机号码 = self.inputViewMutArr[1];
    
    self.isEdit = 用户名.tf.editing | 手机号码.tf.editing;
    
//    NSLog(@"SSS = %d",self.isEdit);
    
    if (self.isOpen){
        if (self.isEdit) {
            if (self.registerContentViewRect.origin.y == self.mj_y) {
                [self showForgetCodeStep_01ViewWithOffsetY:offset];
            }
        }else{
            if (self.registerContentViewRect.origin.y != self.mj_y) {
                [self showForgetCodeStep_01ViewWithOffsetY:-offset];
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
/*
 *    使用弹簧的描述时间曲线来执行动画 ,当dampingRatio == 1 时,动画会平稳的减速到最终的模型值,而不会震荡.
 *    小于1的阻尼比在达到完全停止之前会震荡的越来越多.
 *    如果你可以使用初始的 spring velocity 来 指定模拟弹簧末端的对象在加载之前移动的速度.
 *    他是一个单位坐标系统,其中2被定义为在一秒内移动整个动画距离.
 *    如果你在动画中改变一个物体的位置,你想在动画开始前移动到 100 pt/s 你会超过0.5,
 *    dampingRatio 阻尼
 *    velocity 速度
 */
-(void)showForgetCodeStep_01ViewWithOffsetY:(CGFloat)offsetY{
    [UIView animateWithDuration:2
                          delay:0.1
         usingSpringWithDamping:0.3
          initialSpringVelocity:10
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
//        self.centerX = [SCREEN_WIDTH / 2];
        self.x = 64;
        self.centerY -= offsetY;
    } completion:^(BOOL finished) {
        self.isOpen = YES;
    }];
}

-(void)removeForgetCodeStep_01ViewWithOffsetY:(CGFloat)offsetY{
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

-(void)actionForgetCodeStep_01ViewBlock:(MKDataBlock)forgetCodeStep_01ViewBlock{
    _forgetCodeStep_01ViewBlock = forgetCodeStep_01ViewBlock;
}

-(void)actionForgetCodeStep_01ViewKeyboardBlock:(MKDataBlock)forgetCodeStep_01ViewKeyboardBlock{
    _forgetCodeStep_01ViewKeyboardBlock = forgetCodeStep_01ViewKeyboardBlock;
}

-(void)actionForgetCodeStep_01ViewEnbleBlock:(MKDataBlock)forgetCodeStep_01ViewEnabledBlock{
    self.forgetCodeStep_01ViewEnabledBlock = forgetCodeStep_01ViewEnabledBlock;
}

#pragma mark —— lazyLoad
-(NSMutableArray<UIImage *> *)headerImgMutArr{
    if (!_headerImgMutArr) {
        _headerImgMutArr = NSMutableArray.array;
        [_headerImgMutArr addObject:KBuddleIMG(@"⚽️PicResource", @"登录@注册@忘记密码", nil, @"用户名称")];
        [_headerImgMutArr addObject:KBuddleIMG(@"⚽️PicResource", @"登录@注册@忘记密码", nil, @"手机ICON")];
    }return _headerImgMutArr;
}

-(NSMutableArray<NSString *> *)placeHolderMutArr{
    if (!_placeHolderMutArr) {
        _placeHolderMutArr = NSMutableArray.array;
        [_placeHolderMutArr addObject:@"4-11位字母或数字的用户名"];
        [_placeHolderMutArr addObject:@"请输入11位手机号码"];
    }return _placeHolderMutArr;
}

-(NSMutableArray<UIImage *> *)btnSelectedImgMutArr{
    if (!_btnSelectedImgMutArr) {
        _btnSelectedImgMutArr = NSMutableArray.array;
        [_btnSelectedImgMutArr addObject:KBuddleIMG(@"⚽️PicResource", @"登录@注册@忘记密码", nil, @"空白图")];
        [_btnSelectedImgMutArr addObject:KBuddleIMG(@"⚽️PicResource", @"登录@注册@忘记密码", nil, @"codeDecode")];
    }return _btnSelectedImgMutArr;
}

-(NSMutableArray<UIImage *> *)btnUnselectedImgMutArr{
    if (!_btnUnselectedImgMutArr) {
        _btnUnselectedImgMutArr = NSMutableArray.array;
        [_btnUnselectedImgMutArr addObject:KBuddleIMG(@"⚽️PicResource", @"登录@注册@忘记密码", nil, @"closeCircle")];
        [_btnUnselectedImgMutArr addObject:KBuddleIMG(@"⚽️PicResource", @"登录@注册@忘记密码", nil, @"codeEncode")];
    }return _btnUnselectedImgMutArr;
}

-(NSMutableArray<UBLDoorInputViewStyle_3 *> *)inputViewMutArr{
    if (!_inputViewMutArr) {
        _inputViewMutArr = NSMutableArray.array;
    }return _inputViewMutArr;
}

-(NSMutableArray<NSString *> *)titleStrMutArr{
    if (!_titleStrMutArr) {
        _titleStrMutArr = NSMutableArray.array;
        [_titleStrMutArr addObject:@"用户名"];
        [_titleStrMutArr addObject:@"手机号码"];
    }return _titleStrMutArr;
}

@end
