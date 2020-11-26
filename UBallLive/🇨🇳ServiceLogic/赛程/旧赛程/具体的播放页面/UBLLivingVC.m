//
//  LivingVC.m
//  UBallLive
//
//  Created by Jobs on 2020/10/21.
//

#import "UBLLivingVC.h"
#import "UBLLivingVideoView.h"

#import "UBLChatVC.h"//聊天
#import "UBLMCVC.h"//主播
#import "UBLGuessingVC.h"//U豆竞猜
#import "UBLMatchResultVC.h"//赛况
#import "UBLContributionVC.h"//贡献榜

static const CGFloat listContainerViewY = 190;
static const CGFloat attentionBtnWidth = 75;

@interface UBLLivingVC ()
<
JXCategoryListContainerViewDelegate,
JXCategoryViewDelegate,
JXCategoryTitleViewDataSource
>

@property(nonatomic,strong)UBLLivingVideoView *userHeaderView;
@property(nonatomic,strong)JXCategoryIndicatorLineView *lineView;
@property(nonatomic,strong)JXCategoryDotView *categoryTitleView;
@property(nonatomic,strong)JXCategoryListContainerView *listContainerView;
@property(nonatomic,strong)UIButton *attentionBtn;

@property(nonatomic,strong)NSMutableArray <NSString *> *titlesMutArr;
@property(nonatomic,strong)NSMutableArray <UIViewController *>*childVCMutArr;
@property(nonatomic,strong)NSMutableArray <NSNumber *>*dotStatesMutArr;
@property(nonatomic,strong)NSString *attentionNumStr;
@property(nonatomic,assign)BOOL isNeedIndicatorPositionChangeItem;
@property(nonatomic,assign)__block BOOL isShowBackBtn;
@property(nonatomic,copy)MKDataBlock livingVCBlock;

@end

@implementation UBLLivingVC

- (void)dealloc {
    NSLog(@"Running self.class = %@;NSStringFromSelector(_cmd) = '%@';__FUNCTION__ = %s", self.class, NSStringFromSelector(_cmd),__FUNCTION__);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = RandomColor;

    self.isHiddenNavigationBar = YES;//禁用系统的导航栏
    
    self.attentionNumStr = @"12";
    
    self.userHeaderView.alpha = 1;
    self.categoryTitleView.alpha  = 1;
    self.attentionBtn.alpha = 1;
    
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.isHiddenNavigationBar = YES;//禁用系统的导航栏
    self.isShowBackBtn = NO;
    self.gk_navLeftBarButtonItem = self.isShowBackBtn ? [[UIBarButtonItem alloc] initWithCustomView:self.backBtnCategory] : nil;
    [self hideNavLine];
    NSLog(@"LivingVC_viewWillAppear");
}

-(void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
    NSLog(@"KKK = %d",self.navigationBar.hidden);
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    NSLog(@"LivingVC_viewWillDisappear");
}

-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    NSLog(@"LivingVC_viewDidDisappear");
    PrintRetainCount(self);
//    [self.userHeaderView.avPlayerManager stop];
    [self.userHeaderView.ijkPlayerManager stop];
}
#pragma mark - JXCategoryViewDelegate
-(void)categoryView:(JXCategoryBaseView *)categoryView
didSelectedItemAtIndex:(NSInteger)index {
    //侧滑手势处理
//    self.navigationController.interactivePopGestureRecognizer.enabled = (index == 0);
    NSLog(@"%@", NSStringFromSelector(_cmd));
    [self.listContainerView didClickSelectedItemAtIndex:index];
    
    //点击以后红点消除
    if ([self.dotStatesMutArr[index] boolValue]) {
        self.dotStatesMutArr[index] = @(NO);
        self.categoryTitleView.dotStates = self.dotStatesMutArr;
        [categoryView reloadCellAtIndex:index];
    }
}

-(void)categoryView:(JXCategoryBaseView *)categoryView
didScrollSelectedItemAtIndex:(NSInteger)index {
    NSLog(@"%@", NSStringFromSelector(_cmd));
}
#pragma mark - JXCategoryListContainerViewDelegate
-(id<JXCategoryListContentViewDelegate>)listContainerView:(JXCategoryListContainerView *)listContainerView
                                         initListForIndex:(NSInteger)index{
    return self.childVCMutArr[index];
}

- (NSInteger)numberOfListsInlistContainerView:(JXCategoryListContainerView *)listContainerView {
    return self.titlesMutArr.count;
}

-(void)actionBlockLivingVC:(MKDataBlock _Nullable)livingVCBlock{
    self.livingVCBlock = livingVCBlock;
}
#pragma mark —— lazyLoad
- (JXCategoryListContainerView *)listContainerView {
    if (!_listContainerView) {
        _listContainerView = [[JXCategoryListContainerView alloc] initWithType:JXCategoryListContainerType_ScrollView
                                                                      delegate:self];
        [self.view addSubview:_listContainerView];
        [_listContainerView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.equalTo(self.view);
            make.top.equalTo(self.view).offset(categoryTitleViewHeight + listContainerViewY + rectOfStatusbar());
        }];
    }return _listContainerView;
}

-(JXCategoryDotView *)categoryTitleView{
    if (!_categoryTitleView) {
        _categoryTitleView = JXCategoryDotView.new;
        _categoryTitleView.backgroundColor = kWhiteColor;
        _categoryTitleView.titles = self.titlesMutArr;
        _categoryTitleView.dotStates = self.dotStatesMutArr;
        _categoryTitleView.indicators = @[self.lineView];
        _categoryTitleView.delegate = self;
        _categoryTitleView.titleSelectedColor = RGBCOLOR(105,
                                                         144,
                                                         239);
        _categoryTitleView.titleColor = kBlackColor;
        _categoryTitleView.dotSize = CGSizeMake(5, 5);
        _categoryTitleView.titleFont = [UIFont systemFontOfSize:14
                                                         weight:UIFontWeightMedium];
        //关联cotentScrollView，关联之后才可以互相联动！！！
        _categoryTitleView.contentScrollView = self.listContainerView.scrollView;//
        _categoryTitleView.listContainer = self.listContainerView;
        _categoryTitleView.defaultSelectedIndex = 1;//默认从第二个开始显示
        _categoryTitleView.titleColorGradientEnabled = YES;
        _categoryTitleView.titleLabelZoomEnabled = YES;
        [self.view addSubview:_categoryTitleView];
        [_categoryTitleView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.userHeaderView.mas_bottom);
            make.height.mas_equalTo(categoryTitleViewHeight);
            make.left.equalTo(self.view);
            make.right.equalTo(self.view).offset(-attentionBtnWidth);
        }];
    }return _categoryTitleView;
}

-(UBLLivingVideoView *)userHeaderView{
    if (!_userHeaderView) {
        _userHeaderView = UBLLivingVideoView.new;
        @weakify(self)
        [_userHeaderView actionLivingVideoViewBlock:^(id data) {
            @strongify(self)
            self.isShowBackBtn = !self.isShowBackBtn;
            
            self.gk_navLeftBarButtonItem = self.isShowBackBtn ? [[UIBarButtonItem alloc] initWithCustomView:self.backBtnCategory] : nil;
            
        }];
        [self.view addSubview:_userHeaderView];
        [_userHeaderView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.view).offset(rectOfStatusbar());
            make.left.right.equalTo(self.view);
            make.height.mas_equalTo(listContainerViewY);
        }];
    }return _userHeaderView;
}

-(UIButton *)attentionBtn{
    if (!_attentionBtn) {
        _attentionBtn = UIButton.new;
        [_attentionBtn setImage:KBuddleIMG(@"⚽️PicResource",
                                           @"Others",
                                           @"关注",
                                           @"+关注")
                       forState:UIControlStateNormal];
        [_attentionBtn setTitle:self.attentionNumStr
                       forState:UIControlStateNormal];
        _attentionBtn.titleLabel.font = [UIFont systemFontOfSize:10
                                                          weight:UIFontWeightMedium];
        
        [_attentionBtn layoutButtonWithEdgeInsetsStyle:GLButtonEdgeInsetsStyleTop
                                       imageTitleSpace:3];

        @weakify(self)
        [[_attentionBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIButton * _Nullable x) {
            @strongify(self)
            x.selected = !x.selected;
            
            if (x.selected) {
                [self->_attentionBtn setImage:KBuddleIMG(@"⚽️PicResource",
                                                   @"Others",
                                                   @"关注",
                                                   @"关注")
                               forState:UIControlStateNormal];
            }else{
                [self->_attentionBtn setImage:KBuddleIMG(@"⚽️PicResource",
                                                   @"Others",
                                                   @"关注",
                                                   @"+关注")
                               forState:UIControlStateNormal];
            }
            
            [self->_attentionBtn layoutButtonWithEdgeInsetsStyle:GLButtonEdgeInsetsStyleTop
                                  imageTitleSpace:5];
            
            if (self.livingVCBlock) {
                self.livingVCBlock(x);
            }
        }];
        [self.view addSubview:_attentionBtn];
        [_attentionBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(self.categoryTitleView);
            make.left.equalTo(self.categoryTitleView.mas_right);
            make.right.equalTo(self.view);
        }];
        [self.view layoutIfNeeded];
        [UIView setView:_attentionBtn
                  layer:_attentionBtn.imageView.layer
          gradientLayer:HEXCOLOR(0x83C8FF)
               endColor:HEXCOLOR(0x3977FE)];
    }return _attentionBtn;
}

-(JXCategoryIndicatorLineView *)lineView{
    if (!_lineView) {
        _lineView = JXCategoryIndicatorLineView.new;
        _lineView.indicatorColor = RGBCOLOR(105, 144, 239);
        _lineView.indicatorWidth = 30;
    }return _lineView;
}

-(NSMutableArray<NSString *> *)titlesMutArr{
    if (!_titlesMutArr) {
        _titlesMutArr = NSMutableArray.array;
        [_titlesMutArr addObject:@"聊天"];
//        [_titlesMutArr addObject:@"主播"];
//        [_titlesMutArr addObject:@"U豆竞猜"];
//        [_titlesMutArr addObject:@"赛况"];
//        [_titlesMutArr addObject:@"贡献榜"];
    }return _titlesMutArr;
}

-(NSMutableArray<UIViewController *> *)childVCMutArr{
    if (!_childVCMutArr) {
        _childVCMutArr = NSMutableArray.array;
        [_childVCMutArr addObject:UBLChatVC.new];
//        [_childVCMutArr addObject:UBLMCVC.new];
//        [_childVCMutArr addObject:UBLGuessingVC.new];
//        [_childVCMutArr addObject:UBLMatchResultVC.new];
//        [_childVCMutArr addObject:UBLContributionVC.new];
    }return _childVCMutArr;
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

@end
