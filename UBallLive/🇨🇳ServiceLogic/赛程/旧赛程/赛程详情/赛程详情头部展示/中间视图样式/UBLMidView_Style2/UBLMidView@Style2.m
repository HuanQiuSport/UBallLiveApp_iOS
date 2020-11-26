//
//  UBLMidView@Style2.m
//  UBallLive
//
//  Created by Jobs on 2020/11/3.
//

#import "UBLMidView@Style2.h"

@interface UBLMidView_Style2 ()

@property(nonatomic,strong)UILabel *titleLab;
@property(nonatomic,strong)UILabel *subTitleLab;
@property(nonatomic,assign)BOOL isOK;

@end

@implementation UBLMidView_Style2

-(instancetype)init{
    if (self = [super init]) {
        
    }return self;
}

-(void)drawRect:(CGRect)rect{
    [super drawRect:rect];
    if (!self.isOK) {
        
        self.titleLab.alpha = 1;
        self.subTitleLab.alpha = 1;
        
        self.isOK = YES;
    }
}
#pragma mark —— lazyLoad
-(UILabel *)titleLab{
    if (!_titleLab) {
        _titleLab = UILabel.new;
        _titleLab.text = @"VS";
        _titleLab.textColor = kWhiteColor;
        _titleLab.font = [UIFont systemFontOfSize:22 weight:UIFontWeightMedium];
        _titleLab.textAlignment = NSTextAlignmentCenter;
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
        _subTitleLab.text = @"未开";
        _subTitleLab.textColor = kWhiteColor;
        _subTitleLab.font = [UIFont systemFontOfSize:12 weight:UIFontWeightMedium];
        _subTitleLab.textAlignment = NSTextAlignmentCenter;
        [_subTitleLab sizeToFit];
        [self addSubview:_subTitleLab];
        [_subTitleLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self);
            make.top.equalTo(self.titleLab.mas_bottom);
        }];
    }return _subTitleLab;
}

@end
