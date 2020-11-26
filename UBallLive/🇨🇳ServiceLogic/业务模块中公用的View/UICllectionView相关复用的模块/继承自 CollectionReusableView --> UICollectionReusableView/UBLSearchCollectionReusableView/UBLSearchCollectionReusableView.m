//
//  UBLSearchCollectionReusableView.m
//  UBallLive
//
//  Created by Jobs on 2020/10/30.
//

#import "UBLSearchCollectionReusableView.h"

@interface UBLSearchCollectionReusableView ()

@property(nonatomic,assign)BOOL isOK;
@property(nonatomic,strong)UIImageView *imgv;
@property(nonatomic,strong)UILabel *titleLab;
@property(nonatomic,strong)UIButton *moreBtn;
@property(nonatomic,copy)MKDataBlock searchCollectionReusableViewBlock;

@end

@implementation UBLSearchCollectionReusableView

-(void)actionBlockSearchCollectionReusableView:(MKDataBlock _Nullable)searchCollectionReusableViewBlock{
    self.searchCollectionReusableViewBlock = searchCollectionReusableViewBlock;
}

+(CGSize)collectionReusableViewSizeWithModel:(id _Nullable)model{
    return CGSizeMake(MAINSCREEN_WIDTH, 40);;
}

-(void)richElementsInCellWithModel:(id _Nullable)model{
    if ([model isKindOfClass:NSDictionary.class]) {
        NSDictionary *dic = (NSDictionary *)model;
        self.img = dic[@"img"];
        self.titleStr = dic[@"titleStr"];
        self.isShowMoreBtn = [dic[@"isShowMoreBtn"] boolValue];
        
        if (self.img) {
            self.imgv.alpha = 1;
        }
        self.titleLab.alpha = 1;
        self.moreBtn.alpha = self.isShowMoreBtn;
    }
}
#pragma mark —— lazyLoad
-(UIImageView *)imgv{
    if (!_imgv) {
        _imgv = UIImageView.new;
        _imgv.image = self.img;
        [self addSubview:_imgv];
        [_imgv mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self);
            make.left.equalTo(self).offset(13);
            make.size.mas_equalTo(CGSizeMake(21, 19));
        }];
    }return _imgv;
}

-(UILabel *)titleLab{
    if (!_titleLab) {
        _titleLab = UILabel.new;
        _titleLab.text = self.titleStr;
        _titleLab.textColor = HEXCOLOR(0x464646);
        if (self.img) {
            _titleLab.font = [UIFont systemFontOfSize:16
                                               weight:UIFontWeightRegular];
        }else{
            _titleLab.font = [UIFont systemFontOfSize:14
                                               weight:UIFontWeightRegular];
        }
        [self addSubview:_titleLab];
        [_titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self);
            if (self.img) {
                make.left.equalTo(self.imgv.mas_right).offset(3);
            }else{
                make.left.equalTo(self).offset(10);
            }
        }];
    }return _titleLab;
}

-(UIButton *)moreBtn{
    if (!_moreBtn) {
        _moreBtn = UIButton.new;
        [_moreBtn setTitle:@"更多" forState:UIControlStateNormal];
        [_moreBtn setTitleColor:HEXCOLOR(0x9E9E9E) forState:UIControlStateNormal];
        _moreBtn.titleLabel.font = [UIFont systemFontOfSize:13 weight:UIFontWeightMedium];
        [_moreBtn.titleLabel sizeToFit];
        [_moreBtn.titleLabel adjustsFontSizeToFitWidth];
        [[_moreBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
            //点击事件
            if (self.searchCollectionReusableViewBlock) {
                self.searchCollectionReusableViewBlock(x);
            }
        }];
        [self addSubview:_moreBtn];
        [_moreBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self);
            make.right.equalTo(self).offset(-13);
        }];
    }return _moreBtn;
}

@end
