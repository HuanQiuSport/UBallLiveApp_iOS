//
//  UBLVideoCollectionViewCell@Style17.m
//  UBallLive
//
//  Created by Jobs on 2020/11/8.
//

#import "UBLVideoCollectionViewCell@Style17.h"
#import "UBLProgramView.h"

@interface UBLVideoCollectionViewCell_Style17 ()

@property(nonatomic,strong)UIImageView *iconIMGV;
@property(nonatomic,strong)UILabel *titleLab;
@property(nonatomic,strong)UILabel *tipsLab;
@property(nonatomic,strong)UILabel *subTitleLab;
@property(nonatomic,strong)UILabel *hitRateLab;
@property(nonatomic,strong)UILabel *hitRateTitleLab;
@property(nonatomic,strong)UILabel *contentLab;
@property(nonatomic,strong)UILabel *typeLab;
@property(nonatomic,strong)UILabel *timeLab;
@property(nonatomic,strong)UILabel *styleLab;
@property(nonatomic,strong)UBLProgramView *programView;
//data
@property(nonatomic,strong)UIImage *iconIMG;
@property(nonatomic,strong)NSString *titleStr;
@property(nonatomic,strong)NSString *tipsStr;
@property(nonatomic,strong)NSString *subTitleStr;
@property(nonatomic,strong)NSString *hitRateStr;
@property(nonatomic,strong)NSString *hitRateTitleStr;
@property(nonatomic,strong)NSString *contentStr;
@property(nonatomic,strong)NSString *typeStr;
@property(nonatomic,strong)NSString *timeStr;
@property(nonatomic,strong)NSString *styleStr;

@end

@implementation UBLVideoCollectionViewCell_Style17

-(void)dealloc {
    NSLog(@"Running self.class = %@;NSStringFromSelector(_cmd) = '%@';__FUNCTION__ = %s", self.class, NSStringFromSelector(_cmd),__FUNCTION__);
}

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        [UIView makeTargetShadowview:self
                           superView:nil
                     shadowDirection:ShadowDirection_All
                   shadowWithOffsetX:5
                             offsetY:5
                        cornerRadius:8
                        shadowOffset:defaultSize
                       shadowOpacity:1
                    layerShadowColor:defaultObj
                   layerShadowRadius:defaultValue];
        
        [UIView cornerCutToCircleWithView:self.contentView AndCornerRadius:8];
        
        self.backgroundColor = kWhiteColor;
        self.contentView.backgroundColor = kWhiteColor;
        
    }return self;
}

-(void)richElementsInCellWithModel:(id _Nullable)model{
    
    self.iconIMG = KIMG(@"替代头像");
    self.titleStr = @"足球盘口鬼才";
    self.tipsStr = @"18中15";
    self.subTitleStr = @"2连中";
    self.hitRateStr = @"100%";
    self.hitRateTitleStr = @"命中";
    self.contentStr = @"狭路相逢勇者胜，本场比赛你看好谁？";
    self.typeStr = @"让球";
    self.timeStr = @"2020-09-24";
    self.styleStr = @"红单";
    self.styleStr = @"本场未中";
    self.styleStr = @"流局";
    self.styleStr = @"停售";
    
    self.iconIMGV.alpha = 1;
    self.titleLab.alpha = 1;
    self.tipsLab.alpha = 1;
    self.subTitleLab.alpha = 1;
    self.hitRateLab.alpha = 1;
    self.hitRateTitleLab.alpha = 1;
    self.contentLab.alpha = 1;
    self.programView.alpha = 1;
    self.typeLab.alpha = 1;
    self.timeLab.alpha = 1;
    self.styleLab.alpha = 1;
}

+(CGSize)cellSizeWithModel:(id _Nullable)model{
    return CGSizeMake(MAINSCREEN_WIDTH - 8 * 2, 155);
}
#pragma mark —— lazyLoad
-(UIImageView *)iconIMGV{
    if (!_iconIMGV) {
        _iconIMGV = UIImageView.new;
        _iconIMGV.image = self.iconIMG;
        [self.contentView addSubview:_iconIMGV];
        [_iconIMGV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(33, 33));
            make.left.equalTo(self.contentView).offset(9);
            make.top.equalTo(self.contentView).offset(4);
        }];
        [UIView cornerCutToCircleWithView:_iconIMGV AndCornerRadius:33 / 2];
    }return _iconIMGV;
}

-(UILabel *)titleLab{
    if (!_titleLab) {
        _titleLab = UILabel.new;
        _titleLab.textAlignment = NSTextAlignmentCenter;
        _titleLab.font = [UIFont systemFontOfSize:10 weight:UIFontWeightMedium];
        _titleLab.text = self.titleStr;
        [self.contentView addSubview:_titleLab];
        [_titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.iconIMGV);
            make.bottom.equalTo(self.iconIMGV.mas_centerY);
            make.left.equalTo(self.iconIMGV.mas_right).offset(7);
        }];
    }return _titleLab;
}

-(UILabel *)tipsLab{
    if (!_tipsLab) {
        _tipsLab = UILabel.new;
        _tipsLab.backgroundColor = kBlueColor;
        _tipsLab.textColor = kWhiteColor;
        _tipsLab.font = [UIFont systemFontOfSize:5.33 weight:UIFontWeightMedium];
        _tipsLab.text = self.tipsStr;
        _tipsLab.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:_tipsLab];
        [_tipsLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.iconIMGV.mas_centerY);
            make.left.equalTo(self.iconIMGV.mas_right).offset(7);
            make.bottom.equalTo(self.iconIMGV);
            make.width.mas_equalTo(33);
        }];
    }return _tipsLab;
}

-(UILabel *)subTitleLab{
    if (!_subTitleLab) {
        _subTitleLab = UILabel.new;
        _subTitleLab.backgroundColor = kBlueColor;
        _subTitleLab.textColor = kWhiteColor;
        _subTitleLab.textAlignment = NSTextAlignmentCenter;
        _subTitleLab.font = [UIFont systemFontOfSize:5.33 weight:UIFontWeightMedium];
        _subTitleLab.text = self.subTitleStr;
        [self.contentView addSubview:_subTitleLab];
        [_subTitleLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(self.tipsLab);
            make.left.equalTo(self.tipsLab.mas_right).offset(4);
            make.width.mas_equalTo(33);
        }];
    }return _subTitleLab;
}

-(UILabel *)hitRateLab{
    if (!_hitRateLab) {
        _hitRateLab = UILabel.new;
        _hitRateLab.font = [UIFont systemFontOfSize:19.8 weight:UIFontWeightSemibold];
        _hitRateLab.text = self.hitRateStr;
        _hitRateLab.textColor = HEXCOLOR(0xFF5454);
        [_hitRateLab sizeToFit];
        [self.contentView addSubview:_hitRateLab];
        [_hitRateLab mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.size.mas_equalTo(CGSizeMake(50, 20));
            make.height.mas_equalTo(20);
            make.right.equalTo(self.contentView).offset(-11);
            make.bottom.equalTo(self.subTitleLab.mas_centerY);
        }];
    }return _hitRateLab;
}

-(UILabel *)hitRateTitleLab{
    if (!_hitRateTitleLab) {
        _hitRateTitleLab = UILabel.new;
        _hitRateTitleLab.textColor = HEXCOLOR(0x838383);
        _hitRateTitleLab.font = [UIFont systemFontOfSize:9.5 weight:UIFontWeightRegular];
        _hitRateTitleLab.text = self.hitRateTitleStr;
        [self.contentView addSubview:_hitRateTitleLab];
        [_hitRateTitleLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.hitRateLab);
            make.top.equalTo(self.hitRateLab.mas_bottom);
        }];
    }return _hitRateTitleLab;
}

-(UILabel *)contentLab{
    if (!_contentLab) {
        _contentLab = UILabel.new;
        _contentLab.text = self.contentStr;
        _contentLab.textAlignment = NSTextAlignmentCenter;
        _contentLab.textColor = kBlackColor;
        [_contentLab sizeToFit];
        _contentLab.font = [UIFont systemFontOfSize:12 weight:UIFontWeightRegular];
        [self.contentView addSubview:_contentLab];
        [_contentLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.subTitleLab.mas_bottom).offset(12);
            make.height.mas_equalTo(17);
            make.left.equalTo(self.iconIMGV);
        }];
    }return _contentLab;
}

-(UBLProgramView *)programView{
    if (!_programView) {
        _programView = UBLProgramView.new;
        [self.contentView addSubview:_programView];
        [_programView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(MAINSCREEN_WIDTH - 20 * 2, 20));
            make.top.equalTo(self.contentLab.mas_bottom).offset(20);
            make.centerX.equalTo(self.contentView);
        }];
    }return _programView;
}

-(UILabel *)typeLab{
    if (!_typeLab) {
        _typeLab = UILabel.new;
        _typeLab.text = self.typeStr;
        _typeLab.textColor = HEXCOLOR(0x5471AE);
        _typeLab.textAlignment = NSTextAlignmentCenter;
        _typeLab.backgroundColor = HEXCOLOR(0xF5F5F5);
        _typeLab.font = [UIFont systemFontOfSize:12 weight:UIFontWeightMedium];
        [self.contentView addSubview:_typeLab];
        [_typeLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(30, 17));
            make.height.mas_equalTo(17);
            make.left.equalTo(self.iconIMGV);
            make.top.equalTo(self.programView.mas_bottom).offset(16);
        }];
        [UIView cornerCutToCircleWithView:_typeLab AndCornerRadius:16 / 2];
    }return _typeLab;
}

-(UILabel *)timeLab{
    if (!_timeLab) {
        _timeLab = UILabel.new;
        _timeLab.text = self.timeStr;
        _timeLab.textAlignment = NSTextAlignmentCenter;
        _timeLab.textColor = HEXCOLOR(0x9C9EB0);
        [self.contentView addSubview:_timeLab];
        [_timeLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(self.typeLab);
            make.left.equalTo(self.typeLab.mas_right).offset(9);
        }];
    }return _timeLab;
}

-(UILabel *)styleLab{
    if (!_styleLab) {
        _styleLab = UILabel.new;
        _styleLab.text = self.styleStr;
        _styleLab.backgroundColor = HEXCOLOR(0xF5F5F5);
        _styleLab.textAlignment = NSTextAlignmentCenter;
        _styleLab.font = [UIFont systemFontOfSize:12 weight:UIFontWeightMedium];
        _styleLab.textColor = HEXCOLOR(0x7193DC);
        [self.contentView addSubview:_styleLab];
        [_styleLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.hitRateLab);
            make.size.mas_equalTo(CGSizeMake(56, 22));
            make.bottom.equalTo(self.contentView).offset(-9);
        }];
    }return _styleLab;
}

@end
