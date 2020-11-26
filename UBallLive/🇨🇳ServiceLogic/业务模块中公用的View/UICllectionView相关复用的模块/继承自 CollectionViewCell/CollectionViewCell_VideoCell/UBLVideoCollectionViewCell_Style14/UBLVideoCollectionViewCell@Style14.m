//
//  UBLVideoCollectionViewCell@Style14.m
//  UBallLive
//
//  Created by Jobs on 2020/11/8.
//

#import "UBLVideoCollectionViewCell@Style14.h"

@interface UBLVideoCollectionViewCell_Style14 ()

@property(nonatomic,strong)UILabel *contentLab;
@property(nonatomic,strong)NSString *contentStr;

@end

@implementation UBLVideoCollectionViewCell_Style14

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
    self.contentStr = @"【有利】1.指数走势不俗，新赛季四场联赛指数赢下三场，真竞技状态被低估：2.近四场比赛有三次能够零封对手，进攻端的稳定性不差；3.前四轮联赛全部打出打球，近期踢法偏向大开大合；4.本赛季三场先进球的联赛中最终全部获胜，顺风球能力非常好【不利】1.初始让步韦-0的近六场比赛只赢下一次指数，同等指数下的赢指能力低下；2.最近四场赛事有三次打出大角，战术对定位球的依赖性比较大，运动战能力略差";
    self.contentLab.alpha = 1;
}

+(CGSize)cellSizeWithModel:(id _Nullable)model{
    
    NSString *sd = @"【有利】1.指数走势不俗，新赛季四场联赛指数赢下三场，真竞技状态被低估：2.近四场比赛有三次能够零封对手，进攻端的稳定性不差；3.前四轮联赛全部打出打球，近期踢法偏向大开大合；4.本赛季三场先进球的联赛中最终全部获胜，顺风球能力非常好【不利】1.初始让步韦-0的近六场比赛只赢下一次指数，同等指数下的赢指能力低下；2.最近四场赛事有三次打出大角，战术对定位球的依赖性比较大，运动战能力略差";
    CGFloat cellHeight = [NSString getContentHeightOrWidthWithParagraphStyleLineSpacing:0
                                                                  calcLabelHeight_Width:CalcLabelHeight
                                                                           effectString:sd
                                                                                   font:NULL
                                                           boundingRectWithHeight_Width:MAINSCREEN_WIDTH - 20];
    
    return CGSizeMake(MAINSCREEN_WIDTH - 12 * 2, cellHeight + 28);
}
#pragma mark —— lazyLoad
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
            make.top.equalTo(self.contentView).offset(11);
            make.left.equalTo(self.contentView).offset(14);
            make.right.equalTo(self.contentView).offset(-5);
            make.bottom.equalTo(self.contentView).offset(-13);
        }];
    }return _contentLab;
}

@end
