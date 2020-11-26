//
//  UBLVideoCollectionViewCell@Style18.m
//  UBallLive
//
//  Created by Jobs on 2020/11/20.
//

#import "UBLVideoCollectionViewCell@Style18.h"

@interface UBLVideoCollectionViewCell_Style18 ()

@property(nonatomic,strong)UILabel *titleLab;
@property(nonatomic,strong)UILabel *timeLab;
@property(nonatomic,strong)UILabel *scoreLab;
@property(nonatomic,strong)UILabel *separateLab;
@property(nonatomic,strong)UIButton *clockBtn;
@property(nonatomic,strong)UILabel *hostTeamNameLab;
@property(nonatomic,strong)UILabel *guestTeamNameLab;
@property(nonatomic,strong)UILabel *hostTeamScoreLab;
@property(nonatomic,strong)UILabel *guestTeamScoreLab;
@property(nonatomic,strong)UILabel *hostTeamYellowCardNumLab;
@property(nonatomic,strong)UILabel *guestTeamYellowCardNumLab;
@property(nonatomic,strong)UILabel *hostTeamRedCardNumLab;
@property(nonatomic,strong)UILabel *guestTeamRedCardNumLab;
@property(nonatomic,strong)UILabel *matchStateLab;
@property(nonatomic,strong)UIImageView *hotStateIMGV;
@property(nonatomic,strong)UIImageView *watchMethodIMGV;
//data
@property(nonatomic,strong)NSString *titleStr;
@property(nonatomic,strong)NSString *timeStr;
@property(nonatomic,strong)NSString *scoreStr;
@property(nonatomic,strong)UIImage *clockBtnIMG;
@property(nonatomic,strong)NSString *hostTeamNameStr;
@property(nonatomic,strong)NSString *guestTeamNameStr;
@property(nonatomic,strong)NSString *hostTeamScoreStr;
@property(nonatomic,strong)NSString *guestTeamScoreStr;
@property(nonatomic,strong)NSString *matchStateStr;
@property(nonatomic,strong)UIImage *hotStateIMG;
@property(nonatomic,strong)UIImage *watchMethodIMG;
@property(nonatomic,strong)NSString *hostTeamYellowCardNumStr;
@property(nonatomic,strong)NSString *guestTeamYellowCardNumStr;
@property(nonatomic,strong)NSString *hostTeamRedCardNumStr;
@property(nonatomic,strong)NSString *guestTeamRedCardNumStr;

@end

@implementation UBLVideoCollectionViewCell_Style18

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
    
    self.titleStr = @"联名赛";
    self.timeStr = @"08:27";
    self.scoreStr = @"半：0-1  全 3：0";
    self.clockBtnIMG = KBuddleIMG(@"⚽️PicResource", @"Others", @"闹钟", @"预约闹钟（蓝）");
    self.clockBtnIMG = KBuddleIMG(@"⚽️PicResource", @"Others", @"闹钟", @"未预约闹钟");
    self.hostTeamNameStr = @"河北华夏幸福";
    self.guestTeamNameStr = @"广州淘宝恒大";
    self.hostTeamScoreStr = @"0";
    self.guestTeamScoreStr = @"0";
    self.matchStateStr = @"完";
    self.hotStateIMG = KBuddleIMG(@"⚽️PicResource", @"Others", nil, @"fire");//静态图 🔥
    self.hotStateIMG = [UIImage animatedGIFNamed:@"⚽️PicResource/Gif/热度"];// 动态度 🔥
    self.watchMethodIMG = KBuddleIMG(@"⚽️PicResource", @"Others", nil, @"Playbook");//战术板
    self.watchMethodIMG = KBuddleIMG(@"⚽️PicResource", @"Others", nil, @"TV");//电视机
    self.hostTeamYellowCardNumStr = @"1";
    self.guestTeamYellowCardNumStr = @"2";
    self.hostTeamRedCardNumStr = @"3";
    self.guestTeamRedCardNumStr = @"5";

    self.titleLab.alpha = 1;
    self.timeLab.alpha = 1;
    self.scoreLab.alpha = 1;
    self.separateLab.alpha = 1;
    self.clockBtn.alpha = 1;
    self.matchStateLab.alpha = 1;
    self.hostTeamScoreLab.alpha = 1;
    self.hostTeamNameLab.alpha = 1;
    self.hostTeamRedCardNumLab.alpha = 1;
    self.hostTeamYellowCardNumLab.alpha = 1;
    self.guestTeamScoreLab.alpha = 1;
    self.guestTeamNameLab.alpha = 1;
    self.guestTeamYellowCardNumLab.alpha = 1;
    self.guestTeamRedCardNumLab.alpha = 1;
    self.hotStateIMGV.alpha = 1;
    self.watchMethodIMGV.alpha = 1;
}

+(CGSize)cellSizeWithModel:(id _Nullable)model{
    return CGSizeMake(MAINSCREEN_WIDTH - 12 * 2, 60);
}
#pragma mark —— lazyLoad
-(UILabel *)titleLab{
    if (!_titleLab) {
        _titleLab = UILabel.new;
        _titleLab.textAlignment = NSTextAlignmentCenter;
        _titleLab.font = [UIFont systemFontOfSize:9 weight:UIFontWeightMedium];
        _titleLab.text = self.titleStr;
        _titleLab.backgroundColor = RGBCOLOR(1, 153, 1);
        _titleLab.textColor = kWhiteColor;
        [self.contentView addSubview:_titleLab];
        [_titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_offset(CGSizeMake(47, 16));
            make.top.equalTo(self.contentView).offset(1);
            make.left.equalTo(self.contentView).offset(7);
        }];
        [UIView cornerCutToCircleWithView:_titleLab AndCornerRadius:8];
    }return _titleLab;
}

-(UILabel *)timeLab{
    if (!_timeLab) {
        _timeLab = UILabel.new;
        _timeLab.textAlignment = NSTextAlignmentCenter;
        _timeLab.font = [UIFont systemFontOfSize:10 weight:UIFontWeightMedium];
        _timeLab.textColor = RGBCOLOR(187, 187, 187);
        _timeLab.text = self.timeStr;
        [_timeLab sizeToFit];
        [self.contentView addSubview:_timeLab];
        [_timeLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(self.titleLab);
            make.left.equalTo(self.titleLab.mas_right).offset(7);
        }];
    }return _timeLab;
}

-(UILabel *)scoreLab{
    if (!_scoreLab) {
        _scoreLab = UILabel.new;
        _scoreLab.font = [UIFont systemFontOfSize:10 weight:UIFontWeightMedium];
        _scoreLab.textAlignment = NSTextAlignmentCenter;
        _scoreLab.text = self.scoreStr;
        _scoreLab.textColor = RGBCOLOR(187, 187, 187);
        [self.contentView addSubview:_scoreLab];
        [_scoreLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.contentView);
            make.centerY.equalTo(self.titleLab);
        }];
    }return _scoreLab;
}

-(UILabel *)separateLab{
    if (!_separateLab) {
        _separateLab = UILabel.new;
        _separateLab.backgroundColor = RGBCOLOR(242, 242, 242);
        [self.contentView addSubview:_separateLab];
        [_separateLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(1);
            make.left.right.equalTo(self.contentView);
            make.top.equalTo(self.titleLab.mas_bottom).offset(6);
        }];
    }return _separateLab;
}

-(UIButton *)clockBtn{
    if (!_clockBtn) {
        _clockBtn = UIButton.new;
        [_clockBtn setImage:self.clockBtnIMG forState:UIControlStateNormal];
        [self.contentView addSubview:_clockBtn];
        [_clockBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(13, 15));
            make.top.equalTo(self.separateLab.mas_bottom).offset(10);
            make.left.equalTo(self.contentView).offset(28);
        }];
    }return _clockBtn;
}

-(UILabel *)hostTeamNameLab{
    if (!_hostTeamNameLab) {
        _hostTeamNameLab = UILabel.new;
        _hostTeamNameLab.textAlignment = NSTextAlignmentCenter;
        _hostTeamNameLab.text = self.hostTeamNameStr;
        _hostTeamNameLab.font = [UIFont systemFontOfSize:12 weight:UIFontWeightMedium];
        _hostTeamNameLab.textColor = RGBCOLOR(70, 70, 70);
        [_hostTeamNameLab sizeToFit];
        [self.contentView addSubview:_hostTeamNameLab];
        [_hostTeamNameLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(self.clockBtn);
            make.height.mas_equalTo(16);
            make.right.equalTo(self.hostTeamScoreLab.mas_left).offset(-5);
        }];
    }return _hostTeamNameLab;
}

-(UILabel *)guestTeamNameLab{
    if (!_guestTeamNameLab) {
        _guestTeamNameLab = UILabel.new;
        _guestTeamNameLab.textAlignment = NSTextAlignmentCenter;
        _guestTeamNameLab.textColor = RGBCOLOR(70, 70, 70);
        _guestTeamNameLab.font = [UIFont systemFontOfSize:12 weight:UIFontWeightMedium];
        _guestTeamNameLab.text = self.guestTeamNameStr;
        [_guestTeamNameLab sizeToFit];
        [self.contentView addSubview:_guestTeamNameLab];
        [_guestTeamNameLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(self.clockBtn);
            make.height.mas_equalTo(16);
            make.left.equalTo(self.guestTeamScoreLab.mas_right).offset(5);
        }];
    }return _guestTeamNameLab;
}

-(UILabel *)hostTeamScoreLab{
    if (!_hostTeamScoreLab) {
        _hostTeamScoreLab = UILabel.new;
        _hostTeamScoreLab.textAlignment = NSTextAlignmentCenter;
        _hostTeamScoreLab.textColor = RGBCOLOR(57, 119, 254);
        _hostTeamScoreLab.text = self.hostTeamScoreStr;
        [_hostTeamScoreLab sizeToFit];
        [self.contentView addSubview:_hostTeamScoreLab];
        [_hostTeamScoreLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(self.matchStateLab);
            make.right.equalTo(self.matchStateLab.mas_left).offset(-1);
        }];
    }return _hostTeamScoreLab;
}

-(UILabel *)guestTeamScoreLab{
    if (!_guestTeamScoreLab) {
        _guestTeamScoreLab = UILabel.new;
        _guestTeamScoreLab.textAlignment = NSTextAlignmentCenter;
        _guestTeamScoreLab.text = self.guestTeamScoreStr;
        _guestTeamScoreLab.textColor = RGBCOLOR(57, 119, 254);
        [_guestTeamScoreLab sizeToFit];
        [self.contentView addSubview:_guestTeamScoreLab];
        [_guestTeamScoreLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(self.matchStateLab);
            make.left.equalTo(self.matchStateLab.mas_right).offset(1);
        }];
    }return _guestTeamScoreLab;
}

-(UILabel *)matchStateLab{
    if (!_matchStateLab) {
        _matchStateLab = UILabel.new;
        _matchStateLab.textAlignment = NSTextAlignmentCenter;
        _matchStateLab.backgroundColor = RGBCOLOR(239, 239, 239);
        _matchStateLab.textColor = RGBCOLOR(169, 167, 167);
        _matchStateLab.font = [UIFont systemFontOfSize:7 weight:UIFontWeightMedium];
        _matchStateLab.text = self.matchStateStr;
        [self.contentView addSubview:_matchStateLab];
        [_matchStateLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(21, 12));
            make.centerX.equalTo(self.contentView.mas_centerX);
            make.centerY.equalTo(self.clockBtn.mas_centerY);
        }];
        [UIView cornerCutToCircleWithView:_matchStateLab AndCornerRadius:2];
    }return _matchStateLab;
}

-(UIImageView *)hotStateIMGV{
    if (!_hotStateIMGV) {
        _hotStateIMGV = UIImageView.new;
        _hotStateIMGV.image = self.hotStateIMG;
        [self.contentView addSubview:_hotStateIMGV];
        [_hotStateIMGV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(10, 12));
            make.centerY.equalTo(self.titleLab);
            make.right.equalTo(self.contentView).offset(-18);
        }];
    }return _hotStateIMGV;
}

-(UIImageView *)watchMethodIMGV{
    if (!_watchMethodIMGV) {
        _watchMethodIMGV = UIImageView.new;
        _watchMethodIMGV.image = self.watchMethodIMG;
        [self.contentView addSubview:_watchMethodIMGV];
        [_watchMethodIMGV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.hotStateIMGV);
            make.size.mas_equalTo(CGSizeMake(19, 18));
            make.top.equalTo(self.separateLab.mas_bottom).offset(7);
        }];
    }return _watchMethodIMGV;
}

-(UILabel *)hostTeamYellowCardNumLab{
    if (!_hostTeamYellowCardNumLab) {
        _hostTeamYellowCardNumLab = UILabel.new;
        _hostTeamYellowCardNumLab.textAlignment = NSTextAlignmentCenter;
        _hostTeamYellowCardNumLab.font = [UIFont systemFontOfSize:9 weight:UIFontWeightMedium];
        _hostTeamYellowCardNumLab.text = self.hostTeamYellowCardNumStr;
        _hostTeamYellowCardNumLab.textColor = kWhiteColor;
        _hostTeamYellowCardNumLab.backgroundColor = RGBCOLOR(255, 179, 11);
        [self.contentView addSubview:_hostTeamYellowCardNumLab];
        [_hostTeamYellowCardNumLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(11, 13));
            make.centerY.equalTo(self.matchStateLab);
            make.right.equalTo(self.hostTeamRedCardNumLab.mas_left).offset(-6);
        }];
        [UIView cornerCutToCircleWithView:_hostTeamYellowCardNumLab AndCornerRadius:3];
    }return _hostTeamYellowCardNumLab;
}

-(UILabel *)guestTeamYellowCardNumLab{
    if (!_guestTeamYellowCardNumLab) {
        _guestTeamYellowCardNumLab = UILabel.new;
        _guestTeamYellowCardNumLab.textAlignment = NSTextAlignmentCenter;
        _guestTeamYellowCardNumLab.font = [UIFont systemFontOfSize:9 weight:UIFontWeightMedium];
        _guestTeamYellowCardNumLab.text = self.guestTeamYellowCardNumStr;
        _guestTeamYellowCardNumLab.backgroundColor = RGBCOLOR(255, 179, 11);
        _guestTeamYellowCardNumLab.textColor = kWhiteColor;
        [self.contentView addSubview:_guestTeamYellowCardNumLab];
        [_guestTeamYellowCardNumLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(11, 13));
            make.centerY.equalTo(self.matchStateLab);
            make.left.equalTo(self.guestTeamNameLab.mas_right).offset(6);
        }];
        [UIView cornerCutToCircleWithView:_guestTeamYellowCardNumLab AndCornerRadius:3];
    }return _guestTeamYellowCardNumLab;
}

-(UILabel *)hostTeamRedCardNumLab{
    if (!_hostTeamRedCardNumLab) {
        _hostTeamRedCardNumLab = UILabel.new;
        _hostTeamRedCardNumLab.textAlignment = NSTextAlignmentCenter;
        _hostTeamRedCardNumLab.font = [UIFont systemFontOfSize:9 weight:UIFontWeightMedium];
        _hostTeamRedCardNumLab.text = self.hostTeamRedCardNumStr;
        _hostTeamRedCardNumLab.backgroundColor = RGBCOLOR(255, 64, 31);
        _hostTeamRedCardNumLab.textColor = kWhiteColor;
        [self.contentView addSubview:_hostTeamRedCardNumLab];
        [_hostTeamRedCardNumLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(11, 13));
            make.centerY.equalTo(self.matchStateLab);
            make.right.equalTo(self.hostTeamNameLab.mas_left).offset(-6);
        }];
        [UIView cornerCutToCircleWithView:_hostTeamRedCardNumLab AndCornerRadius:3];
    }return _hostTeamRedCardNumLab;
}

-(UILabel *)guestTeamRedCardNumLab{
    if (!_guestTeamRedCardNumLab) {
        _guestTeamRedCardNumLab = UILabel.new;
        _guestTeamRedCardNumLab.textAlignment = NSTextAlignmentCenter;
        _guestTeamRedCardNumLab.text = self.guestTeamRedCardNumStr;
        _guestTeamRedCardNumLab.font = [UIFont systemFontOfSize:9 weight:UIFontWeightMedium];
        _guestTeamRedCardNumLab.backgroundColor = RGBCOLOR(255, 64, 31);
        _guestTeamRedCardNumLab.textColor = kWhiteColor;
        [self.contentView addSubview:_guestTeamRedCardNumLab];
        [_guestTeamRedCardNumLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(11, 13));
            make.centerY.equalTo(self.matchStateLab);
            make.left.equalTo(self.guestTeamYellowCardNumLab.mas_right).offset(6);
        }];
        [UIView cornerCutToCircleWithView:_guestTeamRedCardNumLab AndCornerRadius:3];
    }return _guestTeamRedCardNumLab;
}

@end

