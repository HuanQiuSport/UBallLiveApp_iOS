//
//  HotCollectionReusableView.m
//  UBallLive
//
//  Created by Jobs on 2020/10/29.
//

#import "UBLHotCollectionReusableView.h"

@interface UBLHotCollectionReusableView ()

@property(nonatomic,strong)UIImageView *IMGV;
@property(nonatomic,strong)UILabel *titleLab;
@property(nonatomic,strong)UIButton *showAllBtn;
@property(nonatomic,copy)MKDataBlock hotCollectionReusableViewBlock;

@end

@implementation UBLHotCollectionReusableView

-(void)richElementsInCellWithModel:(id _Nullable)model{
    if ([model isKindOfClass:NSDictionary.class]) {
        NSDictionary *dic = (NSDictionary *)model;
        self.titleLab.text = dic[@"titleStr"];
        self.IMGV.image = dic[@"image"];
        self.showAllBtn.alpha = [dic[@"isShowAllBtn"] boolValue];
    }
}

-(void)actionBlockHotCollectionReusableView:(MKDataBlock _Nullable)hotCollectionReusableViewBlock{
    self.hotCollectionReusableViewBlock = hotCollectionReusableViewBlock;
}

+(CGSize)collectionReusableViewSizeWithModel:(id _Nullable)model{
    return CGSizeMake(MAINSCREEN_WIDTH, 40);;
}
#pragma mark —— lazyLoad
-(UIImageView *)IMGV{
    if (!_IMGV) {
        _IMGV = UIImageView.new;
        _IMGV.image = self.image;
        [self addSubview:_IMGV];
        [_IMGV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(21, 19));
            make.centerY.equalTo(self);
            make.left.equalTo(self).offset(15);
        }];
    }return _IMGV;
}

-(UILabel *)titleLab{
    if (!_titleLab) {
        _titleLab = UILabel.new;
        _titleLab.text = self.titleStr;
        _titleLab.font = [UIFont systemFontOfSize:16
                                           weight:UIFontWeightRegular];
        [_titleLab sizeToFit];
        [self addSubview:_titleLab];
        [_titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self);
            make.left.equalTo(self.IMGV.mas_right).offset(3);
        }];
    }return _titleLab;
}

-(UIButton *)showAllBtn{
    if (!_showAllBtn) {
        _showAllBtn = UIButton.new;
        [_showAllBtn setTitle:@"查看全部"
                     forState:UIControlStateNormal];
        [_showAllBtn setTitleColor:HEXCOLOR(0x9E9E9E)
                          forState:UIControlStateNormal];
        _showAllBtn.titleLabel.font = [UIFont systemFontOfSize:13
                                                        weight:UIFontWeightMedium];
        @weakify(self)
        [[_showAllBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
            @strongify(self)
            if (self.hotCollectionReusableViewBlock) {
                self.hotCollectionReusableViewBlock(weak_self);
            }
        }];
        [self addSubview:_showAllBtn];
        [_showAllBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self);
            make.right.equalTo(self).offset(-16);
        }];
    }return _showAllBtn;
}

@end
