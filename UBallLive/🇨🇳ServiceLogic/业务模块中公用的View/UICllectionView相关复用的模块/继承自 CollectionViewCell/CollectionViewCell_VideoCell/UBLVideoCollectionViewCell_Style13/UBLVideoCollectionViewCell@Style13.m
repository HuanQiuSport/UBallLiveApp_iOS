//
//  UBLVideoCollectionViewCell@Style13.m
//  UBallLive
//
//  Created by Jobs on 2020/11/8.
//

#import "UBLVideoCollectionViewCell@Style13.h"

@interface UBLVideoCollectionViewCell_Style13 ()

@property(nonatomic,strong)UILabel *titleLab;
@property(nonatomic,strong)UILabel *separateLab;
@property(nonatomic,strong)UILabel *contentLab;
@property(nonatomic,strong)NSString *contentStr;

@end

@implementation UBLVideoCollectionViewCell_Style13

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

    self.contentStr = @"罗达JC上轮在主场4:0大胜多德勒支，本赛季再次赢下指数。\n罗达JC主帅斯特雷佩尔执教生涯11次对阵因霍温FC取得6胜4平1负的优势战绩，\n 罗达JC本赛季四轮联赛场场出大，其中三场可以零封对手赢球，";
    self.titleLab.alpha = 1;
    self.contentLab.alpha = 1;
    self.separateLab.alpha = 1;
}

+(CGSize)cellSizeWithModel:(id _Nullable)model{
    
    NSString *sd = @"罗达JC上轮在主场4:0大胜多德勒支，本赛季再次赢下指数。\n罗达JC主帅斯特雷佩尔执教生涯11次对阵因霍温FC取得6胜4平1负的优势战绩，\n 罗达JC本赛季四轮联赛场场出大，其中三场可以零封对手赢球，";
    CGFloat cellHeight = [NSString getContentHeightOrWidthWithParagraphStyleLineSpacing:0
                                                                  calcLabelHeight_Width:CalcLabelHeight
                                                                           effectString:sd
                                                                                   font:[UIFont systemFontOfSize:13 weight:UIFontWeightRegular]
                                                           boundingRectWithHeight_Width:MAINSCREEN_WIDTH - 20];
    
    return CGSizeMake(MAINSCREEN_WIDTH - 12 * 2, cellHeight + 28 + 32);
}
#pragma mark —— lazyLoad
-(UILabel *)titleLab{
    if (!_titleLab) {
        _titleLab = UILabel.new;
        _titleLab.font = [UIFont systemFontOfSize:16 weight:UIFontWeightRegular];
        switch (self.intelligenceType) {
            case IntelligenceTypeAdvantage:{
                _titleLab.text = @"有利情报";
                _titleLab.textColor = HEXCOLOR(0x4B88EC);
            }break;
            case IntelligenceTypeDisadvantage:{
                _titleLab.text = @"不利情报";
                _titleLab.textColor = HEXCOLOR(0xFF3434);
            }break;
            case IntelligenceTypeNeutrality:{
                _titleLab.text = @"中立情报";
                _titleLab.textColor = HEXCOLOR(0x464646);
            }break;
            default:
                break;
        }
        [_titleLab sizeToFit];
        [self.contentView addSubview:_titleLab];
        [_titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView).offset(9);
            make.top.equalTo(self.contentView).offset(6);
        }];
    }return _titleLab;
}

-(UILabel *)separateLab{
    if (!_separateLab) {
        _separateLab = UILabel.new;
        [self.contentView addSubview:_separateLab];
        [_separateLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(1);
            make.left.right.equalTo(self.contentView);
            make.top.equalTo(self.titleLab.mas_bottom).offset(-4);
        }];
    }return _separateLab;
}

-(UILabel *)contentLab{
    if (!_contentLab) {
        _contentLab = UILabel.new;
        _contentLab.text = self.contentStr;
        _contentLab.numberOfLines = 0;
        _contentLab.textColor = kBlackColor;
        _contentLab.font = [UIFont systemFontOfSize:13 weight:UIFontWeightRegular];
        [_contentLab sizeToFit];
        [self.contentView addSubview:_contentLab];
        [_contentLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.separateLab).offset(9);
            make.left.equalTo(self.contentView).offset(14);
            make.right.equalTo(self.contentView).offset(-5);
            make.bottom.equalTo(self.contentView).offset(-13);
        }];
    }return _contentLab;
}


@end
