//
//  MatchScheduleDetailVC.m
//  UBallLive
//
//  Created by Jobs on 2020/11/2.
//

#import "UBLMatchScheduleDetailVC.h"

#import "UBLMatchActionVC.h"//赛况
#import "UBLMatchPredictVC.h"//预测
#import "UBLMatchAnalysisVC.h"//分析
#import "UBLMatchIndexVC.h"//指数
#import "UBLMatchIntelligenceVC.h"//情报
#import "UBLEarlyOfMatchVC.h"//初期
#import "UBLMatchLivingVC.h"//直播
#import "UBLMatchNewsVC.h"//咨询

#import "UBLMatchScheduleDetailTableHeaderView.h"

@interface UBLMatchScheduleDetailVC ()
<
JXPagerViewDelegate,
JXCategoryViewDelegate
>

@property(nonatomic,strong)UBLMatchScheduleDetailTableHeaderView *userHeaderView;
@property(nonatomic,strong)JXPagerView *pagingView;
@property(nonatomic,strong)JXCategoryDotView *categoryTitleView;
@property(nonatomic,strong)JXCategoryIndicatorLineView *lineView;
@property(nonatomic,strong)JXCategoryIndicatorBackgroundView *backgroundView;
@property(nonatomic,strong)UIImageView *bgimgV;
@property(nonatomic,strong)UIBarButtonItem *livingBtnItem;
@property(nonatomic,strong)UIBarButtonItem *shareBtnItem;
@property(nonatomic,strong)UIButton *shareBtn;

@property(nonatomic,strong)NSMutableArray <UIViewController *>*childVCsMutArr;
@property(nonatomic,strong)NSMutableArray <NSString *> *titlesMutArr;
@property(nonatomic,strong)NSMutableArray <NSNumber *>*dotStatesMutArr;

@end

@implementation UBLMatchScheduleDetailVC

- (void)dealloc {
    NSLog(@"Running self.class = %@;NSStringFromSelector(_cmd) = '%@';__FUNCTION__ = %s", self.class, NSStringFromSelector(_cmd),__FUNCTION__);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.categoryTitleView.alpha = 1;
    self.bgimgV.alpha = 1;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.isHiddenNavigationBar = YES;//禁用系统的导航栏
    
    if (self.navigationController.viewControllers.count - 1) {//从上个页面推过来才有返回键，直接的赛程详情是没有的
        self.gk_navLeftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.backBtnCategory];
    }
    
    self.gk_navRightBarButtonItems = @[self.shareBtnItem];
    [self hideNavLine];
}
//白色状态栏
- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
}
#pragma mark - JXPagingViewDelegate
- (UIView *)tableHeaderViewInPagerView:(JXPagerView *)pagerView {
    return self.userHeaderView;
}

- (NSUInteger)tableHeaderViewHeightInPagerView:(JXPagerView *)pagerView {
    return MatchScheduleDetailTableHeaderViewHeight;
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
    NSLog(@"KKK = %f",scrollView.contentOffset.y);// MatchScheduleDetailTableHeaderViewHeight shareBtn backBtnCategory
    [self.userHeaderView scrollViewDidScroll:scrollView.contentOffset.y];
    
    int f = (MatchScheduleDetailTableHeaderViewHeight - Top()) / 10;
    CGFloat Alpha = 1 - (scrollView.contentOffset.y / f) * 0.1;
    
    self.shareBtn.alpha = Alpha;
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
        
        [_childVCsMutArr addObject:UBLMatchActionVC.new];
        [_childVCsMutArr addObject:UBLMatchPredictVC.new];
        [_childVCsMutArr addObject:UBLMatchAnalysisVC.new];
        [_childVCsMutArr addObject:UBLMatchIndexVC.new];
        [_childVCsMutArr addObject:UBLMatchIntelligenceVC.new];
        [_childVCsMutArr addObject:UBLEarlyOfMatchVC.new];
        [_childVCsMutArr addObject:UBLMatchLivingVC.new];
        [_childVCsMutArr addObject:UBLMatchNewsVC.new];
    }return _childVCsMutArr;
}

-(NSMutableArray<NSString *> *)titlesMutArr{
    if (!_titlesMutArr) {
        _titlesMutArr = NSMutableArray.array;
        [_titlesMutArr addObject:@"赛况"];
        [_titlesMutArr addObject:@"预测"];
        [_titlesMutArr addObject:@"分析"];
        [_titlesMutArr addObject:@"指数"];
        [_titlesMutArr addObject:@"情报"];
        [_titlesMutArr addObject:@"初期"];
        [_titlesMutArr addObject:@"直播"];
        [_titlesMutArr addObject:@"咨询"];
    }return _titlesMutArr;
}

-(UBLMatchScheduleDetailTableHeaderView *)userHeaderView{
    if (!_userHeaderView) {
        _userHeaderView = UBLMatchScheduleDetailTableHeaderView.new;
        _userHeaderView.frame = CGRectMake(0,
                                           0,
                                           MAINSCREEN_WIDTH,
                                           MatchScheduleDetailTableHeaderViewHeight);
        _userHeaderView.midView_Style = MidView_Style2;//通过这个来改变状态
        _userHeaderView.isZoom = YES;
        @weakify(self)
        [_userHeaderView actiobBlockMatchScheduleDetailTableHeaderView:^(id data) {
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
        _categoryTitleView.dotSize = CGSizeMake(5, 5);
        _categoryTitleView.indicators = @[self.backgroundView];
        _categoryTitleView.delegate = self;
        _categoryTitleView.dotStates = self.dotStatesMutArr;
        _categoryTitleView.titleSelectedColor = kWhiteColor;
        _categoryTitleView.titleColor = HEXCOLOR(0x5A5A5A);
        _categoryTitleView.titleFont = [UIFont systemFontOfSize:14
                                                         weight:UIFontWeightRegular];
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
        [_dotStatesMutArr addObject:@YES];
        [_dotStatesMutArr addObject:@YES];
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
        UIButton *btn = UIButton.new;
        btn.mj_w = 55;
        btn.mj_h = 23;
        btn.backgroundColor = KLightGrayColor;
        [btn setTitle:@"直播中" forState:UIControlStateNormal];
        [btn setTitleColor:kWhiteColor forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:12 weight:UIFontWeightMedium];
        [UIView cornerCutToCircleWithView:btn AndCornerRadius:23 / 2];
        _livingBtnItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
    }return _livingBtnItem;
}

-(UIBarButtonItem *)shareBtnItem{
    if (!_shareBtnItem) {
        _shareBtnItem = [[UIBarButtonItem alloc] initWithCustomView:self.shareBtn];
    }return _shareBtnItem;
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
