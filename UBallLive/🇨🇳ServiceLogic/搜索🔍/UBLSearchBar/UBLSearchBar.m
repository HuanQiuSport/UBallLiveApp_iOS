//
//  UBLSearchBar.m
//  UBallLive
//
//  Created by Jobs on 2020/10/30.
//

#import "UBLSearchBar.h"

@interface UBLSearchBar ()
<
UITextFieldDelegate
,CJTextFieldDeleteDelegate
>

@property(nonatomic,strong)ZYTextField *tf;
@property(nonatomic,strong)UIButton *cancelBtn;
@property(nonatomic,strong)UIImageView *imgView;
@property(nonatomic,assign)BOOL isOK;
@property(nonatomic,copy)MKDataBlock searchBarBlock;

@end

@implementation UBLSearchBar

-(instancetype)init{
    if (self = [super init]) {
        
    }return self;
}

-(void)drawRect:(CGRect)rect{
    [super drawRect:rect];
    if (!self.isOK) {
        self.tf.alpha = 1;
        self.cancelBtn.alpha = 1;
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
    return YES;
}
//询问委托人是否应删除文本字段的当前内容
//- (BOOL)textFieldShouldClear:(UITextField *)textField
//询问委托人文本字段是否应处理按下返回按钮
- (BOOL)textFieldShouldReturn:(ZYTextField *)textField{
    [self endEditing:YES];
    if (self.searchBarBlock) {
        self.searchBarBlock(textField);
    }return YES;
}

-(void)actionBlockSearchBarBlock:(MKDataBlock _Nullable)searchBarBlock{
    self.searchBarBlock = searchBarBlock;
}
#pragma mark —— lazyLoad
-(ZYTextField *)tf{
    if (!_tf) {
        _tf = ZYTextField.new;
        _tf.placeholder = @"搜索赛事";
        _tf.delegate = self;
        _tf.cj_delegate = self;
        _tf.leftView = self.imgView;
        _tf.ZYtextFont = [UIFont systemFontOfSize:12
                                           weight:UIFontWeightMedium];
        _tf.leftViewMode = UITextFieldViewModeAlways;
        _tf.backgroundColor = HEXCOLOR(0xF4F4F4);
        _tf.keyboardAppearance = UIKeyboardAppearanceAlert;
        _tf.returnKeyType = UIReturnKeySearch;
        [self addSubview:_tf];
        [_tf mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self);
            make.top.equalTo(self).offset(11);
            make.left.equalTo(self).offset(18);
            make.width.mas_equalTo(298);
        }];

        [self layoutIfNeeded];
        
        [UIView cornerCutToCircleWithView:_tf AndCornerRadius:_tf.mj_h / 2];
        [UIView colourToLayerOfView:_tf WithColour:kWhiteColor AndBorderWidth:1];
        
    }return _tf;
}

-(UIButton *)cancelBtn{
    if (!_cancelBtn) {
        _cancelBtn = UIButton.new;
        [_cancelBtn setTitle:@"取消"
                    forState:UIControlStateNormal];
        [_cancelBtn setTitleColor:HEXCOLOR(0x40474F)
                         forState:UIControlStateNormal];
        _cancelBtn.titleLabel.font = [UIFont systemFontOfSize:15
                                                       weight:UIFontWeightRegular];
        [[_cancelBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIButton * _Nullable x) {
           //点击事件
            if (self.searchBarBlock) {
                self.searchBarBlock(x);
            }
        }];
        [self addSubview:_cancelBtn];
        [_cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(self.tf);
            make.left.equalTo(self.tf.mas_right).offset(11);
            make.right.equalTo(self).offset(-18);
        }];
    }return _cancelBtn;
}

-(UIImageView *)imgView{
    if (!_imgView) {
        _imgView = UIImageView.new;
        _imgView.image = KIMG(@"🔍");
    }return _imgView;
}


@end
