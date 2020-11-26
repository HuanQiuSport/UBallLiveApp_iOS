//
//  UBLTimeCollectionReusableView.m
//  UBallLive
//
//  Created by Jobs on 2020/11/22.
//

#import "UBLTimeCollectionReusableView.h"

@interface UBLTimeCollectionReusableView ()

@property(nonatomic,strong)UILabel *timeLab;
@property(nonatomic,strong)NSString *timeStr;

@end

@implementation UBLTimeCollectionReusableView

+(CGSize)collectionReusableViewSizeWithModel:(id _Nullable)model{
    return CGSizeMake(MAINSCREEN_WIDTH - 12, 41);
}

-(void)richElementsInCellWithModel:(id _Nullable)model{
    if ([model isKindOfClass:NSString.class]) {
        self.timeStr = (NSString *)model;
        self.timeLab.alpha = 1;
    }
}
#pragma mark —— lazyLoad
-(UILabel *)timeLab{
    if (!_timeLab) {
        _timeLab = UILabel.new;
        _timeLab.text = self.timeStr;
        _timeLab.textAlignment = NSTextAlignmentCenter;
        _timeLab.font = [UIFont systemFontOfSize:12 weight:UIFontWeightMedium];
        _timeLab.backgroundColor = RGBCOLOR(127, 194, 255);
        _timeLab.textColor = RGBCOLOR(32, 140, 237);
        [self addSubview:_timeLab];
        [_timeLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(self);
            make.size.mas_equalTo(CGSizeMake(MAINSCREEN_WIDTH - 12 * 2, 21));
        }];
        [UIView cornerCutToCircleWithView:_timeLab AndCornerRadius:8];
    }return _timeLab;
}


@end
