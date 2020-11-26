//
//  UBLVideoCollectionViewCell@Style7.m
//  UBallLive
//
//  Created by Jobs on 2020/10/31.
//

#import "UBLVideoCollectionViewCell@Style7.h"

@interface UBLVideoCollectionViewCell_Style7 ()

@property(nonatomic,strong)UIImageView *imageView;
@property(nonatomic,strong)UILabel *titleLab;
@property(nonatomic,strong)UILabel *subTitleLab;
@property(nonatomic,strong)UIButton *focusHotBtn;//🔥
@property(nonatomic,strong)UIButton *likeBtn;//❤️
//data
@property(nonatomic,strong)UIImage *img;
@property(nonatomic,strong)NSString *titleStr;
@property(nonatomic,strong)NSString *subTitleStr;
@property(nonatomic,strong)NSString *focusHotBtnTitleStr;
@property(nonatomic,strong)NSString *likeBtnTitleStr;

@end

@implementation UBLVideoCollectionViewCell_Style7

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

    self.img = KIMG(@"编组 44");
    self.titleStr = @"随着奥尼尔渐渐老去，热火的战斗力出现明显下滑。";
    self.subTitleStr = @"#日职联";
    self.focusHotBtnTitleStr = @"15455";
    self.likeBtnTitleStr = @"1218";
    
    self.imageView.alpha = 1;
    self.titleLab.alpha = 1;
    self.subTitleLab.alpha = 1;
    self.focusHotBtn.alpha = 1;
    self.likeBtn.alpha = 1;
}

+(CGSize)cellSizeWithModel:(id _Nullable)model{
    return CGSizeMake(MAINSCREEN_WIDTH - 11 * 2, 89);
}


#pragma mark —— lazyLoad
-(UIImageView *)imageView{
    if (!_imageView) {
        _imageView = UIImageView.new;
        _imageView.image = self.img;
        [self.contentView addSubview:_imageView];
        [_imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(92, 61));
            make.right.equalTo(self.contentView).offset(-12);
            make.top.equalTo(self.contentView).offset(14);
        }];
        [UIView cornerCutToCircleWithView:_imageView AndCornerRadius:8];
    }return _imageView;
}

-(UILabel *)titleLab{
    if (!_titleLab) {
        _titleLab = UILabel.new;
        _titleLab.font = [UIFont systemFontOfSize:13 weight:UIFontWeightMedium];
        _titleLab.textColor = HEXCOLOR(0x676973);
        _titleLab.text = self.titleStr;
        [self.contentView addSubview:_titleLab];
        [_titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.imageView);
            make.right.equalTo(self.imageView.mas_left).offset(-26);
            make.bottom.equalTo(self.imageView.mas_centerY);
            make.left.equalTo(self.contentView).offset(14);
        }];
    }return _titleLab;
}

-(UILabel *)subTitleLab{
    if (!_subTitleLab) {
        _subTitleLab = UILabel.new;
        _subTitleLab.text = self.subTitleStr;
        _subTitleLab.font = [UIFont systemFontOfSize:11 weight:UIFontWeightMedium];
        _subTitleLab.textColor = HEXCOLOR(0x4B88EC);
        [_subTitleLab sizeToFit];
        [self.contentView addSubview:_subTitleLab];
        [_subTitleLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.titleLab);
            make.bottom.equalTo(self.imageView);
        }];
    }return _subTitleLab;
}

-(UIButton *)focusHotBtn{
    if (!_focusHotBtn) {
        _focusHotBtn = UIButton.new;
        [_focusHotBtn setTitle:self.focusHotBtnTitleStr forState:UIControlStateNormal];
        [_focusHotBtn setTitleColor:HEXCOLOR(0x6E7283) forState:UIControlStateNormal];
        _focusHotBtn.titleLabel.font = [UIFont systemFontOfSize:11 weight:UIFontWeightMedium];
        [_focusHotBtn setImage:[UIImage animatedGIFNamed:@"⚽️PicResource/Gif/热度"]
                      forState:UIControlStateNormal];
        [_focusHotBtn.titleLabel sizeToFit];
        [_focusHotBtn.titleLabel adjustsFontSizeToFitWidth];
        [self.contentView addSubview:_focusHotBtn];
        [_focusHotBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(self.subTitleLab);
            make.left.equalTo(self.subTitleLab.mas_right).offset(12);
        }];
    }return _focusHotBtn;
}

-(UIButton *)likeBtn{
    if (!_likeBtn) {
        _likeBtn = UIButton.new;
        [_likeBtn setTitleColor:HEXCOLOR(0x6E7283) forState:UIControlStateNormal];
        [_likeBtn setTitle:self.likeBtnTitleStr forState:UIControlStateNormal];
        _likeBtn.titleLabel.font = [UIFont systemFontOfSize:11 weight:UIFontWeightMedium];
        [_likeBtn setImage:KBuddleIMG(@"⚽️PicResource",
                                      @"Others",
                                      nil,
                                      @"❤️")
                      forState:UIControlStateNormal];
        [_likeBtn.titleLabel sizeToFit];
        [_likeBtn.titleLabel adjustsFontSizeToFitWidth];
        [self.contentView addSubview:_likeBtn];
        [_likeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(self.subTitleLab);
            make.left.equalTo(self.focusHotBtn.mas_right).offset(12);
        }];
    }return _likeBtn;
}

@end
