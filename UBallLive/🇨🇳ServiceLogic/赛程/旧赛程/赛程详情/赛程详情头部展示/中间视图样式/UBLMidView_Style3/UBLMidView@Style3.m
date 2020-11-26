//
//  UBLMidView@Style3.m
//  UBallLive
//
//  Created by Jobs on 2020/11/3.
//

#import "UBLMidView@Style3.h"

@interface UBLMidView_Style3 ()

@property(nonatomic,strong)UILabel *titleLab;
@property(nonatomic,strong)UILabel *subTitleLab;
@property(nonatomic,strong)UILabel *lab;
@property(nonatomic,assign)BOOL isOK;

@end

@implementation UBLMidView_Style3

-(instancetype)init{
    if (self = [super init]) {
        
    }return self;
}

-(void)drawRect:(CGRect)rect{
    [super drawRect:rect];
    if (!self.isOK) {
        
        self.subTitleLabStr = @"1:0";
        self.labStr = @"(0:1)";
        
        self.titleLab.alpha = 1;
        self.subTitleLab.alpha = 1;
        self.lab.alpha = 0.2446;
        
        self.isOK = YES;
    }
}
#pragma mark —— lazyLoad
-(UILabel *)titleLab{
    if (!_titleLab) {
        _titleLab = UILabel.new;
        _titleLab.text = @"完";
        _titleLab.textColor = kWhiteColor;
        _titleLab.font = [UIFont systemFontOfSize:12 weight:UIFontWeightMedium];
        [_titleLab sizeToFit];
        [self addSubview:_titleLab];
        [_titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self);
            make.top.equalTo(self);
        }];
    }return _titleLab;
}

-(UILabel *)subTitleLab{
    if (!_subTitleLab) {
        _subTitleLab = UILabel.new;
        _subTitleLab.text = self.subTitleLabStr;
        _subTitleLab.textColor = kWhiteColor;
        _subTitleLab.textAlignment = NSTextAlignmentCenter;
//        _subTitleLab.font = [UIFont systemFontOfSize:32 weight:UIFontWeightBold];//MicrosoftYaHei
        _subTitleLab.font = [UIFont fontWithName:@"MicrosoftYaHei" size:32];
        [_subTitleLab sizeToFit];
        [self addSubview:_subTitleLab];
        [_subTitleLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self);
            make.height.mas_equalTo(42);
            make.top.equalTo(self.titleLab.mas_bottom);
        }];
    }return _subTitleLab;
}

-(UILabel *)lab{
    if (!_lab) {
        _lab = UILabel.new;
        _lab.text = self.labStr;
        _lab.textAlignment = NSTextAlignmentCenter;
        _lab.backgroundColor = HEXCOLOR(0xFFF9F9);
        _lab.font = [UIFont fontWithName:@"MicrosoftYaHei" size:12];
        [self addSubview:_lab];
        [_lab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self);
            make.size.mas_equalTo(CGSizeMake(63, 18));
            make.top.equalTo(self.subTitleLab.mas_bottom);
        }];
        [UIView cornerCutToCircleWithView:_lab AndCornerRadius:18 / 2];
    }return _lab;
}

@end
