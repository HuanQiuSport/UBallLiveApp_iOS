//
//  UBLHostTeamVC.m
//  UBallLive
//
//  Created by Jobs on 2020/11/8.
//

#import "UBLMatchIntelligenceHostTeamVC.h"

@interface UBLMatchIntelligenceHostTeamVC ()
<
UICollectionViewDataSource,
UICollectionViewDelegate,
UICollectionViewDelegateFlowLayout
>

@property(nonatomic,strong)UICollectionViewFlowLayout *layout;
@property(nonatomic,strong)UICollectionView *collectionView;

@end

@implementation UBLMatchIntelligenceHostTeamVC

-(void)dealloc {
    NSLog(@"Running self.class = %@;NSStringFromSelector(_cmd) = '%@';__FUNCTION__ = %s", self.class, NSStringFromSelector(_cmd),__FUNCTION__);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = RGBCOLOR(246, 246, 246);
    
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.collectionView.alpha = 1;
//    [self.scrollView bringSubviewToFront:self.collectionView];
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (nonnull __kindof UICollectionViewCell *)collectionView:(nonnull UICollectionView *)collectionView
                                   cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    if (indexPath.row == 0) {
        UBLVideoCollectionViewCell_Style14 *cell = (UBLVideoCollectionViewCell_Style14 *)[collectionView dequeueReusableCellWithReuseIdentifier:@"UBLVideoCollectionViewCell_Style14" forIndexPath:indexPath];
        [cell richElementsInCellWithModel:nil];
        return cell;
    }else if(indexPath.row == 1){
        UBLVideoCollectionViewCell_Style13 *cell = (UBLVideoCollectionViewCell_Style13 *)[collectionView dequeueReusableCellWithReuseIdentifier:@"UBLVideoCollectionViewCell_Style13" forIndexPath:indexPath];
        cell.intelligenceType = IntelligenceTypeAdvantage;
        [cell richElementsInCellWithModel:nil];
        return cell;
    }else if(indexPath.row == 2){
        UBLVideoCollectionViewCell_Style13 *cell = (UBLVideoCollectionViewCell_Style13 *)[collectionView dequeueReusableCellWithReuseIdentifier:@"UBLVideoCollectionViewCell_Style13" forIndexPath:indexPath];
        cell.intelligenceType = IntelligenceTypeDisadvantage;
        [cell richElementsInCellWithModel:nil];
        return cell;
    }else if(indexPath.row == 3){
        UBLVideoCollectionViewCell_Style13 *cell = (UBLVideoCollectionViewCell_Style13 *)[collectionView dequeueReusableCellWithReuseIdentifier:@"UBLVideoCollectionViewCell_Style13" forIndexPath:indexPath];
        cell.intelligenceType = IntelligenceTypeNeutrality;
        [cell richElementsInCellWithModel:nil];
        return cell;
    }else{
        return nil;
    }
}

- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView
     numberOfItemsInSection:(NSInteger)section {
    return 4;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView
           viewForSupplementaryElementOfKind:(NSString *)kind
                                 atIndexPath:(NSIndexPath *)indexPath {
    if (kind == UICollectionElementKindSectionHeader) {
        UBLSearchCollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader
                                                                                         withReuseIdentifier:NSStringFromClass(UBLSearchCollectionReusableView.class)
                                                                                                forIndexPath:indexPath];
        
//        headerView.isShowMoreBtn = YES;

//        headerView.img =
        headerView.titleStr = @"独家情报";
        
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
        if (indexPath.row == 0) {
            return [UBLVideoCollectionViewCell_Style14 cellSizeWithModel:nil];
        }else{
            return [UBLVideoCollectionViewCell_Style13 cellSizeWithModel:nil];
        }
    }else{
        return CGSizeZero;
    }
}
///每个item之间的间距 横（行）间距
- (CGFloat)collectionView:(UICollectionView *)collectionView
                   layout:(UICollectionViewLayout *)collectionViewLayout
minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 12;
}
///每个item之间的间距  列(纵)间距
- (CGFloat)collectionView:(UICollectionView *)collectionView
                   layout:(UICollectionViewLayout *)collectionViewLayout
minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 0;
}
///内间距
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView
                       layout:(UICollectionViewLayout*)collectionViewLayout
       insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(0, 0, 0, 0);
}
#pragma mark —— lazyLoad
-(UICollectionViewFlowLayout *)layout{
    if (!_layout) {
        _layout = UICollectionViewFlowLayout.new;
        _layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    }return _layout;
}

-(UICollectionView *)collectionView{
    if (!_collectionView) {
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero
                                                       collectionViewLayout:self.layout];
        _collectionView.backgroundColor = RGBCOLOR(246, 246, 246);
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        _collectionView.showsVerticalScrollIndicator = NO;
        
        [_collectionView RegisterClass];

        [self.scrollView addSubview:_collectionView];
        [_collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.view).offset(50);
            make.left.equalTo(self.view);
            make.right.equalTo(self.view);
            make.bottom.equalTo(self.view);
        }];
    }return _collectionView;
}


@end
