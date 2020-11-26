//
//  PagingViewTableHeaderView.m
//  JXCategoryView
//
//  Created by jiaxin on 2018/8/27.
//  Copyright © 2018年 jiaxin. All rights reserved.
//

#import "UBLPagingViewTableHeaderView.h"

@interface UBLPagingViewTableHeaderView()

@property(nonatomic,strong)UIImageView *imageView;
@property(nonatomic,strong)UIImageView *userHeaderIMGV;
@property(nonatomic,strong)UIImageView *userGenderIMGV;
@property(nonatomic,strong)UIButton *userClassBtn;
@property(nonatomic,strong)UIButton *userRoleBtn;
@property(nonatomic,strong)UILabel *fansLab;
@property(nonatomic,strong)FBShimmeringView *shimmeringView;
@property(nonatomic,strong)UILabel *userNameLab;
@property(nonatomic,strong)UIButton *attentionBtn;
@property(nonatomic,strong)UILabel *titleLab;
@property(nonatomic,assign)CGRect imageViewFrame;
@property(nonatomic,assign)BOOL isOK;
//data
@property(nonatomic,strong)UIImage *userHeaderIMG;
@property(nonatomic,strong)UIImage *userGenderIMG;
@property(nonatomic,strong)UIImage *userClassBgIMG;
@property(nonatomic,strong)NSString *userClassStr;
@property(nonatomic,strong)NSString *userRoleStr;
@property(nonatomic,strong)NSString *fansNumStr;
@property(nonatomic,strong)NSString *userNameStr;
@property(nonatomic,strong)NSString *titleStr;

@property(nonatomic,copy)MKDataBlock pagingViewTableHeaderViewBlock;

@end

@implementation UBLPagingViewTableHeaderView

-(instancetype)init{
    if (self = [super init]) {
//        UIVisualEffectView;
        
        self.userHeaderIMG = KIMG(@"替代头像");
        self.userGenderIMG = KBuddleIMG(@"⚽️PicResource", @"Others", @"性别", @"男_带背景图");
        self.userClassBgIMG = KBuddleIMG(@"⚽️PicResource", @"Others", @"用户等级", @"等级");
        self.userClassStr = @"Lv 33";
        self.userRoleStr = @"主播";
        self.fansNumStr = @"粉丝 1024";
        self.userNameStr = @"我的护球像亨利";
        self.titleStr = @"CCTV5足球解说，赛事解说经验丰富，场次500+，熟悉欧洲的5大赛事";
        
    }return self;
}

-(void)drawRect:(CGRect)rect{
    [super drawRect:rect];
    if (!self.isOK) {
        self.imageView.alpha = 1;
        self.userHeaderIMGV.alpha = 1;
        self.userGenderIMGV.alpha = 1;
        self.shimmeringView.alpha = 1;
        self.attentionBtn.alpha = 1;
        self.userClassBtn.alpha = 1;
        self.userRoleBtn.alpha = 1;
        self.titleLab.alpha = 1;
        self.fansLab.alpha = 1;
        self.isOK = YES;
    }
}

-(void)actionBlockPagingViewTableHeaderViewBlock:(MKDataBlock _Nullable)pagingViewTableHeaderViewBlock{
    self.pagingViewTableHeaderViewBlock = pagingViewTableHeaderViewBlock;
}

-(void)scrollViewDidScroll:(CGFloat)contentOffsetY {
    if (self.isZoom) {
        CGRect frame = self.imageViewFrame;
        frame.size.height -= contentOffsetY;
        frame.origin.y = contentOffsetY;
        
        self.imageView.frame = frame;
    }
}
#pragma mark —— lazyLoad
-(UIImageView *)imageView{
    if (!_imageView) {
        _imageView = UIImageView.new;
        _imageView.image = KBuddleIMG(@"⚽️PicResource",
                                      @"Others",
                                      nil,
                                      @"个人中心背景图");
        _imageView.clipsToBounds = YES;
        _imageView.contentMode = UIViewContentModeScaleAspectFill;
        [self addSubview:_imageView];
        if (self.isZoom) {
            _imageView.frame = CGRectMake(0,
                                          0,
                                          self.mj_w,
                                          self.mj_h);
            self.imageViewFrame = _imageView.frame;
        }else{
            [_imageView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.edges.equalTo(self);
            }];
        }
    }return _imageView;
}

-(UIImageView *)userHeaderIMGV{
    if (!_userHeaderIMGV) {
        _userHeaderIMGV = UIImageView.new;
        _userHeaderIMGV.image = KIMG(@"替代头像");
        [self addSubview:_userHeaderIMGV];
        [_userHeaderIMGV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(55, 55));
            make.left.equalTo(self).offset(14);
            make.bottom.equalTo(self).offset(-81);
        }];
        [self layoutIfNeeded];
        [UIView cornerCutToCircleWithView:_userHeaderIMGV AndCornerRadius:55 / 2];
    }return _userHeaderIMGV;
}

-(UIImageView *)userGenderIMGV{
    if (!_userGenderIMGV) {
        _userGenderIMGV = UIImageView.new;
        _userGenderIMGV.image = self.userGenderIMG;
        [self addSubview:_userGenderIMGV];
        [_userGenderIMGV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(23, 11));
            make.bottom.equalTo(self.userHeaderIMGV).offset(5);
            make.right.equalTo(self.userHeaderIMGV).offset(10);
        }];
        [UIView cornerCutToCircleWithView:_userGenderIMGV AndCornerRadius:11 / 2];
    }return _userGenderIMGV;
}

-(FBShimmeringView *)shimmeringView{
    if (!_shimmeringView) {
        _shimmeringView = [[FBShimmeringView alloc] initWithFrame:CGRectMake(self.userHeaderIMGV.mj_x + self.userHeaderIMGV.mj_w + 15,
                                                                             self.userHeaderIMGV.mj_y,
                                                                             MAINSCREEN_WIDTH - (self.userHeaderIMGV.mj_x + self.userHeaderIMGV.mj_w + 15),
                                                                             17)];
        _shimmeringView.contentView = self.userNameLab;
        _shimmeringView.shimmering = YES;
        [self addSubview:_shimmeringView];
    }return _shimmeringView;
}

-(UILabel *)userNameLab{
    if (!_userNameLab) {
        _userNameLab = UILabel.new;
        _userNameLab.textAlignment = NSTextAlignmentLeft;
        _userNameLab.textColor = kWhiteColor;
        _userNameLab.text = self.userNameStr;
        _userNameLab.font = [UIFont systemFontOfSize:12 weight:UIFontWeightMedium];
        _userNameLab.frame = self.shimmeringView.bounds;
    }return _userNameLab;
}

-(UIButton *)userClassBtn{
    if (!_userClassBtn) {
        _userClassBtn = UIButton.new;
        [_userClassBtn setTitle:self.userClassStr
                       forState:UIControlStateNormal];
        [self addSubview:_userClassBtn];
        [_userClassBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.shimmeringView);
            make.top.equalTo(self.userNameLab.mas_bottom).offset(5);
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
            make.height.mas_equalTo(15.5);
            make.centerY.equalTo(self.userClassBtn);
            make.left.equalTo(self.userClassBtn.mas_right).offset(10);
        }];
    }return _userRoleBtn;
}

-(UILabel *)fansLab{
    if (!_fansLab) {
        _fansLab = UILabel.new;
        _fansLab.text = self.fansNumStr;
        _fansLab.textColor = kWhiteColor;
        _fansLab.font = [UIFont systemFontOfSize:11 weight:UIFontWeightMedium];
        [_fansLab sizeToFit];
        [self addSubview:_fansLab];
        [_fansLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.userClassBtn);
            make.top.equalTo(self.userClassBtn.mas_bottom).offset(5);
        }];
    }return _fansLab;
}

-(UIButton *)attentionBtn{
    if (!_attentionBtn) {
        _attentionBtn = UIButton.new;
        [_attentionBtn setBackgroundImage:KBuddleIMG(@"⚽️PicResource", @"Others", @"关注", @"关注，渐变色带+号按钮") forState:UIControlStateNormal];
        [_attentionBtn setBackgroundImage:KBuddleIMG(@"⚽️PicResource", @"Others", @"关注", @"已关注，渐变色带+号按钮") forState:UIControlStateSelected];
        [[_attentionBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
            //点击事件
            x.selected = !x.selected;
            if (self.pagingViewTableHeaderViewBlock) {
                self.pagingViewTableHeaderViewBlock(x);
            }
        }];
        [self addSubview:_attentionBtn];
        [_attentionBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(84, 29));
            make.right.equalTo(self).offset(-17);
            make.bottom.equalTo(self).offset(-59);
        }];
    }return _attentionBtn;
}

-(UILabel *)titleLab{
    if (!_titleLab) {
        _titleLab = UILabel.new;
        _titleLab.textColor = kWhiteColor;
        _titleLab.text = self.titleStr;
        _titleLab.textAlignment = NSTextAlignmentCenter;
        _titleLab.font = [UIFont systemFontOfSize:10
                                           weight:UIFontWeightMedium];
        [self addSubview:_titleLab];
        [_titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self);
            make.bottom.equalTo(self).offset(-21);
        }];
    }return _titleLab;
}

@end
