//
//  AllCollectionReusableView.m
//  UBallLive
//
//  Created by Jobs on 2020/10/29.
//

#import "UBLAllCollectionReusableView.h"

@interface UBLAllCollectionReusableView ()

@property(nonatomic,strong)UIImageView *IMGV;
@property(nonatomic,strong)UILabel *titleLab;
@property(nonatomic,strong)UIImage *image;
@property(nonatomic,strong)NSString *titleStr;
@property(nonatomic,copy)MKDataBlock allCollectionReusableViewBlock;

@end

@implementation UBLAllCollectionReusableView

-(void)actionBlockAllCollectionReusableView:(MKDataBlock _Nullable)allCollectionReusableViewBlock{
    self.allCollectionReusableViewBlock = allCollectionReusableViewBlock;
}

+(CGSize)collectionReusableViewSizeWithModel:(id _Nullable)model{
    return CGSizeMake(MAINSCREEN_WIDTH, 40);
}

-(void)richElementsInCellWithModel:(id _Nullable)model{
    if ([model isKindOfClass:NSDictionary.class]) {
        NSDictionary *dic = (NSDictionary *)model;
        self.image = dic[@"image"];
        self.titleStr = dic[@"titleStr"];
        self.IMGV.alpha = 1;
        self.titleLab.alpha = 1;
    }
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


@end
