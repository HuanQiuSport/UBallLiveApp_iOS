//
//  UBLSearchResView.m
//  UBallLive
//
//  Created by Jobs on 2020/10/31.
//

#import "UBLSearchResView.h"

#import "UBLSearchResAllVC.h"//全部
#import "UBLSearchResLivingVC.h"//直播
#import "UBLSearchResMatchScheduleVC.h"//赛程
#import "UBLSearchResUsersVC.h"//用户
#import "UBLSearchResNewsVC.h"//咨询

@interface UBLSearchResView ()
<
JXCategoryViewDelegate,
JXCategoryListContainerViewDelegate
>

@property(nonatomic,strong)JXCategoryDotView *categoryTitleView;
@property(nonatomic,strong)JXCategoryIndicatorLineView *lineView;
@property(nonatomic,strong)JXCategoryIndicatorBackgroundView *backgroundView;
@property(nonatomic,strong)JXCategoryListContainerView *listContainerView;
@property(nonatomic,strong)UIImageView *bgimgV;

@property(nonatomic,strong)NSMutableArray <NSString *> *headerTitles;
@property(nonatomic,strong)NSMutableArray <UIViewController *>*childVCsMutArr;
@property(nonatomic,strong)NSMutableArray <NSNumber *>*dotStatesMutArr;
@property(nonatomic,assign)BOOL isOK;

@end

@implementation UBLSearchResView

-(instancetype)init{
    if (self = [super init]) {
        self.backgroundColor = kRedColor;
    }return self;
}

-(void)drawRect:(CGRect)rect{
    [super drawRect:rect];
    if (!self.isOK) {
        
        self.categoryTitleView.alpha = 1;
        self.bgimgV.alpha = 1;
        
        self.isOK = YES;
    }
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
        _categoryTitleView.mj_w = MAINSCREEN_WIDTH;
        _categoryTitleView.mj_h = categoryTitleViewHeight;
        _categoryTitleView.backgroundColor = kWhiteColor;
        _categoryTitleView.titles = self.headerTitles;
        _categoryTitleView.dotSize = CGSizeMake(5, 5);
//        _categoryTitleView.indicators = @[self.lineView];
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
        [self addSubview:_categoryTitleView];
    }return _categoryTitleView;
}

- (JXCategoryListContainerView *)listContainerView {
    if (!_listContainerView) {
        _listContainerView = [[JXCategoryListContainerView alloc] initWithType:JXCategoryListContainerType_ScrollView
                                                                      delegate:self];
        [self addSubview:_listContainerView];
        [_listContainerView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.equalTo(self);
            make.top.equalTo(self).offset(categoryTitleViewHeight);
        }];
    }return _listContainerView;
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

-(NSMutableArray<NSString *> *)headerTitles{
    if (!_headerTitles) {
        _headerTitles = NSMutableArray.array;
        [_headerTitles addObject:@"全部"];
        [_headerTitles addObject:@"直播"];
        [_headerTitles addObject:@"赛程"];
        [_headerTitles addObject:@"用户"];
        [_headerTitles addObject:@"咨询"];
    }return _headerTitles;
}

-(NSMutableArray<UIViewController *> *)childVCsMutArr{
    if (!_childVCsMutArr) {
        _childVCsMutArr = NSMutableArray.array;
        [_childVCsMutArr addObject:UBLSearchResAllVC.new];//全部
        [_childVCsMutArr addObject:UBLSearchResLivingVC.new];//直播
        [_childVCsMutArr addObject:UBLSearchResMatchScheduleVC.new];//赛程
        [_childVCsMutArr addObject:UBLSearchResUsersVC.new];//用户
        [_childVCsMutArr addObject:UBLSearchResNewsVC.new];//咨询
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
