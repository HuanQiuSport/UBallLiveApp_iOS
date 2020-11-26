//
//  UBLVideoCollectionViewCell@Style16.m
//  UBallLive
//
//  Created by Jobs on 2020/11/8.
//

#import "UBLVideoCollectionViewCell@Style16.h"

@interface UBLVideoCollectionViewCell_Style16 (){
    CGFloat CELLWIDTH;
}

@property(nonatomic,strong)UILabel *titleLab;
@property(nonatomic,strong)UILabel *superTitleLab;
@property(nonatomic,strong)UILabel *subTitleLab;
@property(nonatomic,strong)UILabel *superTitleLab_1;
@property(nonatomic,strong)UILabel *superTitleLab_2;
@property(nonatomic,strong)UILabel *superTitleLab_3;
@property(nonatomic,strong)UILabel *subTitleLab_1;
@property(nonatomic,strong)UILabel *subTitleLab_2;
@property(nonatomic,strong)UILabel *subTitleLab_3;

@property(nonatomic,strong)NSString *titleStr;
@property(nonatomic,strong)NSString *superTitleStr;
@property(nonatomic,strong)NSString *subTitleStr;
@property(nonatomic,strong)NSString *superTitle_1_Str;
@property(nonatomic,strong)NSString *superTitle_2_Str;
@property(nonatomic,strong)NSString *superTitle_3_Str;
@property(nonatomic,strong)NSString *subTitle_1_Str;
@property(nonatomic,strong)NSString *subTitle_2_Str;
@property(nonatomic,strong)NSString *subTitle_3_Str;

@end

@implementation UBLVideoCollectionViewCell_Style16

-(void)dealloc {
    NSLog(@"Running self.class = %@;NSStringFromSelector(_cmd) = '%@';__FUNCTION__ = %s", self.class, NSStringFromSelector(_cmd),__FUNCTION__);
}

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        [UIView makeTargetShadowview:self
                           superView:nil
                     shadowDirection:ShadowDirection_All
                   shadowWithOffsetX:5
                             offsetY:5
                        cornerRadius:8
                        shadowOffset:defaultSize
                       shadowOpacity:1
                    layerShadowColor:defaultObj
                   layerShadowRadius:defaultValue];
        
        [UIView cornerCutToCircleWithView:self.contentView AndCornerRadius:8];
        
        self.backgroundColor = kWhiteColor;
        self.contentView.backgroundColor = kWhiteColor;
        CELLWIDTH = (MAINSCREEN_WIDTH - 13 * 2 - 83.5 - 10) / 4;
        
    }return self;
}

-(void)richElementsInCellWithModel:(id _Nullable)model{

    if (self.idxPath.section == 0) {
        self.titleStr = @"最高值";
    }else if(self.idxPath.section == 1){
        self.titleStr = @"最低值";
    }else if(self.idxPath.section == 2){
        self.titleStr = @"平均值";
    }else{
        self.titleStr = @"Bet365";
    }
    
    self.superTitleStr = @"初盘";
    self.subTitleStr = @"即时盘";
    self.superTitle_1_Str = @"0.39";
    self.superTitle_2_Str = @"12";
    self.superTitle_3_Str = @"0.02";
    self.subTitle_1_Str = @"8.5";
    self.subTitle_2_Str = @"3.5";
    self.subTitle_3_Str = @"5.5";

    self.titleLab.alpha = 1;
    self.superTitleLab.alpha = 1;
    self.subTitleLab.alpha = 1;
    self.superTitleLab_1.alpha = 1;
    self.superTitleLab_2.alpha = 1;
    self.superTitleLab_3.alpha = 1;
    self.subTitleLab_1.alpha = 1;
    self.subTitleLab_2.alpha = 1;
    self.subTitleLab_3.alpha = 1;
}

+(CGSize)cellSizeWithModel:(id _Nullable)model{
    return CGSizeMake(MAINSCREEN_WIDTH - 13 * 2, 63);
}
#pragma mark —— lazyLoad
-(UILabel *)titleLab{
    if (!_titleLab) {
        _titleLab = UILabel.new;
        _titleLab.textAlignment= NSTextAlignmentCenter;
        _titleLab.textColor = HEXCOLOR(0x464646);
        _titleLab.text = self.titleStr;
        _titleLab.font = [UIFont systemFontOfSize:11 weight:UIFontWeightRegular];
        [self addSubview:_titleLab];
        [_titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(83.5);
            make.top.bottom.equalTo(self.contentView);
            make.left.equalTo(self.contentView).offset(-1);
        }];
    }return _titleLab;
}

-(UILabel *)superTitleLab{
    if (!_superTitleLab) {
        _superTitleLab = UILabel.new;
        _superTitleLab.textAlignment= NSTextAlignmentCenter;
        _superTitleLab.textColor = HEXCOLOR(0x999999);
        _superTitleLab.text = self.superTitleStr;
        _superTitleLab.font = [UIFont systemFontOfSize:11 weight:UIFontWeightRegular];
        [self.contentView addSubview:_superTitleLab];
        [_superTitleLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(CELLWIDTH);
            make.bottom.equalTo(self.contentView.mas_centerY);
            make.top.equalTo(self.contentView);
            make.left.equalTo(self.titleLab.mas_right);
        }];
        [UIView colourToLayerOfView:_superTitleLab WithColour:HEXCOLOR(0xF0F0F0) AndBorderWidth:1];
    }return _superTitleLab;
}

-(UILabel *)subTitleLab{
    if (!_subTitleLab) {
        _subTitleLab = UILabel.new;
        _subTitleLab.textAlignment= NSTextAlignmentCenter;
        _subTitleLab.textColor = HEXCOLOR(0x464646);
        _subTitleLab.font = [UIFont systemFontOfSize:11 weight:UIFontWeightRegular];
        _subTitleLab.text = self.subTitleStr;
        [self.contentView addSubview:_subTitleLab];
        [_subTitleLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(CELLWIDTH);
            make.top.equalTo(self.contentView.mas_centerY);
            make.bottom.equalTo(self.contentView);
            make.left.equalTo(self.titleLab.mas_right);
        }];
        [UIView colourToLayerOfView:_subTitleLab WithColour:HEXCOLOR(0xF0F0F0) AndBorderWidth:1];
    }return _subTitleLab;
}

-(UILabel *)superTitleLab_1{
    if (!_superTitleLab_1) {
        _superTitleLab_1 = UILabel.new;
        _superTitleLab_1.textAlignment= NSTextAlignmentCenter;
        _superTitleLab_1.text = self.superTitle_1_Str;
        [self.contentView addSubview:_superTitleLab_1];
        [_superTitleLab_1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.superTitleLab.mas_right);
            make.width.mas_equalTo(CELLWIDTH);
            make.bottom.equalTo(self.contentView.mas_centerY);
            make.top.equalTo(self.contentView);
        }];
        [UIView colourToLayerOfView:_superTitleLab_1 WithColour:HEXCOLOR(0xF0F0F0) AndBorderWidth:1];
    }return _superTitleLab_1;
}

-(UILabel *)superTitleLab_2{
    if (!_superTitleLab_2) {
        _superTitleLab_2 = UILabel.new;
        _superTitleLab_2.textAlignment= NSTextAlignmentCenter;
        _superTitleLab_2.textColor = HEXCOLOR(0x000000);
        _superTitleLab_2.text = self.superTitle_2_Str;
        [self.contentView addSubview:_superTitleLab_2];
        [_superTitleLab_2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.superTitleLab_1.mas_right);
            make.width.mas_equalTo(CELLWIDTH);
            make.bottom.equalTo(self.contentView.mas_centerY);
            make.top.equalTo(self.contentView);
        }];
        [UIView colourToLayerOfView:_superTitleLab_2 WithColour:HEXCOLOR(0xF0F0F0) AndBorderWidth:1];
    }return _superTitleLab_2;
}

-(UILabel *)superTitleLab_3{
    if (!_superTitleLab_3) {
        _superTitleLab_3 = UILabel.new;
        _superTitleLab_3.textAlignment= NSTextAlignmentCenter;
        _superTitleLab_3.textColor = HEXCOLOR(0x000000);
        _superTitleLab_3.text = self.superTitle_3_Str;
        [self.contentView addSubview:_superTitleLab_3];
        [_superTitleLab_3 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.superTitleLab_2.mas_right);
            make.right.equalTo(self.contentView).offset(1);
            make.bottom.equalTo(self.contentView.mas_centerY);
            make.top.equalTo(self.contentView);
        }];
        [UIView colourToLayerOfView:_superTitleLab_3 WithColour:HEXCOLOR(0xF0F0F0) AndBorderWidth:1];
    }return _superTitleLab_3;
}

-(UILabel *)subTitleLab_1{
    if (!_subTitleLab_1) {
        _subTitleLab_1 = UILabel.new;
        _subTitleLab_1.textAlignment= NSTextAlignmentCenter;
        _subTitleLab_1.text = self.subTitle_1_Str;
        _subTitleLab_1.textColor = HEXCOLOR(0xFF3434);
        [self.contentView addSubview:_subTitleLab_1];
        [_subTitleLab_1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(CELLWIDTH);
            make.top.equalTo(self.contentView.mas_centerY);
            make.bottom.equalTo(self.contentView);
            make.left.equalTo(self.subTitleLab.mas_right);
        }];
        [UIView colourToLayerOfView:_subTitleLab_1 WithColour:HEXCOLOR(0xF0F0F0) AndBorderWidth:1];
    }return _subTitleLab_1;
}

-(UILabel *)subTitleLab_2{
    if (!_subTitleLab_2) {
        _subTitleLab_2 = UILabel.new;
        _subTitleLab_2.textAlignment= NSTextAlignmentCenter;
        _subTitleLab_2.text = self.subTitle_2_Str;
        _subTitleLab_2.textColor = HEXCOLOR(0xFF3434);
        [self.contentView addSubview:_subTitleLab_2];
        [_subTitleLab_2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(CELLWIDTH);
            make.top.equalTo(self.contentView.mas_centerY);
            make.bottom.equalTo(self.contentView);
            make.left.equalTo(self.subTitleLab_1.mas_right);
        }];
        [UIView colourToLayerOfView:_subTitleLab_2 WithColour:HEXCOLOR(0xF0F0F0) AndBorderWidth:1];
    }return _subTitleLab_2;
}

-(UILabel *)subTitleLab_3{
    if (!_subTitleLab_3) {
        _subTitleLab_3 = UILabel.new;
        _subTitleLab_3.textAlignment= NSTextAlignmentCenter;
        _subTitleLab_3.text = self.subTitle_3_Str;
        _subTitleLab_3.textColor = HEXCOLOR(0x17BE2C);
        [self.contentView addSubview:_subTitleLab_3];
        [_subTitleLab_3 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.contentView).offset(1);
            make.top.equalTo(self.contentView.mas_centerY);
            make.bottom.equalTo(self.contentView);
            make.left.equalTo(self.subTitleLab_2.mas_right);
        }];
        [UIView colourToLayerOfView:_subTitleLab_3 WithColour:HEXCOLOR(0xF0F0F0) AndBorderWidth:1];
    }return _subTitleLab_3;
}

@end
