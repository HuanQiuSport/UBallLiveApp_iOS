//
//  VideoCollectionViewCell_Style2.m
//  UBallLive
//
//  Created by Jobs on 2020/10/20.
//

#import "UBLVideoCollectionViewCell@Style2.h"

@interface UBLVideoCollectionViewCell_Style2 ()

@property(nonatomic,strong)NSString *hostTeamNameStr;
@property(nonatomic,strong)NSString *guestTeamNameStr;
@property(nonatomic,strong)UIImage *hostTeamIMG;
@property(nonatomic,strong)UIImage *guestTeamIMG;
@property(nonatomic,strong)NSString *timeStr;
@property(nonatomic,strong)NSString *subStr;

@property(nonatomic,strong)UIButton *hostTeamBtn;//主队
@property(nonatomic,strong)UIButton *guestTeamBtn;//客队
@property(nonatomic,strong)UILabel *timeLab;
@property(nonatomic,strong)UIButton *subTitleBtn;

@end

@implementation UBLVideoCollectionViewCell_Style2

-(void)dealloc {
    NSLog(@"Running self.class = %@;NSStringFromSelector(_cmd) = '%@';__FUNCTION__ = %s", self.class, NSStringFromSelector(_cmd),__FUNCTION__);
}

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = kWhiteColor;
        self.separateLineIMGV.alpha = 1;
    }return self;
}

-(void)richElementsInCellWithModel:(id _Nullable)model{
    self.hostTeamNameStr = @"巴塞罗那";
    self.guestTeamNameStr = @"皇家马德里";
    self.hostTeamIMG = KBuddleIMG(@"⚽️PicResource", @"球队", nil, @"巴塞罗那");
    self.guestTeamIMG = KBuddleIMG(@"⚽️PicResource", @"球队", nil, @"皇家马德里");
    self.timeStr = @"明天 15：00";
    self.subStr = @"英超第四轮";
    
    self.hostTeamBtn.alpha = 1;
    self.guestTeamBtn.alpha = 1;
    self.timeLab.alpha = 1;
    self.subTitleBtn.alpha = 1;
}

+(CGSize)cellSizeWithModel:(id _Nullable)model{
    return CGSizeMake(MAINSCREEN_WIDTH - 20 * 2,94);
}
#pragma mark —— lazyLoad
-(UIImageView *)separateLineIMGV{
    if (!_separateLineIMGV) {
        _separateLineIMGV = UIImageView.new;
        _separateLineIMGV.image = KBuddleIMG(@"⚽️PicResource", @"分割线", nil, @"分割线1");
        [self.contentView addSubview:_separateLineIMGV];
        [_separateLineIMGV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView).offset(10);
            make.right.equalTo(self.contentView).offset(-10);
            make.height.mas_equalTo(@1);
            make.bottom.equalTo(self.contentView.mas_bottom);
        }];
    }return _separateLineIMGV;
}

-(UIButton *)hostTeamBtn{
    if (!_hostTeamBtn) {
        _hostTeamBtn = UIButton.new;
        _hostTeamBtn.userInteractionEnabled = NO;
        [_hostTeamBtn setTitleColor:kBlackColor
                            forState:UIControlStateNormal];
        [_hostTeamBtn setTitleLabelFont:[UIFont systemFontOfSize:13
                                                          weight:UIFontWeightMedium]];
        [_hostTeamBtn setTitle:self.hostTeamNameStr
                      forState:UIControlStateNormal];
        [_hostTeamBtn setImage:self.hostTeamIMG
                      forState:UIControlStateNormal];
        [self.contentView addSubview:_hostTeamBtn];
        [_hostTeamBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.contentView);
            make.left.equalTo(self.contentView).offset(29);
            make.top.equalTo(self.contentView).offset(15);
            make.bottom.equalTo(self.contentView).offset(-15);
        }];
        [_hostTeamBtn layoutButtonWithEdgeInsetsStyle:GLButtonEdgeInsetsStyleTop
                                        imageTitleSpace:5];
    }return _hostTeamBtn;
}

-(UIButton *)guestTeamBtn{
    if (!_guestTeamBtn) {
        _guestTeamBtn = UIButton.new;
        _guestTeamBtn.userInteractionEnabled = NO;
        [_guestTeamBtn setTitleColor:kBlackColor
                            forState:UIControlStateNormal];
        [_guestTeamBtn setTitleLabelFont:[UIFont systemFontOfSize:13
                                                           weight:UIFontWeightMedium]];
        [_guestTeamBtn setTitle:self.guestTeamNameStr
                      forState:UIControlStateNormal];
        [_guestTeamBtn setImage:self.guestTeamIMG
                      forState:UIControlStateNormal];
        [self.contentView addSubview:_guestTeamBtn];
        [_guestTeamBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.contentView);
            make.right.equalTo(self.contentView).offset(-29);
            make.top.equalTo(self.contentView).offset(15);
            make.bottom.equalTo(self.contentView).offset(-15);
        }];
        [_guestTeamBtn layoutButtonWithEdgeInsetsStyle:GLButtonEdgeInsetsStyleTop
                                        imageTitleSpace:5];
    }return _guestTeamBtn;
}

-(UILabel *)timeLab{
    if (!_timeLab) {
        _timeLab = UILabel.new;
        _timeLab.text = self.timeStr;
        _timeLab.font = [UIFont systemFontOfSize:14
                                          weight:UIFontWeightMedium];
        [_timeLab sizeToFit];
        [self.contentView addSubview:_timeLab];
        [_timeLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(self.contentView);
            make.height.mas_offset(20);
        }];
    }return _timeLab;
}

-(UIButton *)subTitleBtn{
    if (!_subTitleBtn) {
        _subTitleBtn = UIButton.new;
        _subTitleBtn.userInteractionEnabled = NO;
        [_subTitleBtn setImage:KBuddleIMG(@"⚽️PicResource", @"Others", nil, @"直播图标")
                      forState:UIControlStateNormal];
        [_subTitleBtn setTitle:self.subStr
                      forState:UIControlStateNormal];
        [_subTitleBtn setTitleColor:KLightGrayColor
                           forState:UIControlStateNormal];
        _subTitleBtn.titleLabel.font = [UIFont systemFontOfSize:11
                                                         weight:UIFontWeightMedium];
        [_subTitleBtn layoutButtonWithEdgeInsetsStyle:GLButtonEdgeInsetsStyleLeft
                                      imageTitleSpace:5];
        [self.contentView addSubview:_subTitleBtn];
        [_subTitleBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.contentView);
            make.bottom.equalTo(self.contentView).offset(-15);
        }];
    }return _subTitleBtn;
}

@end
