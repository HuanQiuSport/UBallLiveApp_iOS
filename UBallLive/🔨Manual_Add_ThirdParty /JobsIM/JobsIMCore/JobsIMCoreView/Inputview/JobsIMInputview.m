//
//  JobsIMInputview.m
//  JobsIM
//
//  Created by Jobs on 2020/11/10.
//

#import "JobsIMInputview.h"
#import "JobsAdNoticeView.h"

@interface JobsIMInputview ()
<
UITextFieldDelegate
,CJTextFieldDeleteDelegate
>

@property(nonatomic,strong)UIImageView *imgView;
@property(nonatomic,strong)JobsAdNoticeView *adNoticeView;
@property(nonatomic,strong)UIButton *sendBtn;
@property(nonatomic,copy)MKDataBlock jobsIMInputviewBlock;
@property(nonatomic,assign)BOOL isOK;
//data

@end

@implementation JobsIMInputview

-(instancetype)init{
    if (self = [super init]) {
        
    }return self;
}

-(void)drawRect:(CGRect)rect{
    [super drawRect:rect];
    if (!self.isOK) {
        self.sendBtn.alpha = 1;
        self.inputTextField.alpha = 1;
        self.isOK = YES;
    }
}
//删除的话：系统先走textField:shouldChangeCharactersInRange:replacementString: 再走cjTextFieldDeleteBackward:
#pragma mark —— CJTextFieldDeleteDelegate
- (void)cjTextFieldDeleteBackward:(CJTextField *)textField{

}
#pragma mark —— UITextFieldDelegate
//询问委托人是否应该在指定的文本字段中开始编辑
- (BOOL)textFieldShouldBeginEditing:(ZYTextField *)textField{
    return YES;
}
//告诉委托人在指定的文本字段中开始编辑
//- (void)textFieldDidBeginEditing:(UITextField *)textField{}
//询问委托人是否应在指定的文本字段中停止编辑
- (BOOL)textFieldShouldEndEditing:(ZYTextField *)textField{
    return YES;
}
//告诉委托人对指定的文本字段停止编辑
- (void)textFieldDidEndEditing:(ZYTextField *)textField{
    [textField isEmptyText];
}
//告诉委托人对指定的文本字段停止编辑
//- (void)textFieldDidEndEditing:(UITextField *)textField
//reason:(UITextFieldDidEndEditingReason)reason{}
//询问委托人是否应该更改指定的文本
- (BOOL)textField:(ZYTextField *)textField
shouldChangeCharactersInRange:(NSRange)range
replacementString:(NSString *)string{
    NSLog(@"textField.text = %@",textField.text);
    NSLog(@"string = %@",string);
    
#warning 过滤删除最科学的做法
    
    NSString *resString = nil;
    //textField.text 有值 && string无值 ————> 删除操作
    if (![NSString isNullString:textField.text] && [NSString isNullString:string]) {
        
        if (textField.text.length == 1) {
            resString = @"";
        }else{
            resString = [textField.text substringToIndex:(textField.text.length - 1)];//去掉最后一个
        }
    }
    //textField.text 无值 && string有值 ————> 首字符输入
    if ([NSString isNullString:textField.text] && ![NSString isNullString:string]) {
        resString = string;
    }
    //textField.text 有值 && string有值 ————> 非首字符输入
    if (![NSString isNullString:textField.text] && ![NSString isNullString:string]) {
        resString = [textField.text stringByAppendingString:string];
    }

    NSLog(@"resString = %@",resString);
    if (![NSString isNullString:resString]) {
        self.sendBtn.userInteractionEnabled = YES;
        self.sendBtn.enabled = YES;
    }else{
        self.sendBtn.userInteractionEnabled = NO;
        self.sendBtn.enabled = NO;
    }
    return YES;
}
//询问委托人是否应删除文本字段的当前内容
//- (BOOL)textFieldShouldClear:(UITextField *)textField
//询问委托人文本字段是否应处理按下返回按钮
- (BOOL)textFieldShouldReturn:(ZYTextField *)textField{
    [self endEditing:YES];
    if (self.jobsIMInputviewBlock) {
        self.jobsIMInputviewBlock(textField);
    }return YES;
}

-(void)actionBlockJobsIMInputview:(MKDataBlock)jobsIMInputviewBlock{
    self.jobsIMInputviewBlock = jobsIMInputviewBlock;
}
#pragma mark —— lazyLoad
-(UIButton *)sendBtn{
    if (!_sendBtn) {
        _sendBtn = UIButton.new;
        _sendBtn.userInteractionEnabled = NO;
        _sendBtn.enabled = NO;
        [_sendBtn setTitle:@"发送" forState:UIControlStateNormal];
        [_sendBtn setTitleColor:kBlackColor forState:UIControlStateNormal];
        [_sendBtn setTitleColor:kWhiteColor forState:UIControlStateDisabled];
        [_sendBtn setBackgroundImage:[UIImage imageWithColor:kCyanColor] forState:UIControlStateNormal];
        [_sendBtn setBackgroundImage:[UIImage imageWithColor:KLightGrayColor] forState:UIControlStateDisabled];
        @weakify(self)
        [[_sendBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIButton * _Nullable x) {
            @strongify(self)
            [self.inputTextField endEditing:YES];
            if (![NSString isNullString:self.inputTextField.text]) {
                [PlaySound playSoundEffect:@"Sound"
                                      type:@"wav"];
                if (self.jobsIMInputviewBlock) {
                    self.jobsIMInputviewBlock(self.inputTextField);
                }
            }
            self.inputTextField.text = @"";
            x.enabled = NO;
        }];
        [self addSubview:_sendBtn];
        [_sendBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self).offset(11);
            make.bottom.equalTo(self).offset(-11);
            make.right.equalTo(self).offset(-10);
            make.width.mas_equalTo(50);
        }];
        [UIView cornerCutToCircleWithView:_sendBtn AndCornerRadius:3];
    }return _sendBtn;
}

-(ZYTextField *)inputTextField{
    if (!_inputTextField) {
        _inputTextField = ZYTextField.new;
        _inputTextField.placeholder = @"在此输入需要发送的信息";
        _inputTextField.delegate = self;
        _inputTextField.cj_delegate = self;
        _inputTextField.leftView = self.imgView;
        _inputTextField.ZYtextFont = [UIFont systemFontOfSize:12
                                           weight:UIFontWeightMedium];
        _inputTextField.leftViewMode = UITextFieldViewModeAlways;
        _inputTextField.backgroundColor = HEXCOLOR(0xF4F4F4);
        _inputTextField.keyboardAppearance = UIKeyboardAppearanceAlert;
        _inputTextField.autocorrectionType = UITextAutocorrectionTypeNo;//自动纠错属性默认是yes，就会触发那个监听
//        _inputTextField.inputAccessoryView = self.adNoticeView;
        _inputTextField.returnKeyType = UIReturnKeySearch;
        [self addSubview:_inputTextField];
        [_inputTextField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(self.sendBtn);
            make.right.equalTo(self.sendBtn.mas_left).offset(-10);
            make.left.equalTo(self).offset(10);
        }];

        [self layoutIfNeeded];
        
        [UIView cornerCutToCircleWithView:_inputTextField AndCornerRadius:_inputTextField.mj_h / 2];
        [UIView colourToLayerOfView:_inputTextField WithColour:kWhiteColor AndBorderWidth:1];
    }return _inputTextField;
}

-(UIImageView *)imgView{
    if (!_imgView) {
        _imgView = UIImageView.new;
        _imgView.image = KIMG(@"输入");
    }return _imgView;
}

-(JobsAdNoticeView *)adNoticeView{
    if (!_adNoticeView) {
        _adNoticeView = JobsAdNoticeView.new;
        _adNoticeView.size = _adNoticeView.makeSize;
    }return _adNoticeView;
}

@end
