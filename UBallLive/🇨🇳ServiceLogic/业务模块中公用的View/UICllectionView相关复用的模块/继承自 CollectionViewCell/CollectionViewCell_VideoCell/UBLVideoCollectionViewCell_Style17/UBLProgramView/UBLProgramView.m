//
//  UBLProgramView.m
//  UBallLive
//
//  Created by Jobs on 2020/11/8.
//

#import "UBLProgramView.h"

@interface UBLProgramView ()

@property(nonatomic,strong)UIImageView *imageView;
@property(nonatomic,strong)UILabel *titleLab;
@property(nonatomic,assign)BOOL isOK;

@end

@implementation UBLProgramView

-(instancetype)init{
    if (self = [super init]) {
        
    }return self;
}

-(void)drawRect:(CGRect)rect{
    [super drawRect:rect];
    if (!self.isOK) {
        
        self.dataStr = @"【西甲】09-25  10:00  帕丘卡VS托卢卡  ";
//        self.image =
        
        self.imageView.alpha = 1;
        self.titleLab.alpha = 1;
        self.backgroundColor = HEXCOLOR(0xF5F5F5);
        
        [UIView cornerCutToCircleWithView:self AndCornerRadius:self.mj_h / 2];
        
        self.isOK = YES;
    }
}
#pragma mark —— lazyLoad
-(UIImageView *)imageView{
    if (!_imageView) {
        _imageView = UIImageView.new;
        _imageView.backgroundColor = kRedColor;
//        _imageView.image = self.image;
        [self addSubview:_imageView];
        [_imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(13);
            make.size.mas_equalTo(CGSizeMake(self.mj_h, self.mj_h));
            make.centerY.equalTo(self);
        }];
    }return _imageView;
}

-(UILabel *)titleLab{
    if (!_titleLab) {
        _titleLab = UILabel.new;
        _titleLab.font = [UIFont systemFontOfSize:10 weight:UIFontWeightMedium];
        _titleLab.text = self.dataStr;
        _titleLab.textColor = HEXCOLOR(0x5471AE);
        [self addSubview:_titleLab];
        [_titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.imageView.mas_right).offset(5);
            make.top.bottom.right.equalTo(self);
        }];
    }return _titleLab;
}

@end
