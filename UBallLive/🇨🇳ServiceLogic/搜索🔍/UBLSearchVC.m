//
//  UBLSearchVC.m
//  UBallLive
//
//  Created by Jobs on 2020/10/29.
//

#import "UBLSearchVC.h"

#import "UBLSearchBar.h"
#import "UBLSearchResView.h"

#import "KFZShopCatoryFlowLayput.h"

@interface UBLSearchVC ()
<
UICollectionViewDataSource,
UICollectionViewDelegate,
UICollectionViewDelegateFlowLayout
>

@property(nonatomic,strong)KFZShopCatoryFlowLayput *layout;
@property(nonatomic,strong)UICollectionView *collectionView;
@property(nonatomic,strong)UBLSearchBar *searchBar;
@property(nonatomic,strong)UBLSearchResView *searchResView;

@property(nonatomic,assign)CGFloat margin_collectionView;//collectionView的内间距
@property(nonatomic,assign)CGFloat margin_itemX;//item之间的横间距
@property(nonatomic,assign)CGFloat margin_itemY;//item之间的纵间距

@property(nonatomic,strong)UIColor *bgCor;
@property(nonatomic,strong)NSMutableArray <UIImage *>*headerIMGMutArr;
@property(nonatomic,strong)NSMutableArray <NSString *>*headerTitleStrMutArr;
// 临时数据中心
@property(nonatomic,strong)NSMutableArray <NSString *>*dataMutArr;
@property(nonatomic,strong)NSMutableArray <NSString *>*hotSearchDataMutArr;

@end

@implementation UBLSearchVC

- (void)dealloc {
    NSLog(@"Running self.class = %@;NSStringFromSelector(_cmd) = '%@';__FUNCTION__ = %s", self.class, NSStringFromSelector(_cmd),__FUNCTION__);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = kWhiteColor;
//    self.view.backgroundColor = RandomColor;

    self.searchBar.alpha = 1;
    self.collectionView.alpha = 1;
    self.isHiddenNavigationBar = YES;//禁用系统的导航栏
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.isHiddenNavigationBar = YES;//禁用系统的导航栏
}
#pragma mark - UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 3;
}

- (nonnull __kindof UICollectionViewCell *)collectionView:(nonnull UICollectionView *)collectionView
                                   cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        UBLVideoCollectionViewCell_Style6 *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"UBLVideoCollectionViewCell_Style6" forIndexPath:indexPath];
        [cell richElementsInCellWithModel:@{
            @"indexPath":indexPath,
            @"titleStr":self.hotSearchDataMutArr[indexPath.row]
        }];
        return cell;
    }else if (indexPath.section == 1){
        UBLVideoCollectionViewCell_Style5 *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"UBLVideoCollectionViewCell_Style5" forIndexPath:indexPath];
        [cell richElementsInCellWithModel:self.dataMutArr[indexPath.row]];
        return cell;
    }else if (indexPath.section == 2){
        UBLVideoCollectionViewCell_Style1 *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"UBLVideoCollectionViewCell_Style1" forIndexPath:indexPath];
        [cell richElementsInCellWithModel:self.dataMutArr[indexPath.row]];
    //    [cell.player.currentPlayerManager play];//建议不直接播，因为耗能
        return cell;
    }else{
        UBLVideoCollectionViewCell_Style1 *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"UBLVideoCollectionViewCell_Style1" forIndexPath:indexPath];
        [cell richElementsInCellWithModel:self.dataMutArr[indexPath.row]];
    //    [cell.player.currentPlayerManager play];//建议不直接播，因为耗能
        return cell;
    }
}

- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView
     numberOfItemsInSection:(NSInteger)section {
    if (section == 0) {
        return 6;
    }else if(section == 1){
        return 1;
    }else if(section == 2){
        return 4;
    }else{
        return 0;
    }
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView
           viewForSupplementaryElementOfKind:(NSString *)kind
                                 atIndexPath:(NSIndexPath *)indexPath {
    if (kind == UICollectionElementKindSectionHeader) {
        UBLSearchCollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader
                                                                                         withReuseIdentifier:NSStringFromClass(UBLSearchCollectionReusableView.class)
                                                                                                forIndexPath:indexPath];
        
        headerView.img = self.headerIMGMutArr[indexPath.section];
        headerView.titleStr = self.headerTitleStrMutArr[indexPath.section];
        
        return headerView;
    }else{
        return nil;
    }
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
    UBLLivingVC *livingVC = UBLLivingVC.new;
    @weakify(self)
    [livingVC actionBlockLivingVC:^(id data) {
        @strongify(self)
        NSLog(@"您点击了关注");
    }];
    [UIViewController comingFromVC:self
                              toVC:livingVC
                       comingStyle:ComingStyle_PUSH
                 presentationStyle:UIModalPresentationAutomatic
                     requestParams:@""
                           success:^(id data) {}
                          animated:YES];
}
// 取消选中操作
-(void)collectionView:(UICollectionView *)collectionView
didDeselectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"%s", __FUNCTION__);
}
#pragma mark —— UICollectionViewDelegateFlowLayout
// header 大小
- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout *)collectionViewLayout
referenceSizeForHeaderInSection:(NSInteger)section {
    return [UBLSearchCollectionReusableView collectionReusableViewSizeWithModel:nil];
}

- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout *)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return [UBLVideoCollectionViewCell_Style6 cellSizeWithModel:nil];
    }else if (indexPath.section == 1){
        return [UBLVideoCollectionViewCell_Style5 cellSizeWithModel:nil];
    }else if (indexPath.section == 2){
        return [UBLVideoCollectionViewCell_Style1 cellSizeWithModel:nil];
    }else{
        return CGSizeZero;
    }
}
///每个item之间的间距 横（行）间距
- (CGFloat)collectionView:(UICollectionView *)collectionView
                   layout:(UICollectionViewLayout *)collectionViewLayout
minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    if (section == 0) {
        return 19;
    }else{
        return self.margin_itemX;
    }
}
///每个item之间的间距  列(纵)间距
- (CGFloat)collectionView:(UICollectionView *)collectionView
                   layout:(UICollectionViewLayout *)collectionViewLayout
minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    if (section == 0) {
        return 57;
    }else{
        return self.margin_itemY;
    }
}
///内间距
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView
                       layout:(UICollectionViewLayout*)collectionViewLayout
       insetForSectionAtIndex:(NSInteger)section {
    if (section == 0) {
        return  UIEdgeInsetsMake(12,
                                 36,
                                 12,
                                 36);
    }else{
        return UIEdgeInsetsMake(10,
                                self.margin_collectionView,
                                10,
                                self.margin_collectionView);
    }
}
#pragma mark —— lazyLoad
-(UBLSearchBar *)searchBar{
    if (!_searchBar) {
        _searchBar = UBLSearchBar.new;
        _searchBar.backgroundColor = kWhiteColor;
        @weakify(self)
        [_searchBar actionBlockSearchBarBlock:^(id data) {
            @strongify(self)
            if ([data isKindOfClass:UIButton.class]) {
                [self backBtnClickEvent:data];
            }else if ([data isKindOfClass:UITextField.class]){
                self.searchResView.alpha = 1;
            }else{}
        }];
        [self.view addSubview:_searchBar];
        [_searchBar mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.view).offset(rectOfStatusbar());
            make.height.mas_equalTo(categoryTitleViewHeight);
            make.width.mas_equalTo(MAINSCREEN_WIDTH);
        }];
    }return _searchBar;
}

-(UBLSearchResView *)searchResView{
    if (!_searchResView) {
        _searchResView = UBLSearchResView.new;
        [self.view addSubview:_searchResView];
        [_searchResView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.collectionView);
        }];
    }return _searchResView;
}

-(KFZShopCatoryFlowLayput *)layout{
    if (!_layout) {
        _layout = KFZShopCatoryFlowLayput.new;
        [_layout.affectedSectionsMutArr addObject:@(0)];//受到影响的section序列号
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

        [self.view addSubview:_collectionView];
        [_collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.searchBar.mas_bottom);
            make.left.right.bottom.equalTo(self.view);
        }];
    }return _collectionView;
}

-(CGFloat)margin_collectionView{
    if (_margin_collectionView == 0) {
        _margin_collectionView = Margin_collectionView;
    }return _margin_collectionView;
}

-(CGFloat)margin_itemX{
    if (_margin_itemX == 0) {
        _margin_itemX = Margin_itemX;
    }return _margin_itemX;
}

-(CGFloat)margin_itemY{
    if (_margin_itemY == 0) {
        _margin_itemY = Margin_itemY;
    }return _margin_itemY;
}

-(NSMutableArray<NSString *> *)dataMutArr{
    if (!_dataMutArr) {
        _dataMutArr = NSMutableArray.array;
        [_dataMutArr addObject:@"https://www.bombom999.top/cloud-east-cn/VIDEOS/20201018/363bfd9c-411d-40cc-b006-f66a46f6746b.MP4"];
        [_dataMutArr addObject:@"https://www.bombom999.top/cloud-east-cn/VIDEOS/20201018/8c93026e-3bef-4d04-8def-9f2c5dbccf36.MP4"];
        [_dataMutArr addObject:@"https://www.bombom999.top/cloud-east-cn/VIDEOS/20201018/17cc92e3-4675-495f-9b1a-40038191d908.MP4"];
        [_dataMutArr addObject:@"https://www.bombom999.top/cloud-east-cn/VIDEOS/20201018/63a4f49f-59eb-4644-8757-56550fea0fb9.MP4"];
        [_dataMutArr addObject:@"https://www.bombom999.top/cloud-east-cn/VIDEOS/20201018/c4f0eede-2733-41c0-98e1-d40af52c5d88.MP4"];
        [_dataMutArr addObject:@"https://www.bombom999.top/cloud-east-cn/VIDEOS/20201018/6c7b21ac-0bf0-458d-baa4-8859d0301421.MP4"];
        [_dataMutArr addObject:@"https://www.bombom999.top/cloud-east-cn/VIDEOS/20201018/48272c73-cb64-40e6-9b2d-ce701ded08c1.MP4"];
        [_dataMutArr addObject:@"https://www.bombom999.top/cloud-east-cn/VIDEOS/20201018/d9dde8b8-6f5b-42d0-8654-68c69075a67c.MP4"];
        [_dataMutArr addObject:@"https://www.bombom999.top/cloud-east-cn/VIDEOS/20201018/04c16d17-e510-48eb-99df-418ff2c97fda.MP4"];
        [_dataMutArr addObject:@"https://www.bombom999.top/cloud-east-cn/VIDEOS/20201018/f6703bab-0e38-4909-bf30-9fa7b69b8a72.MP4"];
    }return _dataMutArr;
}

-(NSMutableArray<NSString *> *)headerTitleStrMutArr{
    if (!_headerTitleStrMutArr) {
        _headerTitleStrMutArr = NSMutableArray.array;
        [_headerTitleStrMutArr addObject:@"热门搜索"];
        [_headerTitleStrMutArr addObject:@"人气主播"];
        [_headerTitleStrMutArr addObject:@"直播推荐"];
    }return _headerTitleStrMutArr;
}

-(NSMutableArray<UIImage *> *)headerIMGMutArr{
    if (!_headerIMGMutArr) {
        _headerIMGMutArr = NSMutableArray.array;
        [_headerIMGMutArr addObject:KBuddleIMG(@"⚽️PicResource", @"Others", @"热门标签", @"竞猜推荐")];
        [_headerIMGMutArr addObject:KBuddleIMG(@"⚽️PicResource", @"Others", @"热门标签", @"人气主播")];
        [_headerIMGMutArr addObject:KBuddleIMG(@"⚽️PicResource", @"Others", @"热门标签", @"足球热播")];
    }return _headerIMGMutArr;
}

-(UIColor *)bgCor{
    if (!_bgCor) {
        _bgCor = RGBCOLOR(246, 246, 246);
    }return _bgCor;
}

-(NSMutableArray<NSString *> *)hotSearchDataMutArr{
    if (!_hotSearchDataMutArr) {
        _hotSearchDataMutArr = NSMutableArray.array;
        [_hotSearchDataMutArr addObject:@"洛杉矶湖人"];
        [_hotSearchDataMutArr addObject:@"芝加哥公牛"];
        [_hotSearchDataMutArr addObject:@"费城76人"];
        [_hotSearchDataMutArr addObject:@"迈阿密热火"];
        [_hotSearchDataMutArr addObject:@"密尔沃基雄鹿"];
        [_hotSearchDataMutArr addObject:@"休斯顿火箭"];
    }return _hotSearchDataMutArr;
}

@end
