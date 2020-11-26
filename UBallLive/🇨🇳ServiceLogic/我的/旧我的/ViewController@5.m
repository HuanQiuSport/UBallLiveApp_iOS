//
//  ViewController@5.m
//  UBallLive
//
//  Created by Jobs on 2020/10/26.
//

#import "ViewController@5.h"

#import "UBLPagingViewTableHeaderView.h"

#import "UBLDynamicVC.h"//动态
#import "UBLForecastVC.h"//预测
#import "UBLVideoVC.h"//录像
#import "UBLReleaseVC.h"//发布
#import "UBLCommentVC.h"//评论
@interface ViewController_5 ()
<
JXPagerViewDelegate,
JXCategoryViewDelegate
>

@property(nonatomic,strong)UBLPagingViewTableHeaderView *userHeaderView;
@property(nonatomic,strong)JXPagerView *pagingView;
@property(nonatomic,strong)JXCategoryDotView *categoryTitleView;
@property(nonatomic,strong)JXCategoryIndicatorLineView *lineView;
@property(nonatomic,strong)JXCategoryIndicatorBackgroundView *backgroundView;
@property(nonatomic,strong)UIImageView *bgimgV;
@property(nonatomic,strong)UIBarButtonItem *livingBtnItem;
@property(nonatomic,strong)UIBarButtonItem *shareBtnItem;
@property(nonatomic,strong)UIButton *livingBtn;
@property(nonatomic,strong)UIButton *shareBtn;

@property(nonatomic,strong)NSMutableArray <UIViewController *>*childVCsMutArr;
@property(nonatomic,strong)NSMutableArray <NSString *> *titlesMutArr;
@property(nonatomic,strong)NSMutableArray <NSNumber *>*dotStatesMutArr;
@end

@implementation ViewController_5

- (void)dealloc {
    NSLog(@"Running self.class = %@;NSStringFromSelector(_cmd) = '%@';__FUNCTION__ = %s", self.class, NSStringFromSelector(_cmd),__FUNCTION__);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.categoryTitleView.alpha = 1;
    self.bgimgV.alpha = 1;
//    [self testIOSocket];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.isHiddenNavigationBar = YES;//禁用系统的导航栏
    
    if (self.navigationController.viewControllers.count - 1) {//从上个页面推过来才有返回键，直接的个人中心是没有的
        self.gk_navLeftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.backBtnCategory];
    }
    
    self.gk_navRightBarButtonItems = @[self.shareBtnItem,self.livingBtnItem];
    [self hideNavLine];
    
//    [self sendImage];
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
}

//- (void)sendImage{
//    [[SocketDemo shared] sendInfoToBackend:@"好时光" WithReturn:^(id  _Nonnull data) {
//
//    }];
//}
//
//- (void)testIOSocket{
//    // 链接消息
//    [[SocketDemo shared] linkBackend:^(id  _Nonnull data) {
//
//    }];
//    // 接收消息
//    [[SocketDemo shared ] recevieInfoFromBackendWithData:^(id  _Nonnull data) {
//
//    }];
//}
#pragma mark - JXPagingViewDelegate
- (UIView *)tableHeaderViewInPagerView:(JXPagerView *)pagerView {
    return self.userHeaderView;
}

- (NSUInteger)tableHeaderViewHeightInPagerView:(JXPagerView *)pagerView {
    return JXTableHeaderViewHeight;
}

- (NSUInteger)heightForPinSectionHeaderInPagerView:(JXPagerView *)pagerView {
    return categoryTitleViewHeight;
}

- (UIView *)viewForPinSectionHeaderInPagerView:(JXPagerView *)pagerView {
    return self.categoryTitleView;
}

- (NSInteger)numberOfListsInPagerView:(JXPagerView *)pagerView {
    return self.titlesMutArr.count;
}

- (id<JXPagerViewListViewDelegate>)pagerView:(JXPagerView *)pagerView
                             initListAtIndex:(NSInteger)index {
    return self.childVCsMutArr[index];
}

- (void)pagerView:(JXPagerView *)pagerView
mainTableViewDidScroll:(UIScrollView *)scrollView{
    
    [self.userHeaderView scrollViewDidScroll:scrollView.contentOffset.y];
    
    int f = (JXTableHeaderViewHeight - Top()) / 10;
    CGFloat Alpha = 1 - (scrollView.contentOffset.y / f) * 0.1;
    
    self.shareBtn.alpha = Alpha;
    self.livingBtn.alpha = Alpha;
    self.backBtnCategory.alpha = Alpha;
    
}
#pragma mark - JXCategoryViewDelegate
- (void)categoryView:(JXCategoryBaseView *)categoryView
didSelectedItemAtIndex:(NSInteger)index {
    self.navigationController.interactivePopGestureRecognizer.enabled = (index == 0);
    //点击以后红点消除
    if ([self.dotStatesMutArr[index] boolValue]) {
        self.dotStatesMutArr[index] = @(NO);
        self.categoryTitleView.dotStates = self.dotStatesMutArr;
        [categoryView reloadCellAtIndex:index];
    }
}
#pragma mark —— lazyLoad
-(NSMutableArray<UIViewController *> *)childVCsMutArr{
    if (!_childVCsMutArr) {
        _childVCsMutArr = NSMutableArray.array;
        [_childVCsMutArr addObject:UBLDynamicVC.new];
        [_childVCsMutArr addObject:UBLForecastVC.new];
        [_childVCsMutArr addObject:UBLVideoVC.new];
        [_childVCsMutArr addObject:UBLReleaseVC.new];
        [_childVCsMutArr addObject:UBLCommentVC.new];
    }return _childVCsMutArr;
}

-(NSMutableArray<NSString *> *)titlesMutArr{
    if (!_titlesMutArr) {
        _titlesMutArr = NSMutableArray.array;
        [_titlesMutArr addObject:@"动态"];
        [_titlesMutArr addObject:@"预测"];
        [_titlesMutArr addObject:@"录像"];
        [_titlesMutArr addObject:@"发布"];
        [_titlesMutArr addObject:@"评论"];
    }return _titlesMutArr;
}

-(UBLPagingViewTableHeaderView *)userHeaderView{
    if (!_userHeaderView) {
        _userHeaderView = UBLPagingViewTableHeaderView.new;
        _userHeaderView.frame = CGRectMake(0,
                                           0,
                                           MAINSCREEN_WIDTH,
                                           JXTableHeaderViewHeight);
        _userHeaderView.isZoom = YES;
        @weakify(self)
        [_userHeaderView actionBlockPagingViewTableHeaderViewBlock:^(id data) {
            @strongify(self)
            NSLog(@"点我干哈");
        }];
    }return _userHeaderView;
}

-(JXCategoryDotView *)categoryTitleView{
    if (!_categoryTitleView) {
        _categoryTitleView = JXCategoryDotView.new;
        _categoryTitleView.mj_w = MAINSCREEN_WIDTH;
        _categoryTitleView.mj_h = categoryTitleViewHeight;
        _categoryTitleView.backgroundColor = kWhiteColor;
        _categoryTitleView.titles = self.titlesMutArr;
//        _categoryTitleView.indicators = @[self.lineView];
        _categoryTitleView.indicators = @[self.backgroundView];
        _categoryTitleView.delegate = self;
        _categoryTitleView.dotStates = self.dotStatesMutArr;
        _categoryTitleView.titleSelectedColor = kWhiteColor;
        _categoryTitleView.titleColor = kBlackColor;
        _categoryTitleView.dotSize = CGSizeMake(5, 5);
        _categoryTitleView.titleFont = [UIFont systemFontOfSize:14
                                                         weight:UIFontWeightMedium];
        _categoryTitleView.listContainer = (id<JXCategoryViewListContainer>)self.pagingView.listContainerView;
        _categoryTitleView.defaultSelectedIndex = 1;//默认从第二个开始显示
        _categoryTitleView.titleColorGradientEnabled = YES;
        _categoryTitleView.titleLabelZoomEnabled = YES;
        [self.view addSubview:_categoryTitleView];
    }return _categoryTitleView;
}

-(JXCategoryIndicatorLineView *)lineView{
    if (!_lineView) {
        _lineView = JXCategoryIndicatorLineView.new;
        _lineView.indicatorColor = RGBCOLOR(105,
                                            144,
                                            239);
        _lineView.indicatorWidth = 30;
    }return _lineView;
}

-(JXCategoryIndicatorBackgroundView *)backgroundView{
    if (!_backgroundView) {
        _backgroundView = JXCategoryIndicatorBackgroundView.new;
        _backgroundView.indicatorHeight = 20;
        _backgroundView.indicatorCornerRadius = 0;
        _backgroundView.indicatorColor = kClearColor;
    }return _backgroundView;
}

-(JXPagerView *)pagingView{
    if (!_pagingView) {
        _pagingView = [[JXPagerView alloc] initWithDelegate:self];
        [self.view addSubview:_pagingView];
        _pagingView.frame = self.view.bounds;
        _pagingView.pinSectionHeaderVerticalOffset = Top();//偏移量
    }return _pagingView;
}

-(NSMutableArray<NSNumber *> *)dotStatesMutArr{
    if (!_dotStatesMutArr) {
        _dotStatesMutArr = NSMutableArray.array;
        [_dotStatesMutArr addObject:@YES];
        [_dotStatesMutArr addObject:@NO];
        [_dotStatesMutArr addObject:@YES];
        [_dotStatesMutArr addObject:@NO];
        [_dotStatesMutArr addObject:@YES];
    }return _dotStatesMutArr;
}

-(UIImageView *)bgimgV{
    if (!_bgimgV) {
        _bgimgV = UIImageView.new;
        _bgimgV.image = KBuddleIMG(@"⚽️PicResource",
                                   @"Others",
                                   nil,
                                   @"矩形气泡");
        [self.backgroundView addSubview:_bgimgV];
        [_bgimgV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.backgroundView);
        }];
    }return _bgimgV;
}

-(UIBarButtonItem *)livingBtnItem{
    if (!_livingBtnItem) {
        _livingBtnItem = [[UIBarButtonItem alloc] initWithCustomView:self.livingBtn];
    }return _livingBtnItem;
}

-(UIBarButtonItem *)shareBtnItem{
    if (!_shareBtnItem) {
        _shareBtnItem = [[UIBarButtonItem alloc] initWithCustomView:self.shareBtn];
    }return _shareBtnItem;
}

-(UIButton *)livingBtn{
    if (!_livingBtn) {
        _livingBtn = UIButton.new;
        _livingBtn.mj_w = 55;
        _livingBtn.mj_h = 23;
        _livingBtn.backgroundColor = KLightGrayColor;
        [_livingBtn setTitle:@"直播中" forState:UIControlStateNormal];
        [_livingBtn setTitleColor:kWhiteColor forState:UIControlStateNormal];
        _livingBtn.titleLabel.font = [UIFont systemFontOfSize:12 weight:UIFontWeightMedium];
        [UIView cornerCutToCircleWithView:_livingBtn AndCornerRadius:23 / 2];
    }return _livingBtn;
}

-(UIButton *)shareBtn{
    if (!_shareBtn) {
        _shareBtn = UIButton.new;
        _shareBtn.mj_w = 23;
        _shareBtn.mj_h = 23;
        [_shareBtn setImage:KBuddleIMG(@"⚽️PicResource", @"Others", nil, @"分享") forState:UIControlStateNormal];
        [_shareBtn setTitleColor:kWhiteColor forState:UIControlStateNormal];
        [UIView cornerCutToCircleWithView:_shareBtn AndCornerRadius:23 / 2];
        [[_shareBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
            NSLog(@"分享功能");
        }];
    }return _shareBtn;
}

@end
