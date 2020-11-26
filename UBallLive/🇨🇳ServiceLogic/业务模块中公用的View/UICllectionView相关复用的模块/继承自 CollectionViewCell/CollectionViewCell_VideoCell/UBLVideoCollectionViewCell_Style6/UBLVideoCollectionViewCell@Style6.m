//
//  UBLVideoCollectionViewCell@Style6.m
//  UBallLive
//
//  Created by Jobs on 2020/10/30.
//

#import "UBLVideoCollectionViewCell@Style6.h"

@interface UBLVideoCollectionViewCell_Style6 ()

@property(nonatomic,strong)UILabel *idxLab;
@property(nonatomic,strong)UILabel *titleLab;

@property(nonatomic,strong)NSIndexPath *indexPath;
@property(nonatomic,strong)NSString *titleStr;
@property(nonatomic,strong)UIColor *idxBgCor;

@end

@implementation UBLVideoCollectionViewCell_Style6

-(void)dealloc {
    NSLog(@"Running self.class = %@;NSStringFromSelector(_cmd) = '%@';__FUNCTION__ = %s", self.class, NSStringFromSelector(_cmd),__FUNCTION__);
}

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {

    }return self;
}

-(void)richElementsInCellWithModel:(id _Nullable)model{
    self.backgroundColor = kWhiteColor;
    if ([model isKindOfClass:NSDictionary.class]) {
        NSDictionary *dic = (NSDictionary *)model;
        self.indexPath = dic[@"indexPath"];
        self.titleStr = dic[@"titleStr"];
        
        self.idxLab.alpha = 1;
        self.titleLab.alpha = 1;
    }
}

+(CGSize)cellSizeWithModel:(id _Nullable)model{
    return CGSizeMake(72 + 14 + 9, 14);//4;
}
#pragma mark —— lazyLoad
-(UILabel *)idxLab{
    if (!_idxLab) {
        _idxLab = UILabel.new;
        _idxLab.backgroundColor = self.idxBgCor;
        _idxLab.font = [UIFont systemFontOfSize:12
                                         weight:UIFontWeightMedium];
        _idxLab.text = [NSString stringWithFormat:@"%ld",(long)self.indexPath.row + 1];
        _idxLab.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:_idxLab];
        [_idxLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(14, 14));
            make.centerY.equalTo(self.contentView);
            make.left.equalTo(self.contentView).offset(2);
        }];
        [UIView cornerCutToCircleWithView:_idxLab AndCornerRadius:2];
    }return _idxLab;
}

-(UILabel *)titleLab{
    if (!_titleLab) {
        _titleLab = UILabel.new;
        _titleLab.textColor = HEXCOLOR(0x575A65);
        _titleLab.text = self.titleStr;
        _titleLab.font = [UIFont systemFontOfSize:11
                                           weight:UIFontWeightRegular];
        [_titleLab sizeToFit];
        [self.contentView addSubview:_titleLab];
        [_titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.contentView);
            make.left.equalTo(self.idxLab.mas_right).offset(9);
        }];
    }return _titleLab;
}

-(UIColor *)idxBgCor{
    if (!_idxBgCor) {
        switch (self.indexPath.row) {
            case 0:{
                _idxBgCor = RGBCOLOR(251, 57, 62);
            }break;
            case 1:{
                _idxBgCor = RGBCOLOR(255, 125, 45);
            }break;
            case 2:{
                _idxBgCor = RGBCOLOR(255, 178, 62);
            }break;
            default:{
                _idxBgCor = RGBCOLOR(187, 187, 187);
            }break;
        }
    }return _idxBgCor;
}

@end
