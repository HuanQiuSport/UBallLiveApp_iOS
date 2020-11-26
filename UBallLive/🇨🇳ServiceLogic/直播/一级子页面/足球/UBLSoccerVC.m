//
//  SoccerVC.m
//  UBallLive
//
//  Created by Jobs on 2020/10/28.
//

#import "UBLSoccerVC.h"

#import "UBLAllVC.h"//全部
#import "UBLLaLigaVC.h"//西甲
#import "UBLFAPremierLeagueVC.h"//英超
#import "UBLSerieAVC.h"//意甲
//#import "UBLUEFAChampionsLeagueVC.h"//欧冠
//#import "UBLAsianFootballConfederationChampionsLeagueVC.h"//亚冠
//#import "UBLGermanBundesligaVC.h"//德甲

@interface UBLSoccerVC ()
<
JXCategoryViewDelegate,
JXCategoryListContainerViewDelegate
>

@property(nonatomic,strong)JXCategoryDotView *categoryTitleView;
@property(nonatomic,strong)JXCategoryIndicatorBackgroundView *backgroundView;
@property(nonatomic,strong)JXCategoryListContainerView *listContainerView;
@property(nonatomic,strong)UIImageView *bgimgV;

@property(nonatomic,strong)NSMutableArray <NSString *> *headerTitles;
@property(nonatomic,strong)NSMutableArray <UIViewController *>*childVCsMutArr;
@property(nonatomic,strong)NSMutableArray <NSNumber *>*dotStatesMutArr;

@end

@implementation UBLSoccerVC

- (void)dealloc {
    NSLog(@"Running self.class = %@;NSStringFromSelector(_cmd) = '%@';__FUNCTION__ = %s", self.class, NSStringFromSelector(_cmd),__FUNCTION__);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = RGBCOLOR(246, 246, 246);
    self.categoryTitleView.alpha = 1;
    self.bgimgV.alpha = 1;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}
#pragma mark - JXCategoryViewDelegate
-(void)categoryView:(JXCategoryBaseView *)categoryView
didSelectedItemAtIndex:(NSInteger)index {//终值
    [self.listContainerView didClickSelectedItemAtIndex:index];
    //点击以后红点消除
    if ([self.dotStatesMutArr[index] boolValue]) {
        self.dotStatesMutArr[index] = @(NO);
        self.categoryTitleView.dotStates = self.dotStatesMutArr;
        [categoryView reloadCellAtIndex:index];
    }
}
#pragma mark - JXCategoryListContainerViewDelegate
-(id<JXCategoryListContentViewDelegate>)listContainerView:(JXCategoryListContainerView *)listContainerView
                                         initListForIndex:(NSInteger)index{
    return self.childVCsMutArr[index];
}

- (NSInteger)numberOfListsInlistContainerView:(JXCategoryListContainerView *)listContainerView {
    return self.headerTitles.count;
}

#pragma mark —— lazyLoad
-(JXCategoryDotView *)categoryTitleView{
    if (!_categoryTitleView) {
        _categoryTitleView = JXCategoryDotView.new;
        _categoryTitleView.mj_w = MAINSCREEN_WIDTH - 168;
        _categoryTitleView.mj_h = categoryTitleViewHeight;
        _categoryTitleView.backgroundColor = RGBCOLOR(246, 246, 246);
        _categoryTitleView.dotSize = CGSizeMake(5, 5);
        _categoryTitleView.titles = self.headerTitles;
        _categoryTitleView.indicators = @[self.backgroundView];
        _categoryTitleView.delegate = self;
        _categoryTitleView.dotStates = self.dotStatesMutArr;
        _categoryTitleView.titleSelectedColor = kWhiteColor;
        _categoryTitleView.titleColor = kBlackColor;
        _categoryTitleView.titleFont = [UIFont systemFontOfSize:14
                                                         weight:UIFontWeightMedium];
        _categoryTitleView.listContainer =  self.listContainerView;
        _categoryTitleView.defaultSelectedIndex = 1;//默认从第二个开始显示
        _categoryTitleView.titleColorGradientEnabled = YES;
        _categoryTitleView.titleLabelZoomEnabled = YES;
        [self.view addSubview:_categoryTitleView];
    }return _categoryTitleView;
}

- (JXCategoryListContainerView *)listContainerView {
    if (!_listContainerView) {
        _listContainerView = [[JXCategoryListContainerView alloc] initWithType:JXCategoryListContainerType_ScrollView
                                                                      delegate:self];
//        _listContainerView.backgroundColor = kRedColor;
        [self.view addSubview:_listContainerView];
        [_listContainerView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.view).offset(categoryTitleViewHeight);
            make.left.right.bottom.equalTo(self.view);
        }];
    }return _listContainerView;
}

-(JXCategoryIndicatorBackgroundView *)backgroundView{
    if (!_backgroundView) {
        _backgroundView = JXCategoryIndicatorBackgroundView.new;
        _backgroundView.indicatorHeight = 20;
        _backgroundView.indicatorCornerRadius = 0;
        _backgroundView.indicatorColor = kClearColor;
    }return _backgroundView;
}

-(NSMutableArray<NSNumber *> *)dotStatesMutArr{
    if (!_dotStatesMutArr) {
        _dotStatesMutArr = NSMutableArray.array;
        [_dotStatesMutArr addObject:@YES];
        [_dotStatesMutArr addObject:@NO];
        [_dotStatesMutArr addObject:@YES];
        [_dotStatesMutArr addObject:@NO];
//        [_dotStatesMutArr addObject:@YES];
//        [_dotStatesMutArr addObject:@NO];
//        [_dotStatesMutArr addObject:@YES];
    }return _dotStatesMutArr;
}

-(NSMutableArray<NSString *> *)headerTitles{
    if (!_headerTitles) {
        _headerTitles = NSMutableArray.array;
        [_headerTitles addObject:@"全部"];
        [_headerTitles addObject:@"西甲"];
        [_headerTitles addObject:@"英超"];
        [_headerTitles addObject:@"意甲"];
//        [_headerTitles addObject:@"欧冠"];
//        [_headerTitles addObject:@"亚冠"];
//        [_headerTitles addObject:@"德甲"];
    }return _headerTitles;
}

-(NSMutableArray<UIViewController *> *)childVCsMutArr{
    if (!_childVCsMutArr) {
        _childVCsMutArr = NSMutableArray.array;
        [_childVCsMutArr addObject:UBLAllVC.new];//全部
        [_childVCsMutArr addObject:UBLLaLigaVC.new];//西甲
        [_childVCsMutArr addObject:UBLFAPremierLeagueVC.new];//英超
        [_childVCsMutArr addObject:UBLSerieAVC.new];//意甲
//        [_childVCsMutArr addObject:UBLUEFAChampionsLeagueVC.new];//欧冠
//        [_childVCsMutArr addObject:UBLAsianFootballConfederationChampionsLeagueVC.new];//亚冠
//        [_childVCsMutArr addObject:UBLGermanBundesligaVC.new];//德甲
    }return _childVCsMutArr;
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

@end
