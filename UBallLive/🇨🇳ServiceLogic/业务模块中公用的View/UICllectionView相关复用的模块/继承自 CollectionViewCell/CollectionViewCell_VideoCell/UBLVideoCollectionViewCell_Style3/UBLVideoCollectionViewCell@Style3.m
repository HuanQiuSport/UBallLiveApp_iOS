//
//  UBLVideoCollectionViewCell@Style3.m
//  UBallLive
//
//  Created by Jobs on 2020/10/20.
//

#import "UBLVideoCollectionViewCell@Style3.h"

@interface UBLVideoCollectionViewCell_Style3 ()

@property(nonatomic,strong)UIView *viewer;
@property(nonatomic,strong)UILabel *titleLab;
@property(nonatomic,strong)UILabel *timeLab;
@property(nonatomic,strong)UIButton *hostTeamBtn;
@property(nonatomic,strong)UIButton *guestTeamBtn;
@property(nonatomic,strong)UIImageView *clockIMGV;

@property(nonatomic,strong)NSString *titleStr;
@property(nonatomic,strong)NSString *timeStr;
@property(nonatomic,strong)NSString *hostTeamNameStr;
@property(nonatomic,strong)NSString *guestTeamNameStr;
@property(nonatomic,strong)UIImage *hostTeamIMG;
@property(nonatomic,strong)UIImage *guestTeamIMG;

@end

@implementation UBLVideoCollectionViewCell_Style3

-(void)dealloc {
    NSLog(@"Running self.class = %@;NSStringFromSelector(_cmd) = '%@';__FUNCTION__ = %s", self.class, NSStringFromSelector(_cmd),__FUNCTION__);
}

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = kWhiteColor;
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
    }return self;
}

-(void)richElementsInCellWithModel:(id _Nullable)model{
    
    self.titleStr = @"西甲";
    self.timeStr = @"09-17 9:30";
    self.hostTeamNameStr = @"河北华夏幸福";
    self.guestTeamNameStr = @"广州恒大淘宝";
    self.hostTeamIMG = KBuddleIMG(@"⚽️PicResource", @"球队", nil, @"巴塞罗那 小图标");
    self.guestTeamIMG = KBuddleIMG(@"⚽️PicResource", @"球队", nil, @"皇家马德里 小图标");
    
    self.viewer.alpha = 1;
    self.titleLab.alpha = 1;
    self.timeLab.alpha = 1;
    self.hostTeamBtn.alpha = 1;
    self.guestTeamBtn.alpha = 1;
    self.clockIMGV.alpha = 1;
}

+(CGSize)cellSizeWithModel:(id _Nullable)model{
    return CGSizeMake((MAINSCREEN_WIDTH - Margin_collectionView * 2 - Margin_itemX) / 2, 79);;
}
#pragma mark —— lazyLoad
-(UIView *)viewer{
    if (!_viewer) {
        _viewer = UIView.new;
        _viewer.backgroundColor= HEXCOLOR(0xF8F8F8);
        [self.contentView addSubview:_viewer];
        [_viewer mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentView).offset(4);
            make.left.equalTo(self.contentView).offset(8);
            make.right.equalTo(self.contentView).offset(-8);
            make.height.mas_equalTo(25);
        }];
        [UIView cornerCutToCircleWithView:_viewer AndCornerRadius:3];
    }return _viewer;
}

-(UILabel *)titleLab{
    if (!_titleLab) {
        _titleLab = UILabel.new;
        _titleLab.text = self.titleStr;
        _titleLab.textColor = KLightGrayColor;
        _titleLab.font = [UIFont systemFontOfSize:10
                                           weight:UIFontWeightRegular];
        [self.viewer addSubview:_titleLab];
        [_titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(self.viewer);
            make.left.equalTo(self.viewer).offset(4);
        }];
    }return _titleLab;
}

-(UILabel *)timeLab{
    if (!_timeLab) {
        _timeLab = UILabel.new;
        _timeLab.text = self.timeStr;
        _timeLab.textColor = KLightGrayColor;
        _timeLab.font = [UIFont systemFontOfSize:10
                                          weight:UIFontWeightRegular];
        [self.viewer addSubview:_timeLab];
        [_timeLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(self.viewer);
            make.right.equalTo(self.viewer).offset(-4);
        }];
    }return _timeLab;
}

-(UIButton *)hostTeamBtn{
    if (!_hostTeamBtn) {
        _hostTeamBtn = UIButton.new;
        [_hostTeamBtn setTitleColor:kBlackColor
                           forState:UIControlStateNormal];
        _hostTeamBtn.titleLabel.font = [UIFont systemFontOfSize:11
                                                         weight:UIFontWeightRegular];
        [_hostTeamBtn setTitle:self.hostTeamNameStr
                      forState:UIControlStateNormal];
        [_hostTeamBtn setImage:self.hostTeamIMG
                      forState:UIControlStateNormal];
        [self.contentView addSubview:_hostTeamBtn];
        [_hostTeamBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.viewer.mas_bottom);
            make.height.mas_equalTo(25);
            make.left.equalTo(self.viewer);
        }];
    }return _hostTeamBtn;
}

-(UIButton *)guestTeamBtn{
    if (!_guestTeamBtn) {
        _guestTeamBtn = UIButton.new;
        [_guestTeamBtn setTitleColor:kBlackColor
                            forState:UIControlStateNormal];
        _guestTeamBtn.titleLabel.font = [UIFont systemFontOfSize:11
                                                          weight:UIFontWeightRegular];
        [_guestTeamBtn setTitle:self.guestTeamNameStr
                       forState:UIControlStateNormal];
        [_guestTeamBtn setImage:self.guestTeamIMG
                       forState:UIControlStateNormal];
        [self.contentView addSubview:_guestTeamBtn];
        [_guestTeamBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.contentView);
            make.height.mas_equalTo(25);
            make.left.equalTo(self.viewer);
        }];
    }return _guestTeamBtn;
}

-(UIImageView *)clockIMGV{
    if (!_clockIMGV) {
        _clockIMGV = UIImageView.new;
        _clockIMGV.image = KBuddleIMG(@"⚽️PicResource", @"Others", @"闹钟", @"预约闹钟（红）");
        [self.contentView addSubview:_clockIMGV];
        [_clockIMGV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(13, 15));
            make.top.equalTo(self.viewer.mas_bottom).offset(17);
            make.right.equalTo(self.contentView).offset(-19);
        }];
    }return _clockIMGV;
}

@end
