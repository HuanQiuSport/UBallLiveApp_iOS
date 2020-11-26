//
//  UBLMatchIndexCollectionReusableView.m
//  UBallLive
//
//  Created by Jobs on 2020/11/8.
//

#import "UBLMatchIndexCollectionReusableView.h"

@interface UBLMatchIndexCollectionReusableView ()

@property(nonatomic,strong)UIImageView *IMGV;
@property(nonatomic,assign)BOOL isOK;

@end

@implementation UBLMatchIndexCollectionReusableView

-(void)drawRect:(CGRect)rect{
    [super drawRect:rect];
    if (!self.isOK) {
        self.IMGV.alpha = 1;
        self.isOK = YES;
    }
}

+(CGSize)collectionReusableViewSizeWithModel:(id _Nullable)model{
    return CGSizeMake(MAINSCREEN_WIDTH, 28);
}

-(void)richElementsInCellWithModel:(id _Nullable)model{
    self.IMGV.alpha = 1;
}
#pragma mark —— lazyLoad
-(UIImageView *)IMGV{
    if (!_IMGV) {
        _IMGV = UIImageView.new;
        [self addSubview:_IMGV];
        switch (self.indexType) {
            case MatchIndexType_EuropeanOdds:{
                _IMGV.image = KIMG(@"公司_主胜_平局_客胜");
                [_IMGV mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.top.equalTo(self).offset(5);
                    make.bottom.equalTo(self).offset(-5);
                    make.left.equalTo(self).offset(40);
                    make.right.equalTo(self).offset(-40);
                }];
            }break;
            case MatchIndexType_Ball:{
                _IMGV.image = KIMG(@"公司_初盘_即时盘");
                [_IMGV mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.top.equalTo(self).offset(5);
                    make.bottom.equalTo(self).offset(-5);
                    make.left.equalTo(self).offset(60);
                    make.right.equalTo(self).offset(-60);
                }];
            }break;
            default:
                break;
        }
    }return _IMGV;
}

@end
