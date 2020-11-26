//
//  UBLMatchIndexVC.m
//  UBallLive
//
//  Created by Jobs on 2020/11/2.
//

#import "UBLMatchIndexVC.h"

#import "UBLSizeOfTheBallVC.h"//大小球
#import "UBLEuropeanOddsVC.h"//欧赔
#import "UBLConcedePointsVC.h"//让球

@interface UBLMatchIndexVC ()
<
JXCategoryListContainerViewDelegate
>

@property(nonatomic,strong)JXCategoryTitleView *myCategoryView;
@property(nonatomic,strong)JXCategoryIndicatorBackgroundView *backgroundView;
@property(nonatomic,strong)JXCategoryListContainerView *listContainerView;
@property(nonatomic,strong)NSMutableArray *titlesMutArr;
@property(nonatomic,strong)NSMutableArray *childVCMutArr;

@end

@implementation UBLMatchIndexVC

-(void)dealloc {
    NSLog(@"Running self.class = %@;NSStringFromSelector(_cmd) = '%@';__FUNCTION__ = %s", self.class, NSStringFromSelector(_cmd),__FUNCTION__);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = kWhiteColor;
    self.myCategoryView.alpha = 1;
}
#pragma mark - JXCategoryListContainerViewDelegate
-(id<JXCategoryListContentViewDelegate>)listContainerView:(JXCategoryListContainerView *)listContainerView
                                         initListForIndex:(NSInteger)index{
    return self.childVCMutArr[index];
}

- (NSInteger)numberOfListsInlistContainerView:(JXCategoryListContainerView *)listContainerView {
    return self.titlesMutArr.count;
}
#pragma mark —— lazyLoad
-(NSMutableArray *)titlesMutArr{
    if (!_titlesMutArr) {
        _titlesMutArr = NSMutableArray.array;
        [_titlesMutArr addObject:@"让球"];
        [_titlesMutArr addObject:@"欧赔"];
        [_titlesMutArr addObject:@"大小球"];
    }return _titlesMutArr;
}

-(JXCategoryIndicatorBackgroundView *)backgroundView{
    if (!_backgroundView) {
        _backgroundView = JXCategoryIndicatorBackgroundView.new;
        _backgroundView.indicatorHeight = 30;
        _backgroundView.indicatorWidthIncrement = 0;
        _backgroundView.indicatorColor = HEXCOLOR(0x4895FF);
        _backgroundView.indicatorCornerRadius = 3;
    }return _backgroundView;
}

-(JXCategoryTitleView *)myCategoryView{
    if (!_myCategoryView) {
        _myCategoryView = JXCategoryTitleView.new;
        CGFloat totalItemWidth = MAINSCREEN_WIDTH - 30 * 2;
        _myCategoryView.layer.cornerRadius = 3;
        _myCategoryView.layer.masksToBounds = YES;
        _myCategoryView.layer.borderColor = HEXCOLOR(0x4895FF).CGColor;
        _myCategoryView.layer.borderWidth = 1 / [UIScreen mainScreen].scale;
        _myCategoryView.titles = self.titlesMutArr;
        _myCategoryView.cellSpacing = 0;
        _myCategoryView.cellWidth = totalItemWidth / self.titlesMutArr.count;
        _myCategoryView.titleColor = HEXCOLOR(0x4895FF);
        _myCategoryView.titleSelectedColor = [UIColor whiteColor];
        _myCategoryView.titleLabelMaskEnabled = YES;
        _myCategoryView.indicators = @[self.backgroundView];
        //关联cotentScrollView，关联之后才可以互相联动！！！
        _myCategoryView.contentScrollView = self.listContainerView.scrollView;//
        _myCategoryView.listContainer = self.listContainerView;
        _myCategoryView.defaultSelectedIndex = 1;//默认从第二个开始显示
        [self.scrollView addSubview:_myCategoryView];
        [_myCategoryView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.view);
            make.top.equalTo(self.view).offset(10);
            make.size.mas_equalTo(CGSizeMake(totalItemWidth, 30));
        }];
    }return _myCategoryView;
}

- (JXCategoryListContainerView *)listContainerView {
    if (!_listContainerView) {
        _listContainerView = [[JXCategoryListContainerView alloc] initWithType:JXCategoryListContainerType_ScrollView
                                                                      delegate:self];
        [self.scrollView addSubview:_listContainerView];
        [_listContainerView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.equalTo(self.view);
            make.top.equalTo(self.view);
        }];
    }return _listContainerView;
}

-(NSMutableArray *)childVCMutArr{
    if (!_childVCMutArr) {
        _childVCMutArr = NSMutableArray.array;
        [_childVCMutArr addObject:UBLSizeOfTheBallVC.new];
        [_childVCMutArr addObject:UBLEuropeanOddsVC.new];
        [_childVCMutArr addObject:UBLConcedePointsVC.new];
    }return _childVCMutArr;
}

@end
