//
//  DoorInputViewStyle_3.m
//  Shooting
//
//  Created by Jobs on 2020/9/4.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import "UBLDoorInputViewStyle_3.h"

@interface UBLDoorInputViewStyle_3 ()
<
UITextFieldDelegate
,CJTextFieldDeleteDelegate
>

@property(nonatomic,strong)UILabel *titleLab;
@property(nonatomic,strong)UIButton *securityModeBtn;
@property(nonatomic,assign)BOOL isOK;
@property(nonatomic,copy)FourDataBlock doorInputViewStyle_3Block;

@end

@implementation UBLDoorInputViewStyle_3

-(instancetype)init{
    if (self = [super init]) {
//        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(textFieldDidClear) name:ZYTextFiledClearText object:nil];
    }return self;
}

-(void)drawRect:(CGRect)rect{
    [super drawRect:rect];
    if (!self.isOK) {
        if (![NSString isNullString:self.titleStr]) {
            self.titleLab.text = self.titleStr;
        }
        self.tf.alpha = 1;
        if (self.isShowSecurityMode) {
            self.securityModeBtn.alpha = self.isShowSecurityMode;
            self.securityModeBtn.selected = self.isShowSecurityMode;
            self.tf.secureTextEntry = self.isShowSecurityMode;
        }
        self.isOK = YES;
    }
}
//删除的话：系统先走textField:shouldChangeCharactersInRange:replacementString: 再走cjTextFieldDeleteBackward:
#pragma mark —— CJTextFieldDeleteDelegate
- (void)cjTextFieldDeleteBackward:(CJTextField *)textField{
    if (self.doorInputViewStyle_3Block) {
        self.doorInputViewStyle_3Block(self,
                                       textField,
                                       @"",
                                       NSStringFromSelector(_cmd));
    }
}
#pragma mark —— UITextFieldDelegate
//询问委托人是否应该在指定的文本字段中开始编辑
- (BOOL)textFieldShouldBeginEditing:(ZYTextField *)textField{
    return YES;
}
//告诉委托人在指定的文本字段中开始编辑
- (void)textFieldDidBeginEditing:(UITextField *)textField{
    if ([textField.placeholder isEqualToString:@"6-12位字母或数字的密码"] ||
        [textField.placeholder isEqualToString:@"确认6-12位字母或数字的密码"]) {
        if (textField.text.length > 0) {
            self.securityModeBtn.hidden = NO;
        } else {
            self.securityModeBtn.hidden = YES;
        }
    }
}
//询问委托人是否应在指定的文本字段中停止编辑
- (BOOL)textFieldShouldEndEditing:(ZYTextField *)textField{
    return YES;
}
//告诉委托人对指定的文本字段停止编辑
- (void)textFieldDidEndEditing:(ZYTextField *)textField{
    [self.tf isEmptyText];
    if (self.doorInputViewStyle_3Block) {
        self.doorInputViewStyle_3Block(self,
                                       textField,
                                       @"",
                                       NSStringFromSelector(_cmd));
    }
}
//告诉委托人对指定的文本字段停止编辑
//- (void)textFieldDidEndEditing:(UITextField *)textField
//reason:(UITextFieldDidEndEditingReason)reason{}
//询问委托人是否应该更改指定的文本
- (BOOL)textField:(ZYTextField *)textField
shouldChangeCharactersInRange:(NSRange)range
replacementString:(NSString *)string{
    if (self.doorInputViewStyle_3Block) {
        self.doorInputViewStyle_3Block(self,
                                       textField,
                                       string,
                                       NSStringFromSelector(_cmd));
    }return YES;
}
//询问委托人是否应删除文本字段的当前内容
//- (BOOL)textFieldShouldClear:(UITextField *)textField
//询问委托人文本字段是否应处理按下返回按钮
- (BOOL)textFieldShouldReturn:(ZYTextField *)textField{
    [self endEditing:YES];
    return YES;
}

- (void)textFieldDidChange:(UITextField *)textField {
    NSLog(@"%@",textField.placeholder);
    if ([textField.placeholder isEqualToString:@"6-12位字母或数字的密码"] ||
        [textField.placeholder isEqualToString:@"确认6-12位字母或数字的密码"]) {
        if (textField.text.length > 0) {
            self.securityModeBtn.hidden = NO;
        } else {
            self.securityModeBtn.hidden = YES;
            
        }
    }
    if (textField.text.length > self.limitLength ){
        textField.text = [textField.text substringToIndex:self.limitLength];
    }
}

- (void)textFieldDidClear{
    if (self.doorInputViewStyle_3Block) {
        self.doorInputViewStyle_3Block(self,
                                       _tf,
                                       @"",
                                       NSStringFromSelector(_cmd));
    }
}

-(void)actionBlockDoorInputViewStyle_3:(FourDataBlock)doorInputViewStyle_3Block{
    _doorInputViewStyle_3Block = doorInputViewStyle_3Block;
}

#pragma mark —— lazyLoad
-(UILabel *)titleLab{
    if (!_titleLab) {
        _titleLab = UILabel.new;
        _titleLab.font = [UIFont systemFontOfSize:14
                                           weight:UIFontWeightRegular];
        _titleLab.textColor = kWhiteColor;
        [self addSubview:_titleLab];
        [_titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.equalTo(self);
        }];
    }return _titleLab;
}

-(ZYTextField *)tf{
    if (!_tf) {
        _tf = ZYTextField.new;
        _tf.delegate = self;
        _tf.backgroundColor = kBlackColor;
        _tf.returnKeyType = UIReturnKeyDone;
        _tf.keyboardAppearance = UIKeyboardAppearanceAlert;
        _tf.keyboardType = UIKeyboardTypeASCIICapable;
        _tf.alpha = 0.7;
        _tf.cj_delegate = self;
        [self addSubview:_tf];
        [_tf addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
        [_tf mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.bottom.equalTo(self);
            make.width.mas_equalTo(self.inputViewWidth * 0.86);
            if (![NSString isNullString:self.titleStr]) {
                make.top.equalTo(self.titleLab.mas_bottom).offset(3);
            }else{
                make.top.equalTo(self);
            }
        }];
    }return _tf;
}

-(UIButton *)securityModeBtn{
    if (!_securityModeBtn) {
        _securityModeBtn = UIButton.new;
        _securityModeBtn.hidden = YES;
        [_securityModeBtn setImage:KBuddleIMG(@"⚽️PicResource", @"登录@注册@忘记密码", nil, @"codeDecode")
                          forState:UIControlStateNormal];
        [_securityModeBtn setImage:KBuddleIMG(@"⚽️PicResource", @"登录@注册@忘记密码", nil, @"codeEncode")
                          forState:UIControlStateSelected];
        @weakify(self)
        [[_securityModeBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
            @strongify(self)
            x.selected = !x.selected;
            [self.tf setIsShowSecurityMode:x.selected];
        }];
        [self addSubview:_securityModeBtn];
        [_securityModeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.tf).offset(-12);
            make.size.mas_equalTo(CGSizeMake(20, 20));
            make.centerY.equalTo(self.tf);
        }];
    }return _securityModeBtn;
}

@end
