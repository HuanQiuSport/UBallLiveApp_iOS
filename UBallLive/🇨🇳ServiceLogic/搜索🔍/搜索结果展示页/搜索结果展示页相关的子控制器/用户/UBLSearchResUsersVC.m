//
//  UBLSearchResUsersVC.m
//  UBallLive
//
//  Created by Jobs on 2020/10/31.
//

#import "UBLSearchResUsersVC.h"

@interface UBLSearchResUsersVC ()
<
UICollectionViewDataSource,
UICollectionViewDelegate,
UICollectionViewDelegateFlowLayout
>

@property(nonatomic,strong)UICollectionViewFlowLayout *layout;
@property(nonatomic,strong)UICollectionView *collectionView;

@property(nonatomic,strong)UIColor *bgCor;

@end

@implementation UBLSearchResUsersVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = kWhiteColor;
//    self.view.backgroundColor = RandomColor;

    self.collectionView.alpha = 1;
    self.isHiddenNavigationBar = YES;//禁用系统的导航栏

}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.isHiddenNavigationBar = YES;//禁用系统的导航栏
}
#pragma mark - UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 4;
}

- (nonnull __kindof UICollectionViewCell *)collectionView:(nonnull UICollectionView *)collectionView
                                   cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    UBLVideoCollectionViewCell_Style11 *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"UBLVideoCollectionViewCell_Style11" forIndexPath:indexPath];
    [cell actionBlockVideoCollectionViewCell_Style11:^(id data) {
        NSLog(@"点我干嘛");//关注、未关注 按钮点击事件
    }];
    [cell richElementsInCellWithModel:nil];
    return cell;
}

- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView
     numberOfItemsInSection:(NSInteger)section {
    return 1;;
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
- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout *)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return [UBLVideoCollectionViewCell_Style11 cellSizeWithModel:nil];
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
    return 0;
}
///内间距
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView
                       layout:(UICollectionViewLayout*)collectionViewLayout
       insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(12,
                            12,
                            12,
                            12);
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
        _collectionView.backgroundColor = self.bgCor;
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        _collectionView.showsVerticalScrollIndicator = NO;
        
        [_collectionView RegisterClass];

        [self.view addSubview:_collectionView];
        [_collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.view);
        }];
    }return _collectionView;
}

-(UIColor *)bgCor{
    if (!_bgCor) {
        _bgCor = RGBCOLOR(246, 246, 246);
    }return _bgCor;
}

@end
