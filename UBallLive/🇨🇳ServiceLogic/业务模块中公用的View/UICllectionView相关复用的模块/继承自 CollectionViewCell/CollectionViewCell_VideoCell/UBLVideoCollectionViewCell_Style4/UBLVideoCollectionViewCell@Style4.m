//
//  VideoCollectionViewCell_Style4.m
//  UBallLive
//
//  Created by Jobs on 2020/10/20.
//

#import "UBLVideoCollectionViewCell@Style4.h"
#import "UBLMyAdCell.h"

@interface UBLVideoCollectionViewCell_Style4 ()

@property(nonatomic,strong)NSMutableArray <UIImage *>*imgDataMutArr;
@property(nonatomic,strong)WMZBannerParam *param;
@property(nonatomic,strong)WMZBannerView *bannerView;

@end

@implementation UBLVideoCollectionViewCell_Style4

-(void)dealloc {
    NSLog(@"Running self.class = %@;NSStringFromSelector(_cmd) = '%@';__FUNCTION__ = %s", self.class, NSStringFromSelector(_cmd),__FUNCTION__);
}

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = kClearColor;
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
        
    }return self;
}

-(void)richElementsInCellWithModel:(id _Nullable)model{
    self.bannerView.alpha = 1;
}

+(CGSize)cellSizeWithModel:(id _Nullable)model{
    return CGSizeMake(MAINSCREEN_WIDTH - 12 * 2, 143);;
}
#pragma mark —— lazyLoad
-(WMZBannerParam *)param{
    if (!_param) {
        _param = BannerParam()
        //    .wEventDidScrollSet(^(long contentoffet) {
        //        NSLog(@"%ld",contentoffet);
        //    })
        //自定义视图必传
        .wMyCellClassNameSet(@"UBLMyAdCell")//注册®️
        .wMyCellSet(^UICollectionViewCell *(NSIndexPath *indexPath,
                                            UICollectionView *collectionView,
                                            id model,
                                            UIImageView *bgImageView,
                                            NSArray*dataArr) {
                   //自定义视图
            UBLMyAdCell *cell = (UBLMyAdCell *)[collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([UBLMyAdCell class]) forIndexPath:indexPath];
            cell.icon.image = model;
            return cell;
        })
        .wFrameSet(CGRectMake(0,
                              0,
                              MAINSCREEN_WIDTH - 12 * 2,
                              143))
        .wDataSet(@[])
        //自定义图片圆角
        .wCustomImageRadioSet(5)
        //开启循环滚动
        .wRepeatSet(YES)
        //设置item的间距
        //    .wLineSpacingSet(10)
        //开启自动滚动
        .wAutoScrollSet(YES)
        //自动滚动时间
        .wAutoScrollSecondSet(3);
        _param.wDataSet(self.imgDataMutArr);
    }return _param;
}

-(WMZBannerView *)bannerView{
    if (!_bannerView) {
        _bannerView = [[WMZBannerView alloc] initConfigureWithModel:self.param];
        [UIView cornerCutToCircleWithView:_bannerView AndCornerRadius:5];
        [self.contentView addSubview:_bannerView];
    }return _bannerView;
}

-(NSMutableArray<UIImage *> *)imgDataMutArr{
    if (!_imgDataMutArr) {
        _imgDataMutArr = NSMutableArray.array;
        [_imgDataMutArr addObject:KBuddleIMG(@"⚽️PicResource", @"广告轮播图", nil, @"ad_1")];
        [_imgDataMutArr addObject:KBuddleIMG(@"⚽️PicResource", @"广告轮播图", nil, @"ad_2")];
        [_imgDataMutArr addObject:KBuddleIMG(@"⚽️PicResource", @"广告轮播图", nil, @"ad_3")];
        [_imgDataMutArr addObject:KBuddleIMG(@"⚽️PicResource", @"广告轮播图", nil, @"ad_4")];
    }return _imgDataMutArr;
}


@end
