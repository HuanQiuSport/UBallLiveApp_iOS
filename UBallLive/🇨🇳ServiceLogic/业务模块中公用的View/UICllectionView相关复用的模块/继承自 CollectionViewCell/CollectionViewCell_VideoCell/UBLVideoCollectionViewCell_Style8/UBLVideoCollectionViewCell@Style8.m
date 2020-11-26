//
//  UBLVideoCollectionViewCell@Style8.m
//  UBallLive
//
//  Created by Jobs on 2020/10/31.
//

#import "UBLVideoCollectionViewCell@Style8.h"

@interface UBLVideoCollectionViewCell_Style8 ()

@property(nonatomic,strong)UILabel *timeLab;
@property(nonatomic,strong)UILabel *horizontalLineLab;
@property(nonatomic,strong)UILabel *matchStateLab;
@property(nonatomic,strong)UILabel *titleLab;
@property(nonatomic,strong)UILabel *verticalLineLab;
@property(nonatomic,strong)UIButton *hostTeamBtn;
@property(nonatomic,strong)UIButton *guestTeamBtn;
@property(nonatomic,strong)UILabel *hostTeamScoreLab;
@property(nonatomic,strong)UILabel *guestTeamScoreLab;
//data
@property(nonatomic,strong)NSString *timeStr;
@property(nonatomic,strong)NSString *matchStateStr;
@property(nonatomic,strong)NSString *titleStr;
@property(nonatomic,strong)NSString *hostTeamTitleStr;
@property(nonatomic,strong)NSString *guestTeamTitleStr;
@property(nonatomic,strong)NSString *hostTeamScoreStr;
@property(nonatomic,strong)NSString *guestTeamScoreStr;
@property(nonatomic,strong)UIImage *hostTeamIMG;
@property(nonatomic,strong)UIImage *guestTeamIMG;

@end

@implementation UBLVideoCollectionViewCell_Style8

-(void)dealloc {
    NSLog(@"Running self.class = %@;NSStringFromSelector(_cmd) = '%@';__FUNCTION__ = %s", self.class, NSStringFromSelector(_cmd),__FUNCTION__);
}

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [UIView makeTargetShadowview:self
                           superView:nil
                     shadowDirection:ShadowDirection_rightDown
                   shadowWithOffsetX:5
                             offsetY:5
                        cornerRadius:8
                        shadowOffset:defaultSize
                       shadowOpacity:1
                    layerShadowColor:defaultObj
                   layerShadowRadius:defaultValue];
        self.backgroundColor = kWhiteColor;
    }return self;
}

-(void)richElementsInCellWithModel:(id _Nullable)model{
    
    self.timeStr = @"2020.10.5 星期四";
    self.matchStateStr = @"已结束";
    self.titleStr = @"恒大";
    self.hostTeamTitleStr = @"河北华夏幸福";
    self.guestTeamTitleStr = @"广州淘宝恒大";
    self.hostTeamScoreStr = @"0";
    self.guestTeamScoreStr = @"0";
    self.hostTeamIMG = KIMG(@"广州恒大淘宝");
    self.guestTeamIMG = KIMG(@"河北华夏幸福");

    self.timeLab.alpha = 1;
    self.horizontalLineLab.alpha = 1;
    self.matchStateLab.alpha = 1;
    self.titleLab.alpha = 1;
    self.verticalLineLab.alpha = 1;
    self.hostTeamBtn.alpha = 1;
    self.guestTeamBtn.alpha = 1;
    self.hostTeamScoreLab.alpha = 1;
    self.guestTeamScoreLab.alpha = 1;
}

+(CGSize)cellSizeWithModel:(id _Nullable)model{
    return CGSizeMake(MAINSCREEN_WIDTH - 11 * 2, 79);
}
#pragma mark —— lazyLoad
-(UILabel *)timeLab{
    if (!_timeLab) {
        _timeLab = UILabel.new;
        _timeLab.text = self.timeStr;
        _timeLab.textColor = kBlackColor;
        _timeLab.font = [UIFont systemFontOfSize:12 weight:UIFontWeightMedium];
        [self.contentView addSubview:_timeLab];
        [_timeLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentView).offset(3);
            make.left.equalTo(self.contentView).offset(5);
            make.height.mas_equalTo(21);
        }];
    }return _timeLab;
}

-(UILabel *)horizontalLineLab{
    if (!_horizontalLineLab) {
        _horizontalLineLab = UILabel.new;
        _horizontalLineLab.backgroundColor = HEXCOLOR(0xF2F2F2);
        [self.contentView addSubview:_horizontalLineLab];
        [_horizontalLineLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(1);
            make.left.right.equalTo(self.contentView);
            make.top.equalTo(self.timeLab.mas_bottom);
        }];
    }return _horizontalLineLab;
}

-(UILabel *)matchStateLab{
    if (!_matchStateLab) {
        _matchStateLab = UILabel.new;
        _matchStateLab.textColor = HEXCOLOR(0xBBBBBB);
        _matchStateLab.textAlignment = NSTextAlignmentCenter;
        _matchStateLab.text = self.matchStateStr;
        _matchStateLab.font = [UIFont systemFontOfSize:14 weight:UIFontWeightMedium];
        [self.contentView addSubview:_matchStateLab];
        [_matchStateLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView);
            make.top.equalTo(self.horizontalLineLab.mas_bottom).offset(9);
            make.width.mas_equalTo(80);
        }];
    }return _matchStateLab;
}

-(UILabel *)titleLab{
    if (!_titleLab) {
        _titleLab = UILabel.new;
        _titleLab.textColor = HEXCOLOR(0x4B88EC);
        _titleLab.textAlignment = NSTextAlignmentCenter;
        _titleLab.font = [UIFont systemFontOfSize:11 weight:UIFontWeightMedium];
        _titleLab.text = self.titleStr;
        [self.contentView addSubview:_titleLab];
        [_titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.matchStateLab);
            make.width.mas_equalTo(80);
            make.top.equalTo(self.matchStateLab.mas_bottom);
        }];
    }return _titleLab;
}

-(UILabel *)verticalLineLab{
    if (!_verticalLineLab) {
        _verticalLineLab = UILabel.new;
        _verticalLineLab.backgroundColor = HEXCOLOR(0xF2F2F2);
        [self.contentView addSubview:_verticalLineLab];
        [_verticalLineLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.titleLab.mas_right);
            make.top.equalTo(self.horizontalLineLab.mas_bottom).offset(8);
            make.bottom.equalTo(self.contentView).offset(-8);
            make.width.mas_equalTo(1);
        }];
        
    }return _verticalLineLab;
}

-(UIButton *)hostTeamBtn{
    if (!_hostTeamBtn) {
        _hostTeamBtn = UIButton.new;
        [_hostTeamBtn setTitleColor:HEXCOLOR(0x464646) forState:UIControlStateNormal];
        [_hostTeamBtn setTitle:self.hostTeamTitleStr forState:UIControlStateNormal];
        [_hostTeamBtn setImage:self.hostTeamIMG forState:UIControlStateNormal];
        _hostTeamBtn.titleLabel.font = [UIFont systemFontOfSize:11 weight:UIFontWeightRegular];
        
        [_hostTeamBtn layoutButtonWithEdgeInsetsStyle:GLButtonEdgeInsetsStyleLeft imageTitleSpace:7.3];
        
        [self.contentView addSubview:_hostTeamBtn];
        [_hostTeamBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.horizontalLineLab);
            make.left.equalTo(self.verticalLineLab.mas_right).offset(22);
            make.size.mas_equalTo(CGSizeMake(150, 21));
        }];
    }return _hostTeamBtn;
}

-(UIButton *)guestTeamBtn{
    if (!_guestTeamBtn) {
        _guestTeamBtn = UIButton.new;
        [_guestTeamBtn setTitleColor:HEXCOLOR(0x464646) forState:UIControlStateNormal];
        [_guestTeamBtn setTitle:self.guestTeamTitleStr forState:UIControlStateNormal];
        [_guestTeamBtn setImage:self.guestTeamIMG forState:UIControlStateNormal];
        _guestTeamBtn.titleLabel.font = [UIFont systemFontOfSize:11 weight:UIFontWeightRegular];
        
        [_guestTeamBtn layoutButtonWithEdgeInsetsStyle:GLButtonEdgeInsetsStyleLeft imageTitleSpace:7.3];
        
        [self.contentView addSubview:_guestTeamBtn];
        [_guestTeamBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.contentView);
            make.size.mas_equalTo(CGSizeMake(150, 21));
            make.left.equalTo(self.hostTeamBtn);
        }];
    }return _guestTeamBtn;
}

-(UILabel *)hostTeamScoreLab{
    if (!_hostTeamScoreLab) {
        _hostTeamScoreLab = UILabel.new;
        _hostTeamScoreLab.textColor = HEXCOLOR(0xFF3434);
        _hostTeamScoreLab.text = self.hostTeamScoreStr;
        _hostTeamScoreLab.textAlignment = NSTextAlignmentCenter;
        _hostTeamScoreLab.font = [UIFont systemFontOfSize:11 weight:UIFontWeightSemibold];
        [self.contentView addSubview:_hostTeamScoreLab];
        [_hostTeamScoreLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.guestTeamBtn.mas_right);
            make.right.equalTo(self.contentView);
            make.top.bottom.equalTo(self.hostTeamBtn);
        }];
    }return _hostTeamScoreLab;
}

-(UILabel *)guestTeamScoreLab{
    if (!_guestTeamScoreLab) {
        _guestTeamScoreLab = UILabel.new;
        _guestTeamScoreLab.textColor = HEXCOLOR(0x4F82FF);
        _guestTeamScoreLab.textAlignment = NSTextAlignmentCenter;
        _guestTeamScoreLab.font = [UIFont systemFontOfSize:11 weight:UIFontWeightSemibold];
        _guestTeamScoreLab.text = self.guestTeamScoreStr;
        [self.contentView addSubview:_guestTeamScoreLab];
        [_guestTeamScoreLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.guestTeamBtn.mas_right);
            make.right.equalTo(self.contentView);
            make.top.bottom.equalTo(self.guestTeamBtn);
        }];
    }return _guestTeamScoreLab;
}

@end
