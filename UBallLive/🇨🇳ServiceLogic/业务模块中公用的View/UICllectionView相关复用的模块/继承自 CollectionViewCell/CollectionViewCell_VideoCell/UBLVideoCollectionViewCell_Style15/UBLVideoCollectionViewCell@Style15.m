//
//  UBLVideoCollectionViewCell@Style15.m
//  UBallLive
//
//  Created by Jobs on 2020/11/8.
//

#import "UBLVideoCollectionViewCell@Style15.h"

@interface UBLVideoCollectionViewCell_Style15 (){
    CGFloat CELLWIDTH;
}
//数据来源
@property(nonatomic,strong)UILabel *titleLab;
//初盘
@property(nonatomic,strong)UILabel *primaryLab1;
@property(nonatomic,strong)UILabel *primaryLab2;
@property(nonatomic,strong)UILabel *primaryLab3;
//即时盘
@property(nonatomic,strong)UILabel *immediateLab1;
@property(nonatomic,strong)UILabel *immediateLab2;
@property(nonatomic,strong)UILabel *immediateLab3;
//竖型分割线
@property(nonatomic,strong)UILabel *separateLab1;
@property(nonatomic,strong)UILabel *separateLab2;
//向右👉箭头
@property(nonatomic,strong)UIImageView *arrowIMGV;
//data
@property(nonatomic,strong)NSString *titleStr;
@property(nonatomic,strong)NSString *primaryStr1;
@property(nonatomic,strong)NSString *primaryStr2;
@property(nonatomic,strong)NSString *primaryStr3;
@property(nonatomic,strong)NSString *immediateStr1;
@property(nonatomic,strong)NSString *immediateStr2;
@property(nonatomic,strong)NSString *immediateStr3;

@end

@implementation UBLVideoCollectionViewCell_Style15

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
        CELLWIDTH = (MAINSCREEN_WIDTH - 13 * 2 - 60.5 - 10) / 6;
        
    }return self;
}

-(void)richElementsInCellWithModel:(id _Nullable)model{
    
    self.titleStr = @"Bet365";
    self.primaryStr1 = @"0.75";
    self.primaryStr2 = @"0.76";
    self.primaryStr3 = @"0.77";
    self.immediateStr1 = @"2.6";
    self.immediateStr2 = @"2.4";
    self.immediateStr3 = @"2.7";
    
    self.titleLab.alpha = 1;
    self.separateLab1.alpha = 1;
    self.primaryLab1.alpha = 1;
    self.primaryLab2.alpha = 1;
    self.primaryLab3.alpha = 1;
    self.separateLab2.alpha = 1;
    self.immediateLab1.alpha = 1;
    self.immediateLab2.alpha = 1;
    self.immediateLab3.alpha = 1;
    self.arrowIMGV.alpha = 1;
}

+(CGSize)cellSizeWithModel:(id _Nullable)model{
    return CGSizeMake(MAINSCREEN_WIDTH - 13 * 2, 35);
}
#pragma mark —— lazyLoad
-(UILabel *)titleLab{
    if (!_titleLab) {
        _titleLab = UILabel.new;
        _titleLab.text = self.titleStr;
        _titleLab.textAlignment = NSTextAlignmentCenter;
        _titleLab.font = [UIFont systemFontOfSize:11 weight:UIFontWeightRegular];
        _titleLab.textColor = HEXCOLOR(0x464646);
        [self.contentView addSubview:_titleLab];
        [_titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.bottom.equalTo(self.contentView);
            make.width.mas_equalTo(60.5);
        }];
    }return _titleLab;
}

-(UILabel *)separateLab1{
    if (!_separateLab1) {
        _separateLab1 = UILabel.new;
        _separateLab1.backgroundColor = HEXCOLOR(0xF2F2F2);
        [self.contentView addSubview:_separateLab1];
        [_separateLab1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.titleLab.mas_right);
            make.width.mas_equalTo(1);
            make.top.equalTo(self.contentView).offset(1);
            make.bottom.equalTo(self.contentView).offset(-1);
        }];
    }return _separateLab1;
}

-(UILabel *)primaryLab1{
    if (!_primaryLab1) {
        _primaryLab1 = UILabel.new;
        _primaryLab1.text = self.primaryStr1;
        _primaryLab1.textColor = HEXCOLOR(0x999999);
        _primaryLab1.font = [UIFont systemFontOfSize:11 weight:UIFontWeightRegular];
        _primaryLab1.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:_primaryLab1];
        [_primaryLab1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(self.contentView);
            make.left.equalTo(self.separateLab1.mas_right);
            make.width.mas_equalTo(CELLWIDTH);
        }];
    }return _primaryLab1;
}

-(UILabel *)primaryLab2{
    if (!_primaryLab2) {
        _primaryLab2 = UILabel.new;
        _primaryLab2.text = self.primaryStr2;
        _primaryLab2.textColor = HEXCOLOR(0x999999);
        _primaryLab2.font = [UIFont systemFontOfSize:11 weight:UIFontWeightRegular];
        _primaryLab2.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:_primaryLab2];
        [_primaryLab2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(self.contentView);
            make.left.equalTo(self.primaryLab1.mas_right);
            make.width.mas_equalTo(CELLWIDTH);
        }];
    }return _primaryLab2;
}

-(UILabel *)primaryLab3{
    if (!_primaryLab3) {
        _primaryLab3 = UILabel.new;
        _primaryLab3.text = self.primaryStr3;
        _primaryLab3.textColor = HEXCOLOR(0x999999);
        _primaryLab3.font = [UIFont systemFontOfSize:11 weight:UIFontWeightRegular];
        _primaryLab3.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:_primaryLab3];
        [_primaryLab3 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(self.contentView);
            make.left.equalTo(self.primaryLab2.mas_right);
            make.width.mas_equalTo(CELLWIDTH);
        }];
    }return _primaryLab3;
}

-(UILabel *)separateLab2{
    if (!_separateLab2) {
        _separateLab2 = UILabel.new;
        _separateLab2.backgroundColor = HEXCOLOR(0xF2F2F2);
        [self.contentView addSubview:_separateLab2];
        [_separateLab2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(self.contentView);
            make.left.equalTo(self.primaryLab3.mas_right);
            make.width.mas_equalTo(1);
        }];
    }return _separateLab2;
}

-(UILabel *)immediateLab1{
    if (!_immediateLab1) {
        _immediateLab1 = UILabel.new;
        _immediateLab1.text = self.immediateStr1;
        _immediateLab1.textAlignment = NSTextAlignmentCenter;
        _immediateLab1.font = [UIFont systemFontOfSize:11 weight:UIFontWeightRegular];
        [self.contentView addSubview:_immediateLab1];
        [_immediateLab1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(self.contentView);
            make.left.equalTo(self.separateLab2.mas_right);
            make.width.mas_equalTo(CELLWIDTH);
        }];
    }return _immediateLab1;
}

-(UILabel *)immediateLab2{
    if (!_immediateLab2) {
        _immediateLab2 = UILabel.new;
        _immediateLab2.text = self.immediateStr2;
        _immediateLab2.textAlignment = NSTextAlignmentCenter;
        _immediateLab2.font = [UIFont systemFontOfSize:11 weight:UIFontWeightRegular];
        [self.contentView addSubview:_immediateLab2];
        [_immediateLab2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(self.contentView);
            make.left.equalTo(self.immediateLab1.mas_right);
            make.width.mas_equalTo(CELLWIDTH);
        }];
    }return _immediateLab2;
}

-(UILabel *)immediateLab3{
    if (!_immediateLab3) {
        _immediateLab3 = UILabel.new;
        _immediateLab3.text = self.immediateStr3;
        _immediateLab3.textAlignment = NSTextAlignmentCenter;
        _immediateLab3.font = [UIFont systemFontOfSize:11 weight:UIFontWeightRegular];
        [self.contentView addSubview:_immediateLab3];
        [_immediateLab3 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(self.contentView);
            make.left.equalTo(self.immediateLab2.mas_right);
            make.width.mas_equalTo(CELLWIDTH);
        }];
    }return _immediateLab3;
}

-(UIImageView *)arrowIMGV{
    if (!_arrowIMGV) {
        _arrowIMGV = UIImageView.new;
        _arrowIMGV.image = KIMG(@"WhiteRightArrow");
        [self.contentView addSubview:_arrowIMGV];
        [_arrowIMGV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.immediateLab3);
            make.right.equalTo(self).offset(-3);
            make.size.mas_equalTo(CGSizeMake(7, 9.6));
        }];
    }return _arrowIMGV;
}

@end
