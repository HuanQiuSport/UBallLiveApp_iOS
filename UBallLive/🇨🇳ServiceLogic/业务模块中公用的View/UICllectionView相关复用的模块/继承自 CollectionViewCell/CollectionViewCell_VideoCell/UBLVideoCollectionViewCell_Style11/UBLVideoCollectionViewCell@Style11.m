//
//  UBLVideoCollectionViewCell@Style11.m
//  UBallLive
//
//  Created by Jobs on 2020/11/1.
//

#import "UBLVideoCollectionViewCell@Style11.h"

@interface UBLVideoCollectionViewCell_Style11 ()

@property(nonatomic,strong)UIImageView *userHeaderIMGV;
@property(nonatomic,strong)UILabel *userNameLab;
@property(nonatomic,strong)UILabel *fansLab;
@property(nonatomic,strong)UIButton *userClassBtn;
@property(nonatomic,strong)UIButton *userRoleBtn;
@property(nonatomic,strong)UIButton *userRankBtn;
@property(nonatomic,strong)UIButton *attentionBtn;
//data
@property(nonatomic,strong)UIImage *userHeaderIMG;
@property(nonatomic,strong)UIImage *userClassBgIMG;
@property(nonatomic,strong)NSString *userClassStr;
@property(nonatomic,strong)NSString *userRoleStr;
@property(nonatomic,strong)NSString *userRankStr;
@property(nonatomic,strong)NSString *fansNumStr;
@property(nonatomic,strong)NSString *userNameStr;
@property(nonatomic,strong)NSString *titleStr;

@property(nonatomic,copy)MKDataBlock videoCollectionViewCell_Style11Block;

@end

@implementation UBLVideoCollectionViewCell_Style11

-(void)dealloc {
    NSLog(@"Running self.class = %@;NSStringFromSelector(_cmd) = '%@';__FUNCTION__ = %s", self.class, NSStringFromSelector(_cmd),__FUNCTION__);
}

-(void)actionBlockVideoCollectionViewCell_Style11:(MKDataBlock _Nullable)videoCollectionViewCell_Style11Block{
    self.videoCollectionViewCell_Style11Block = videoCollectionViewCell_Style11Block;
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
    
    self.userHeaderIMG = KIMG(@"替代头像");
    self.userRankStr = @"专家";
    self.userClassBgIMG = KBuddleIMG(@"⚽️PicResource", @"Others", @"用户等级", @"等级");

    self.userClassStr = @"Lv 33";
    self.userRoleStr = @"主播";
    self.fansNumStr = @"粉丝：115";
    self.userNameStr = @"张国荣";
    
    self.userHeaderIMGV.alpha = 1;
    self.userNameLab.alpha = 1;
    self.fansLab.alpha = 1;
    self.userClassBtn.alpha = 1;
    self.userRoleBtn.alpha = 1;
    self.userRankBtn.alpha = 1;
    self.attentionBtn.alpha = 1;
}

+(CGSize)cellSizeWithModel:(id _Nullable)model{
    return CGSizeMake(MAINSCREEN_WIDTH - 12 * 2, 73);
}
#pragma mark —— lazyLoad
-(UIImageView *)userHeaderIMGV{
    if (!_userHeaderIMGV) {
        _userHeaderIMGV = UIImageView.new;
        _userHeaderIMGV.image = self.userHeaderIMG;
        _userHeaderIMGV.backgroundColor = kRedColor;
        [self addSubview:_userHeaderIMGV];
        [_userHeaderIMGV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(49, 49));
            make.left.equalTo(self.contentView).offset(18);
            make.centerY.equalTo(self.contentView);
        }];
        [UIView cornerCutToCircleWithView:_userHeaderIMGV AndCornerRadius:49 / 2];
    }return _userHeaderIMGV;
}

-(UILabel *)userNameLab{
    if (!_userNameLab) {
        _userNameLab = UILabel.new;
        _userNameLab.textAlignment = NSTextAlignmentLeft;
        _userNameLab.textColor = HEXCOLOR(0x6E7283);
        _userNameLab.text = self.userNameStr;
        _userNameLab.font = [UIFont systemFontOfSize:12 weight:UIFontWeightMedium];
        [self.contentView addSubview:_userNameLab];
        [_userNameLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.userHeaderIMGV.mas_right).offset(10);
            make.bottom.equalTo(self.userHeaderIMGV.mas_centerY);
            make.width.mas_offset(72);
        }];
    }return _userNameLab;
}

-(UILabel *)fansLab{
    if (!_fansLab) {
        _fansLab = UILabel.new;
        _fansLab.text = self.fansNumStr;
        _fansLab.textColor = HEXCOLOR(0x6E7283);
        _fansLab.font = [UIFont systemFontOfSize:11 weight:UIFontWeightMedium];
        [_fansLab sizeToFit];
        [self addSubview:_fansLab];
        [_fansLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.userHeaderIMGV.mas_right).offset(10);
            make.top.equalTo(self.userHeaderIMGV.mas_centerY);
        }];
    }return _fansLab;
}

-(UIButton *)userClassBtn{
    if (!_userClassBtn) {
        _userClassBtn = UIButton.new;
        [_userClassBtn setTitle:self.userClassStr
                       forState:UIControlStateNormal];
        [_userClassBtn setImage:self.userClassBgIMG forState:UIControlStateNormal];
        [self addSubview:_userClassBtn];
        [_userClassBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.userNameLab.mas_right);
            make.top.equalTo(self.userNameLab).offset(-3);
            make.size.mas_equalTo(CGSizeMake(44, 15.5));
        }];
    }return _userClassBtn;
}

-(UIButton *)userRoleBtn{
    if (!_userRoleBtn) {
        _userRoleBtn = UIButton.new;
       [_userRoleBtn setBackgroundImage:KBuddleIMG(@"⚽️PicResource",
                                                   @"Others",
                                                   nil,
                                                   @"角色(主播)背景")
                      forState:UIControlStateNormal];
        [_userRoleBtn setTitle:self.userRoleStr
                      forState:UIControlStateNormal];
        [_userRoleBtn setTitleColor:kWhiteColor
                           forState:UIControlStateNormal];
        _userRoleBtn.titleLabel.font = [UIFont systemFontOfSize:7
                                                         weight:UIFontWeightMedium];
        [_userRoleBtn sizeToFit];
        _userRoleBtn.titleLabel.adjustsFontSizeToFitWidth = YES;
        [self addSubview:_userRoleBtn];
        [_userRoleBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.userHeaderIMGV.mas_centerY).offset(3);
            make.left.equalTo(self.userClassBtn);
            make.size.mas_equalTo(CGSizeMake(18, 15));
        }];
    }return _userRoleBtn;
}

-(UIButton *)userRankBtn{
    if (!_userRankBtn) {
        _userRankBtn = UIButton.new;
        _userRankBtn.titleLabel.font = [UIFont systemFontOfSize:7 weight:UIFontWeightMedium];
        _userRankBtn.titleLabel.textColor = HEXCOLOR(0xFFFFFF);
        [_userRankBtn setTitle:self.userRankStr forState:UIControlStateNormal];
        [_userRankBtn setBackgroundImage:KBuddleIMG(@"⚽️PicResource", @"Others", @"级别", @"专家级别")
                                forState:UIControlStateNormal];
        [self.contentView addSubview:_userRankBtn];
        [_userRankBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(42, 16));
            make.top.equalTo(self.userClassBtn);
            make.left.equalTo(self.userClassBtn.mas_right).offset(7);
        }];
        [UIView cornerCutToCircleWithView:_userRankBtn AndCornerRadius:16 / 2];
    }return _userRankBtn;
}

-(UIButton *)attentionBtn{
    if (!_attentionBtn) {
        _attentionBtn = UIButton.new;
        [_attentionBtn setBackgroundImage:KBuddleIMG(@"⚽️PicResource", @"Others", @"关注", @"关注，渐变色带+号按钮") forState:UIControlStateNormal];
        [_attentionBtn setBackgroundImage:KBuddleIMG(@"⚽️PicResource", @"Others", @"关注", @"已关注，渐变色带+号按钮") forState:UIControlStateSelected];
        [_attentionBtn setTitleColor:kBlueColor
                   forState:UIControlStateNormal];
        [[_attentionBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
            //点击事件
            x.selected = !x.selected;
            if (self.videoCollectionViewCell_Style11Block) {
                self.videoCollectionViewCell_Style11Block(x);
            }
        }];
        [self addSubview:_attentionBtn];
        [_attentionBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(84, 29));
            make.right.equalTo(self.contentView).offset(-17);
            make.centerY.equalTo(self.contentView);
        }];
    }return _attentionBtn;
}

@end
