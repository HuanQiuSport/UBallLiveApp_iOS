//
//  ViewController@2.m
//  U球直播
//
//  Created by Jobs on 2020/10/9.
//

#import "ViewController@2.h"
#import "UBLVerticalListCollectionView.h"
#import "VerticalListSectionModel.h"

static const CGFloat VerticalListCategoryViewHeight = 80;   //悬浮categoryView的高度
static const NSUInteger VerticalListPinSectionIndex = 1;    //悬浮固定section的index

@interface ViewController_2 ()
<
UICollectionViewDataSource,
UICollectionViewDelegate,
UICollectionViewDelegateFlowLayout,
JXCategoryViewDelegate
>

@property(nonatomic,strong)JXCategoryDotView *pinCategoryView;
@property(nonatomic,strong)UICollectionViewFlowLayout *layout;
@property(nonatomic,strong)JXCategoryIndicatorLineView *lineView;
@property(nonatomic,strong)UBLVerticalListCollectionView *collectionView;
@property(nonatomic,strong)UBLVerticalSectionCategoryHeaderView *sectionCategoryHeaderView;

@property(nonatomic,assign)CGFloat margin_collectionView;//collectionView的内间距
@property(nonatomic,assign)CGFloat margin_itemX;//item之间的横间距
@property(nonatomic,assign)CGFloat margin_itemY;//item之间的纵间距

@property(nonatomic,strong)NSMutableArray <NSString *> *headerTitles;
@property(nonatomic,strong)NSMutableArray <NSString *> *titles;
@property(nonatomic,strong)NSMutableArray <NSString *> *imageNames;
@property(nonatomic,strong)NSMutableArray <NSIndexPath *>*indexPathMutArr;
@property(nonatomic,strong)NSMutableArray <UICollectionViewLayoutAttributes *> *sectionHeaderAttributes;
@property(nonatomic,strong)NSMutableArray <VerticalListSectionModel *> *dataSource;
@property(nonatomic,strong)NSMutableArray <NSNumber *>*dotStatesMutArr;
@property(nonatomic,strong)NSMutableArray <NSString *>*dataMutArr;// 临时数据中心

@end

@implementation ViewController_2

- (void)dealloc {
    NSLog(@"Running self.class = %@;NSStringFromSelector(_cmd) = '%@';__FUNCTION__ = %s", self.class, NSStringFromSelector(_cmd),__FUNCTION__);
}

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.view.backgroundColor = kWhiteColor;
    self.view.backgroundColor = RandomColor;
    [self.headerTitles enumerateObjectsUsingBlock:^(NSString *title,
                                                    NSUInteger idx,
                                                    BOOL * _Nonnull stop) {
        VerticalListSectionModel *sectionModel = VerticalListSectionModel.new;
        sectionModel.sectionTitle = title;
        NSMutableArray *cellModels = NSMutableArray.array;

        if (idx == 3 || idx == 4) {
            VerticalListCellModel *cellModel = VerticalListCellModel.new;
            cellModel.imageName = self.imageNames[idx];
            cellModel.itemName = title;
            [cellModels addObject:cellModel];
        }else{
            for (int i = 0; i < 4; i ++) {
                VerticalListCellModel *cellModel = VerticalListCellModel.new;
                cellModel.imageName = self.imageNames[idx];
                cellModel.itemName = title;
                [cellModels addObject:cellModel];
            }
        }
        sectionModel.cellModels = cellModels;
        [self.dataSource addObject:sectionModel];
    }];

    self.collectionView.alpha = 1;
    self.pinCategoryView.alpha = 1;
    self.isHiddenNavigationBar = YES;//禁用系统的导航栏
    
    NSLog(@"ViewController_2 viewDidLoad");
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.isHiddenNavigationBar = YES;//禁用系统的导航栏
    NSLog(@"ViewController_2 viewWillAppear");
}

- (void)updateSectionHeaderAttributes {
    if (!self.sectionHeaderAttributes.count) {
        //获取到所有的sectionHeaderAtrributes，用于后续的点击，滚动到指定contentOffset.y使用
        UICollectionViewLayoutAttributes *lastHeaderAttri = nil;
        for (int i = 0; i < self.headerTitles.count; i++) {
            UICollectionViewLayoutAttributes *attri = [self.collectionView.collectionViewLayout layoutAttributesForSupplementaryViewOfKind:UICollectionElementKindSectionHeader
                                                                                                                               atIndexPath:[NSIndexPath indexPathForItem:0
                                                                                                                                                               inSection:i]];
            if (attri) {
                [self.sectionHeaderAttributes addObject:attri];
            }
            if (i == self.headerTitles.count - 1) {
                lastHeaderAttri = attri;
            }
        }
        if (self.sectionHeaderAttributes.count == 0) {
            return;
        }

        //如果最后一个section条目太少了，会导致滚动最底部，但是却不能触发categoryView选中最后一个item。而且点击最后一个滚动的contentOffset.y也不好弄。所以添加contentInset，让最后一个section滚到最下面能显示完整个屏幕。
        UICollectionViewLayoutAttributes *lastCellAttri = [self.collectionView.collectionViewLayout layoutAttributesForItemAtIndexPath:[NSIndexPath indexPathForItem:self.dataSource[self.headerTitles.count - 1].cellModels.count - 1
                                                                                                                                                           inSection:self.headerTitles.count - 1]];
        CGFloat lastSectionHeight = CGRectGetMaxY(lastCellAttri.frame) - CGRectGetMinY(lastHeaderAttri.frame);
        CGFloat value = (self.view.bounds.size.height - VerticalListCategoryViewHeight) - lastSectionHeight;
        if (value > 0) {
            self.collectionView.contentInset = UIEdgeInsetsMake(0,
                                                                0,
                                                                value,
                                                                0);
        }
    }
}
#pragma mark - UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return self.headerTitles.count;
}

- (nonnull __kindof UICollectionViewCell *)collectionView:(nonnull UICollectionView *)collectionView
                                   cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        UBLVideoCollectionViewCell_Style1 *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"UBLVideoCollectionViewCell_Style1" forIndexPath:indexPath];
        cell.indexPath = indexPath;
        [cell richElementsInCellWithModel:self.dataMutArr[indexPath.row]];
    //    [cell.player.currentPlayerManager play];//建议不直接播，因为耗能
        return cell;
    }else if (indexPath.section == 1) {
        UBLVideoCollectionViewCell_Style2 *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"UBLVideoCollectionViewCell_Style2" forIndexPath:indexPath];
        [cell richElementsInCellWithModel:self.dataMutArr[indexPath.row]];
        return cell;
    }else if (indexPath.section == 2){
        UBLVideoCollectionViewCell_Style3 *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"UBLVideoCollectionViewCell_Style3" forIndexPath:indexPath];
        [cell richElementsInCellWithModel:self.dataMutArr[indexPath.row]];
        return cell;
    }else if (indexPath.section == 3){
        UBLVideoCollectionViewCell_Style4 *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"UBLVideoCollectionViewCell_Style4" forIndexPath:indexPath];
        [cell richElementsInCellWithModel:self.dataMutArr[indexPath.row]];
        return cell;
    }else if (indexPath.section == 4){
        UBLVideoCollectionViewCell_Style5 *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"UBLVideoCollectionViewCell_Style5" forIndexPath:indexPath];
        [cell richElementsInCellWithModel:self.dataMutArr[indexPath.row]];
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
    if (self.indexPathMutArr.count) {
        for (NSIndexPath *indexPath in self.indexPathMutArr) {
            if (section == indexPath.section) {
                return 0;
            }
        }
    }return self.dataSource[section].cellModels.count;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView
           viewForSupplementaryElementOfKind:(NSString *)kind
                                 atIndexPath:(NSIndexPath *)indexPath {
    if (kind == UICollectionElementKindSectionHeader) {
        if (indexPath.section == VerticalListPinSectionIndex) {
            UBLVerticalSectionCategoryHeaderView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader
                                                                                                  withReuseIdentifier:@"UBLVerticalSectionCategoryHeaderView"
                                                                                                         forIndexPath:indexPath];
            self.sectionCategoryHeaderView = headerView;
            headerView.indexPath = indexPath;
            if (!self.pinCategoryView.superview) {
                //首次使用VerticalSectionCategoryHeaderView的时候，把pinCategoryView添加到它上面。
                [headerView addSubview:self.pinCategoryView];
            }
            return headerView;
        }else {
            UBLVerticalSectionHeaderView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader
                                                                                          withReuseIdentifier:@"UBLVerticalSectionHeaderView"
                                                                                                 forIndexPath:indexPath];
            headerView.indexPath = indexPath;
            [headerView richElementsInCellWithModel:self.dataSource[indexPath.section]];
            @weakify(self)
            [headerView actionBlockCollectionReusableView:^(NSIndexPath *data) {
                @strongify(self)
                if (self.indexPathMutArr.count) {//已经点击过
                    [self.indexPathMutArr addObject:data];
                    for (NSIndexPath *indexPath in self.indexPathMutArr) {
                        if (indexPath.section == data.section &&
                            indexPath.row == data.row) {//存在同一个
                            [self.indexPathMutArr removeObject:data];//同一个就删除
                            if (!self.indexPathMutArr.count) {
                                break;
                            }
                        }
                    }
                }else{//第一次点击
                    [self.indexPathMutArr addObject:data];
                }
                
                [self.collectionView reloadData];
                NSLog(@"");
            }];
            return headerView;
        }
    }
    return [collectionView dequeueReusableSupplementaryViewOfKind:kind
                                              withReuseIdentifier:@"other"
                                                     forIndexPath:indexPath];
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
    
    if (indexPath.section == 1) {
        [UIViewController comingFromVC:self
                                  toVC:UBLMatchScheduleDetailVC.new
                           comingStyle:ComingStyle_PUSH
                     presentationStyle:UIModalPresentationAutomatic
                         requestParams:@""
                               success:^(id data) {}
                              animated:YES];
    }else{
        
        UBLLivingVC *livingVC = UBLLivingVC.new;
        @weakify(self)
        [livingVC actionBlockLivingVC:^(id data) {
            @strongify(self)
            NSLog(@"您点击了关注");
        }];
        
        [UIViewController comingFromVC:weak_self
                                  toVC:livingVC//TestVC.new//
                           comingStyle:ComingStyle_PUSH
                     presentationStyle:UIModalPresentationAutomatic
                         requestParams:@""
                               success:^(id data) {}
                              animated:YES];
    }
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
    if (section == VerticalListPinSectionIndex) {
        //categoryView所在的headerView要高一些
        return CGSizeMake(MAINSCREEN_WIDTH, VerticalListCategoryViewHeight);
    }return CGSizeMake(MAINSCREEN_WIDTH, 40);
}

- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout *)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 1) {//VideoCollectionViewCell_Style2
        return [UBLVideoCollectionViewCell_Style2 cellSizeWithModel:nil];
    }else if (indexPath.section == 2){//VideoCollectionViewCell_Style3
        return [UBLVideoCollectionViewCell_Style3 cellSizeWithModel:nil];
    }else if (indexPath.section == 3){
        return [UBLVideoCollectionViewCell_Style4 cellSizeWithModel:nil];
    }else if (indexPath.section == 4){
        return [UBLVideoCollectionViewCell_Style5 cellSizeWithModel:nil];
    }else{
        return [UBLVideoCollectionViewCell_Style1 cellSizeWithModel:nil];
    }
}
///每个item之间的间距 横（行）间距
- (CGFloat)collectionView:(UICollectionView *)collectionView
                   layout:(UICollectionViewLayout *)collectionViewLayout
minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    if (section == 1) {//VideoCollectionViewCell_Style2
        return 0;
    }else if (section == 2){
        return self.margin_itemX;
    }else if (section == 3){
        return 0;
    }else if (section == 4){
        return 0;
    }else{
        return self.margin_itemX;
    }
}
///每个item之间的间距  列(纵)间距
- (CGFloat)collectionView:(UICollectionView *)collectionView
                   layout:(UICollectionViewLayout *)collectionViewLayout
minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    if (section == 1) {//VideoCollectionViewCell_Style2
        return 0;
    }else if (section == 2) {//VideoCollectionViewCell_Style2
        return self.margin_itemY;
    }else if (section == 3){
        return 0;
    }else if (section == 4){
        return 0;
    }else{
        return self.margin_itemY;
    }
}
///内间距
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView
                       layout:(UICollectionViewLayout*)collectionViewLayout
       insetForSectionAtIndex:(NSInteger)section {
    
    if (section == 1) {//VideoCollectionViewCell_Style2
        return UIEdgeInsetsZero;
    }else if (section == 2){
        return UIEdgeInsetsMake(0,
                                self.margin_collectionView,
                                10,
                                self.margin_collectionView);
    }else if(section == 3){
        return UIEdgeInsetsZero;
    }else if(section == 4){
        return UIEdgeInsetsZero;
    }else{
        return UIEdgeInsetsMake(0,
                                self.margin_collectionView,
                                10,
                                self.margin_collectionView);
    }
}
#pragma mark —— UIScrollViewDelegate
-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (self.sectionHeaderAttributes.count) {
        UICollectionViewLayoutAttributes *attri = self.sectionHeaderAttributes[VerticalListPinSectionIndex];
        NSLog(@"MMMM = %f",attri.frame.origin.y);
        NSLog(@"QQQQ = %f",scrollView.contentOffset.y);
        if (scrollView.contentOffset.y >= attri.frame.origin.y) {
            //当滚动的contentOffset.y大于了指定sectionHeader的y值，且还没有被添加到self.view上的时候，就需要切换superView
            if (self.pinCategoryView.superview != self.view) {
                [self.view addSubview:self.pinCategoryView];
            }
        }else if (self.pinCategoryView.superview != self.sectionCategoryHeaderView) {
            //当滚动的contentOffset.y小于了指定sectionHeader的y值，且还没有被添加到sectionCategoryHeaderView上的时候，就需要切换superView
            [self.sectionCategoryHeaderView addSubview:self.pinCategoryView];
        }
        if (self.pinCategoryView.selectedIndex != 0 && scrollView.contentOffset.y == 0) {
            //点击了状态栏滚动到顶部时的处理
            [self.pinCategoryView selectItemAtIndex:0];
        }
        if (!(scrollView.isTracking || scrollView.isDecelerating)) {
            //不是用户滚动的，比如setContentOffset等方法，引起的滚动不需要处理。
            return;
        }
        //用户滚动的才处理
        //获取categoryView下面一点的所有布局信息，用于知道，当前最上方是显示的哪个section
        CGRect topRect = CGRectMake(0,
                                    scrollView.contentOffset.y + VerticalListCategoryViewHeight + 1,
                                    self.view.bounds.size.width,
                                    1);
        NSLog(@"KKKK = %f",scrollView.contentOffset.y + VerticalListCategoryViewHeight + 1);
        UICollectionViewLayoutAttributes *topAttributes = [self.collectionView.collectionViewLayout layoutAttributesForElementsInRect:topRect].firstObject;
        NSUInteger topSection = topAttributes.indexPath.section;
        if (topAttributes != nil && topSection >= VerticalListPinSectionIndex) {
            if (self.pinCategoryView.selectedIndex != topSection - VerticalListPinSectionIndex) {
                //不相同才切换
                [self.pinCategoryView selectItemAtIndex:topSection - VerticalListPinSectionIndex];
            }
        }
    }
}
#pragma mark - JXCategoryViewDelegate
- (void)categoryView:(JXCategoryBaseView *)categoryView
didClickSelectedItemAtIndex:(NSInteger)index {
    //这里关心点击选中的回调！！！
    if (self.sectionHeaderAttributes.count) {
        UICollectionViewLayoutAttributes *targetAttri = self.sectionHeaderAttributes[index + VerticalListPinSectionIndex];
//        NSLog(@"AAAA = %f", targetAttri.frame.origin.y);
        
//        [self.collectionView setContentOffset:CGPointMake(0, (targetAttri.frame.origin.y - TopSafeAreaHeight())) animated:YES];
        
        if (index == 0) {
            //选中了第一个，特殊处理一下，滚动到sectionHeaer的最上面
            [self.collectionView setContentOffset:CGPointMake(0, (targetAttri.frame.origin.y - TopSafeAreaHeight())) animated:YES];
        }else {
            //不是第一个，需要滚动到categoryView下面
            [self.collectionView setContentOffset:CGPointMake(0, (targetAttri.frame.origin.y - TopSafeAreaHeight()) + VerticalListCategoryViewHeight) animated:YES];
//            [self.collectionView setContentOffset:CGPointMake(0, (targetAttri.frame.origin.y - TopSafeAreaHeight())) animated:YES];
        }
        
        //点击以后红点消除
        if ([self.dotStatesMutArr[index] boolValue]) {
            self.dotStatesMutArr[index] = @(NO);
            self.pinCategoryView.dotStates = self.dotStatesMutArr;
            [categoryView reloadCellAtIndex:index];
        }
    }
}
#pragma mark —— lazyLoad
-(UICollectionViewFlowLayout *)layout{
    if (!_layout) {
        _layout = UICollectionViewFlowLayout.new;
        _layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    }return _layout;
}

-(UBLVerticalListCollectionView *)collectionView{
    if (!_collectionView) {
        _collectionView = [[UBLVerticalListCollectionView alloc] initWithFrame:CGRectZero
                                                          collectionViewLayout:self.layout];
        @weakify(self)
        _collectionView.layoutSubviewsCallback = ^{
            @strongify(self)
            [self updateSectionHeaderAttributes];
        };
        _collectionView.backgroundColor = RGBCOLOR(231,
                                                   243,
                                                   252);
        _collectionView.dataSource = self;
        _collectionView.delegate = self;

        [_collectionView RegisterClass];

        [self.view addSubview:_collectionView];
        [_collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.view);
        }];
    }return _collectionView;
}

-(JXCategoryIndicatorLineView *)lineView{
    if (!_lineView) {
        _lineView = JXCategoryIndicatorLineView.new;
        _lineView.verticalMargin = 15;
    }return _lineView;
}

-(JXCategoryDotView *)pinCategoryView{
    if (!_pinCategoryView) {
        //创建pinCategoryView，但是不要 addSubview
        _pinCategoryView = JXCategoryDotView.new;
        _pinCategoryView.dotStates = self.dotStatesMutArr;
        _pinCategoryView.dotSize = CGSizeMake(5, 5);
        _pinCategoryView.backgroundColor = RGBCOLOR(231, 243, 252);
        _pinCategoryView.frame = CGRectMake(0, 0, MAINSCREEN_WIDTH, VerticalListCategoryViewHeight);
        _pinCategoryView.titles = self.titles;//@[@"超级大IP", @"热门HOT", @"周边衍生", @"影视综", @"游戏集锦", @"搞笑百事"];
        _pinCategoryView.indicators = @[self.lineView];
        _pinCategoryView.delegate = self;
    }return _pinCategoryView;
}

-(NSMutableArray<VerticalListSectionModel *> *)dataSource{
    if (!_dataSource) {
        _dataSource = NSMutableArray.array;
    }return _dataSource;
}

-(NSMutableArray<UICollectionViewLayoutAttributes *> *)sectionHeaderAttributes{
    if (!_sectionHeaderAttributes) {
        _sectionHeaderAttributes = NSMutableArray.array;
    }return _sectionHeaderAttributes;
}

-(NSMutableArray<NSIndexPath *> *)indexPathMutArr{
    if (!_indexPathMutArr) {
        _indexPathMutArr = NSMutableArray.array;
    }return _indexPathMutArr;
}

-(CGFloat)margin_collectionView{
    if (_margin_collectionView == 0) {
        _margin_collectionView = 12;
    }return _margin_collectionView;
}

-(CGFloat)margin_itemX{
    if (_margin_itemX == 0) {
        _margin_itemX = 15;
    }return _margin_itemX;
}

-(CGFloat)margin_itemY{
    if (_margin_itemY == 0) {
        _margin_itemY = 12;
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

-(NSMutableArray<NSNumber *> *)dotStatesMutArr{
    if (!_dotStatesMutArr) {
        _dotStatesMutArr = NSMutableArray.array;
        [_dotStatesMutArr addObject:@YES];
        [_dotStatesMutArr addObject:@NO];
        [_dotStatesMutArr addObject:@YES];
        [_dotStatesMutArr addObject:@NO];
        [_dotStatesMutArr addObject:@YES];
        [_dotStatesMutArr addObject:@NO];
        [_dotStatesMutArr addObject:@YES];
    }return _dotStatesMutArr;
}

-(NSMutableArray<NSString *> *)headerTitles{
    if (!_headerTitles) {
        _headerTitles = NSMutableArray.array;
        [_headerTitles addObject:@"全部"];
        [_headerTitles addObjectsFromArray:self.titles];
    }return _headerTitles;
}

-(NSMutableArray<NSString *> *)titles{
    if (!_titles) {
        _titles = NSMutableArray.array;
        [_titles addObject:@"中超"];
        [_titles addObject:@"英超"];
        [_titles addObject:@"意甲"];
        [_titles addObject:@"欧冠"];
        [_titles addObject:@"亚冠"];
        [_titles addObject:@"德甲"];
    }return _titles;
}

-(NSMutableArray<NSString *> *)imageNames{
    if (!_imageNames) {
        _imageNames = NSMutableArray.array;
        [_imageNames addObject:@"boat"];
        [_imageNames addObject:@"crab"];
        [_imageNames addObject:@"lobster"];
        [_imageNames addObject:@"apple"];
        [_imageNames addObject:@"carrot"];
        [_imageNames addObject:@"grape"];
        [_imageNames addObject:@"watermelon"];
    }return _imageNames;
}

@end
