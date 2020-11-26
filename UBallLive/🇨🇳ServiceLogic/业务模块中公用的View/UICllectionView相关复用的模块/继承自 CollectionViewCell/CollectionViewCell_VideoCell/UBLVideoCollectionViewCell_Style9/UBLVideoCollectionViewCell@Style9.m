//
//  UBLVideoCollectionViewCell@Style9.m
//  UBallLive
//
//  Created by Jobs on 2020/10/31.
//

#import "UBLVideoCollectionViewCell@Style9.h"
#import "KFZShopCatoryFlowLayput.h"

@interface UBLVideoCollectionViewCell_Style9 ()
<
UICollectionViewDataSource,
UICollectionViewDelegate,
UICollectionViewDelegateFlowLayout
>

@property(nonatomic,strong)UILabel *titleLab;
@property(nonatomic,strong)UICollectionView *collectionView;
@property(nonatomic,strong)UILabel *subTitleLab;
@property(nonatomic,strong)UIButton *focusHotBtn;//🔥
@property(nonatomic,strong)UIButton *likeBtn;//❤️
//data
@property(nonatomic,strong)UIColor *bgCor;
@property(nonatomic,strong)UICollectionViewFlowLayout *layout;
@property(nonatomic,strong)NSString *titleStr;
@property(nonatomic,strong)NSString *subTitleStr;
@property(nonatomic,strong)NSString *focusHotTitleStr;
@property(nonatomic,strong)NSString *likeBtnTitleStr;

@end

@implementation UBLVideoCollectionViewCell_Style9

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

    self.titleStr = @"早上9点整，由迈阿密热火对阵洛杉矶湖人的NBA总决赛 G4正式开打，最终，湖人以102-96战胜热火，总决赛大 比分改写为3-1本场比赛热火队员阿德巴约复出.";
    self.subTitleStr = @"#日职联";
    self.focusHotTitleStr = @"12585";
    self.likeBtnTitleStr = @"485414";
    
    self.titleLab.alpha = 1;
    self.collectionView.alpha = 1;
    self.subTitleLab.alpha = 1;
    self.focusHotBtn.alpha = 1;
    self.likeBtn.alpha = 1;
}

+(CGSize)cellSizeWithModel:(id _Nullable)model{
    return CGSizeMake(MAINSCREEN_WIDTH - 2 * 11, 184);
}
#pragma mark - UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (nonnull __kindof UICollectionViewCell *)collectionView:(nonnull UICollectionView *)collectionView
                                   cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    UBLVideoCollectionViewCell_Style10 *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"UBLVideoCollectionViewCell_Style10" forIndexPath:indexPath];
    [cell richElementsInCellWithModel:[UIImage animatedGIFNamed:@"⚽️PicResource/Gif/Bt9h"]];
//    [cell.player.currentPlayerManager play];//建议不直接播，因为耗能
    return cell;
}

- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView
     numberOfItemsInSection:(NSInteger)section {
    return 3;
}
#pragma mark —— UICollectionViewDelegate
//允许选中时，高亮
-(BOOL)collectionView:(UICollectionView *)collectionView
shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"%s", __FUNCTION__);
    return YES;
}
// 高亮完成后回调
-(void)collectionView:(UICollectionView *)collectionView
didHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"%s", __FUNCTION__);
}
// 由高亮转成非高亮完成时的回调
-(void)collectionView:(UICollectionView *)collectionView
didUnhighlightItemAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"%s", __FUNCTION__);
}
// 设置是否允许选中
-(BOOL)collectionView:(UICollectionView *)collectionView
shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"%s", __FUNCTION__);
    return YES;
}
// 设置是否允许取消选中
-(BOOL)collectionView:(UICollectionView *)collectionView
shouldDeselectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"%s", __FUNCTION__);
    return YES;
}
// 选中操作
- (void)collectionView:(UICollectionView *)collectionView
didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"%s", __FUNCTION__);
}
// 取消选中操作
-(void)collectionView:(UICollectionView *)collectionView
didDeselectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"%s", __FUNCTION__);
}
#pragma mark —— UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout *)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return [UBLVideoCollectionViewCell_Style10 cellSizeWithModel:nil];
}
///每个item之间的间距 横（行）间距
- (CGFloat)collectionView:(UICollectionView *)collectionView
                   layout:(UICollectionViewLayout *)collectionViewLayout
minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 0;
}
///每个item之间的间距  列(纵)间距
- (CGFloat)collectionView:(UICollectionView *)collectionView
                   layout:(UICollectionViewLayout *)collectionViewLayout
minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 22;
}
///内间距
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView
                       layout:(UICollectionViewLayout*)collectionViewLayout
       insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(14,
                            14,
                            14,
                            14);
}
#pragma mark —— lazyLoad
-(UILabel *)titleLab{
    if (!_titleLab) {
        _titleLab = UILabel.new;
        _titleLab.numberOfLines = 0;
        _titleLab.font = [UIFont systemFontOfSize:13
                                           weight:UIFontWeightMedium];
        _titleLab.textColor = HEXCOLOR(0x676973);
        _titleLab.text = self.titleStr;
        [self.contentView addSubview:_titleLab];
        [_titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView).offset(14);
            make.right.equalTo(self.contentView).offset(-14);
            make.top.equalTo(self.contentView).offset(22);
            make.height.mas_equalTo(45);
        }];
    }return _titleLab;
}

-(UICollectionViewFlowLayout *)layout{
    if (!_layout) {
        _layout = UICollectionViewFlowLayout.new;
//        [_layout.affectedSectionsMutArr addObject:@(0)];//受到影响的section序列号
        _layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    }return _layout;
}

-(UICollectionView *)collectionView{
    if (!_collectionView) {
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero
                                                       collectionViewLayout:self.layout];
        _collectionView.backgroundColor = self.bgCor;
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        _collectionView.showsVerticalScrollIndicator = NO;

        [_collectionView RegisterClass];

        [self.contentView addSubview:_collectionView];
        [_collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.titleLab.mas_bottom);
            make.left.right.equalTo(self.contentView);
            make.height.mas_equalTo(81);
        }];
    }return _collectionView;
}

-(UILabel *)subTitleLab{
    if (!_subTitleLab) {
        _subTitleLab = UILabel.new;
        _subTitleLab.font = [UIFont systemFontOfSize:11
                                              weight:UIFontWeightMedium];
        _subTitleLab.textColor = HEXCOLOR(0x4B88EC);
        _subTitleLab.text = self.subTitleStr;
        [_subTitleLab sizeToFit];
        [self.contentView addSubview:_subTitleLab];
        [_subTitleLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.titleLab);
            make.top.equalTo(self.collectionView.mas_bottom).offset(12);
        }];
    }return _subTitleLab;
}

-(UIButton *)focusHotBtn{
    if (!_focusHotBtn) {
        _focusHotBtn = UIButton.new;
        [_focusHotBtn setTitleColor:HEXCOLOR(0x6E7283)
                           forState:UIControlStateNormal];
        _focusHotBtn.titleLabel.font = [UIFont systemFontOfSize:11
                                                         weight:UIFontWeightMedium];
        [_focusHotBtn setTitle:self.focusHotTitleStr
                      forState:UIControlStateNormal];
        [_focusHotBtn setImage:[UIImage animatedGIFNamed:@"⚽️PicResource/Gif/热度"]
                      forState:UIControlStateNormal];
        [_focusHotBtn.titleLabel sizeToFit];
        _focusHotBtn.titleLabel.adjustsFontSizeToFitWidth = YES;
        [self.contentView addSubview:_focusHotBtn];
        [_focusHotBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.subTitleLab.mas_right).offset(12);
            make.centerY.equalTo(self.subTitleLab);
        }];
    }return _focusHotBtn;
}

-(UIButton *)likeBtn{
    if (!_likeBtn) {
        _likeBtn = UIButton.new;
        [_likeBtn setTitleColor:HEXCOLOR(0x6E7283)
                          forState:UIControlStateNormal];
        _likeBtn.titleLabel.font = [UIFont systemFontOfSize:11
                                                     weight:UIFontWeightMedium];
        [_likeBtn setImage:KBuddleIMG(@"⚽️PicResource",
                                      @"Others",
                                      nil,
                                      @"❤️")
                      forState:UIControlStateNormal];
        [_likeBtn setTitle:self.likeBtnTitleStr
                  forState:UIControlStateNormal];
        [_likeBtn.titleLabel sizeToFit];
        _likeBtn.titleLabel.adjustsFontSizeToFitWidth = YES;
        [self.contentView addSubview:_likeBtn];
        [_likeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.focusHotBtn.mas_right).offset(13);
            make.centerY.equalTo(self.subTitleLab);
        }];
    }return _likeBtn;
}

-(UIColor *)bgCor{
    if (!_bgCor) {
        _bgCor = RGBCOLOR(246,
                          246,
                          246);
    }return _bgCor;
}

@end
