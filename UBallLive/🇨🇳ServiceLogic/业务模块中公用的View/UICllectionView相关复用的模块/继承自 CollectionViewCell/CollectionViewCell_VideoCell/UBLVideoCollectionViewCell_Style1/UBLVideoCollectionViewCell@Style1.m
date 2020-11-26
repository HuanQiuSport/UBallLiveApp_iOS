//
//  VideoCollectionViewCell@Style1.m
//  UBallLive
//
//  Created by Jobs on 2020/10/18.
//

#import "UBLVideoCollectionViewCell@Style1.h"
#import "UBLCollectionViewCellImageView.h"

@interface UBLVideoCollectionViewCell_Style1 ()
//UI
//@property(nonatomic,strong,nullable)ZFAVPlayerManager *playerManager;
@property(nonatomic,strong)UBLCollectionViewCellImageView *imgV;//图片展示
@property(nonatomic,strong)UIButton *tipsBtn;//生活
@property(nonatomic,strong)UIButton *focusHotBtn;//🔥
@property(nonatomic,strong)UILabel *MCNameLab;//解说主持人名字显示
@property(nonatomic,strong)UILabel *titleLab;//视频内容
@property(nonatomic,strong)UILabel *subTitleLab;//视频副标题
//data
@property(nonatomic,strong)NSString *focusHotNumStr;
@property(nonatomic,strong)NSString *tips;
@property(nonatomic,strong)NSString *tempStr;
@property(nonatomic,strong)NSString *MCNameStr;
@property(nonatomic,strong)NSString *titleStr;
@property(nonatomic,strong)NSString *subTitleStr;
@property(nonatomic,strong)UIImage *img;

@end

@implementation UBLVideoCollectionViewCell_Style1

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
    self.tempStr = model;
    self.focusHotNumStr = @"1394";
    self.MCNameStr = @"加工资";
    self.titleStr = @"云南红塔山 vc 北京国安";
    self.subTitleStr = @"中超B组第12轮";
    self.img = [UIImage animatedGIFNamed:@"⚽️PicResource/Gif/Bt9h"];
    self.tips = @"生活";

    self.focusHotBtn.alpha = 1;
    self.tipsBtn.alpha = 1;
    self.MCNameLab.alpha = 1;
    self.titleLab.alpha = 1;
    self.subTitleLab.alpha = 1;
    self.imgV.alpha = 1;
}

+(CGSize)cellSizeWithModel:(id _Nullable)model{
    return CGSizeMake((MAINSCREEN_WIDTH - Margin_collectionView * 2 - Margin_itemX) / 2, 162);
}
#pragma mark —— lazyLoad
-(UBLCollectionViewCellImageView *)imgV{
    if (!_imgV) {
        if (self.indexPath.section == 0 && self.indexPath.row == 0) {
            _imgV = [[UBLCollectionViewCellImageView alloc] initWithFirstFrameFigureIMG:self.img
                                                                         videoURLString:@"http://1011.hlsplay.aodianyun.com/demo/game.flv"];
        }else{
            _imgV = [[UBLCollectionViewCellImageView alloc] initWithFirstFrameFigureIMG:self.img
                                                                         videoURLString:@""];
        }
        [self.contentView addSubview:_imgV];
        [_imgV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.equalTo(self.contentView);
            make.height.mas_equalTo(110);
        }];
    }return _imgV;
}

-(UIButton *)focusHotBtn{
    if (!_focusHotBtn) {
        _focusHotBtn = UIButton.new;
        [_focusHotBtn setTitle:self.focusHotNumStr
                      forState:UIControlStateNormal];
        [_focusHotBtn setTitleColor:KLightGrayColor
                           forState:UIControlStateNormal];
        _focusHotBtn.titleLabel.font = [UIFont systemFontOfSize:10
                                                         weight:UIFontWeightMedium];
        [_focusHotBtn setImage:[UIImage animatedGIFNamed:@"⚽️PicResource/Gif/热度"]
                      forState:UIControlStateNormal];
        [_focusHotBtn.titleLabel sizeToFit];
        [_focusHotBtn.titleLabel adjustsFontSizeToFitWidth];
        [self.imgV addSubview:_focusHotBtn];
        [_focusHotBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.imgV).offset(-8);
            make.bottom.equalTo(self.subTitleLab);
        }];
    }return _focusHotBtn;
}

-(UIButton *)tipsBtn{
    if (!_tipsBtn) {
        _tipsBtn = UIButton.new;
        [_tipsBtn setTitle:self.tips
                      forState:UIControlStateNormal];
        [_tipsBtn setBackgroundImage:KBuddleIMG(@"⚽️PicResource",
                                                @"Others",
                                                nil,
                                                @"生活")
                            forState:UIControlStateNormal];
        [_tipsBtn setTitleColor:kWhiteColor
                           forState:UIControlStateNormal];
        _tipsBtn.titleLabel.font = [UIFont systemFontOfSize:10
                                                         weight:UIFontWeightMedium];
        [_tipsBtn setImage:[UIImage animatedGIFNamed:@"⚽️PicResource/Gif/跳动的竖线"]
                  forState:UIControlStateNormal];
        [_tipsBtn.titleLabel sizeToFit];
        [_tipsBtn.titleLabel adjustsFontSizeToFitWidth];
        [self.imgV addSubview:_tipsBtn];
        [_tipsBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.imgV).offset(-8);
            make.top.equalTo(self.imgV).offset(8);
        }];
    }return _tipsBtn;
}

-(UILabel *)MCNameLab{
    if (!_MCNameLab) {
        _MCNameLab = UILabel.new;
        _MCNameLab.text = self.MCNameStr;
        [_MCNameLab setTintColor:kWhiteColor];
        _MCNameLab.font = [UIFont systemFontOfSize:10 weight:UIFontWeightMedium];
        [_MCNameLab sizeToFit];
        _MCNameLab.textColor = kWhiteColor;
        [self.imgV addSubview:_MCNameLab];
        [_MCNameLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.imgV).offset(8);
            make.bottom.equalTo(self.imgV).offset(-5);
        }];
    }return _MCNameLab;
}

-(UILabel *)titleLab{
    if (!_titleLab) {
        _titleLab = UILabel.new;
        _titleLab.textColor = kBlackColor;
        _titleLab.text = self.titleStr;
        _titleLab.textAlignment = NSTextAlignmentLeft;
        _titleLab.font = [UIFont systemFontOfSize:13 weight:UIFontWeightMedium];
        [_titleLab sizeToFit];
        [self.contentView addSubview:_titleLab];
        [_titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.imgV.mas_bottom);
            make.left.equalTo(self.contentView).offset(13);
            make.right.equalTo(self.contentView).offset(-13);
        }];
    }return _titleLab;
}

-(UILabel *)subTitleLab{
    if (!_subTitleLab) {
        _subTitleLab = UILabel.new;
        _subTitleLab.text = self.subTitleStr;
        _subTitleLab.font = [UIFont systemFontOfSize:10 weight:UIFontWeightMedium];
        _subTitleLab.textColor = HEXCOLOR(0x9B9B9B);
        _subTitleLab.backgroundColor = RGBCOLOR(243, 243, 243);
        _subTitleLab.textAlignment = NSTextAlignmentLeft;
        [_subTitleLab sizeToFit];
        [self.contentView addSubview:_subTitleLab];
        [_subTitleLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.titleLab.mas_bottom);
            make.left.equalTo(self.contentView).offset(13);
            make.bottom.equalTo(self.contentView).offset(-9);
        }];
        [self.contentView layoutIfNeeded];
        [UIView cornerCutToCircleWithView:_subTitleLab AndCornerRadius:3];
    }return _subTitleLab;
}

@end
