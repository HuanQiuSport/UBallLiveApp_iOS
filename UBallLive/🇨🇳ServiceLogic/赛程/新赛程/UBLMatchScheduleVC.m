//
//  UBLMatchScheduleVC.m
//  UBallLive
//
//  Created by Jobs on 2020/11/19.
//

#import "UBLMatchScheduleVC.h"

static const NSInteger DefaultShow = 1;//默认显示第几号

@interface UBLMatchScheduleVC ()
<
JXCategoryViewDelegate,
JXCategoryListContainerViewDelegate
>

@property(nonatomic,strong)JXCategoryTitleImageView *categoryTitleView;
@property(nonatomic,strong)JXCategoryIndicatorLineView *lineView;
@property(nonatomic,strong)JXCategoryIndicatorBackgroundView *backgroundView;
@property(nonatomic,strong)JXCategoryListContainerView *listContainerView;
@property(nonatomic,strong)UIImageView *selectedBgimgV;
@property(nonatomic,strong)UIButton *logoBtn;
@property(nonatomic,strong)UIButton *searchBtn;
@property(nonatomic,assign)BOOL isOK;

@property(nonatomic,strong)NSMutableArray <UIViewController *>*childVCsMutArr;
@property(nonatomic,strong)NSMutableArray <NSString *>*titlesMutArr;
@property(nonatomic,strong)NSMutableArray <NSString *>*imageNamesMutArr;
@property(nonatomic,strong)NSMutableArray <NSString *>*selectedImageNamesMutArr;

@end

@implementation UBLMatchScheduleVC

- (void)dealloc {
    NSLog(@"Running self.class = %@;NSStringFromSelector(_cmd) = '%@';__FUNCTION__ = %s", self.class, NSStringFromSelector(_cmd),__FUNCTION__);
}

- (void)viewDidLoad {
    [super viewDidLoad];//因为是TabbarCtr的根子控制器，所以先装载的时候window是nil，故状态栏等尺寸拿不到
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.view.backgroundColor = kWhiteColor;
    self.logoBtn.alpha = 1;
    self.searchBtn.alpha = 1;
    self.categoryTitleView.alpha = 1;
    self.selectedBgimgV.alpha = 1;
    self.isHiddenNavigationBar = YES;//禁用系统的导航栏
    self.gk_navigationBar.hidden = YES;
    self.gk_navLeftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.backBtnCategory];
    [self hideNavLine];
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    if (!self.isOK) {
        for (int i = 0; i < self.titlesMutArr.count; i++) {
            JXCategoryTitleImageCell *lastCell = (JXCategoryTitleImageCell *)[self.categoryTitleView.collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForItem:i inSection:0]];
            
            Ivar ivar = class_getInstanceVariable([JXCategoryTitleImageCell class], "_stackView");//必须是下划线接属性
            UIStackView *stackView = object_getIvar(lastCell, ivar);
            if (stackView) {
                UIImageView *unSelectedBgimgV = UIImageView.new;
                unSelectedBgimgV.tag = 999;
                unSelectedBgimgV.image = KIMG(@"未选中背景");
                
                if (DefaultShow == i) {
                    unSelectedBgimgV.alpha = 0;
                }else{
                    unSelectedBgimgV.alpha = 1;
                }
                
                [stackView insertSubview:unSelectedBgimgV atIndex:0];
                [unSelectedBgimgV mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.top.equalTo(stackView).offset(-10);
                    make.bottom.equalTo(stackView).offset(10);
                    make.left.equalTo(stackView).offset(-10);
                    make.right.equalTo(stackView).offset(10);
                }];
            }
        }
        self.isOK = YES;
    }
}
#pragma mark - JXCategoryViewDelegate
-(void)categoryView:(JXCategoryBaseView *)categoryView
didSelectedItemAtIndex:(NSInteger)index {//终值
    for (int i = 0; i < self.titlesMutArr.count; i++) {
        JXCategoryTitleImageCell *lastCell = (JXCategoryTitleImageCell *)[self.categoryTitleView.collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForItem:i inSection:0]];
        
        Ivar ivar = class_getInstanceVariable([JXCategoryTitleImageCell class], "_stackView");//必须是下划线接属性
        UIStackView *stackView = object_getIvar(lastCell, ivar);
        
        UIView *subView = [stackView viewWithTag:999];
        if (index == i) {
            subView.alpha = 0;
        }else{
            subView.alpha = 1;
        }
    }
    [self.listContainerView didClickSelectedItemAtIndex:index];
}
#pragma mark - JXCategoryListContainerViewDelegate
-(id<JXCategoryListContentViewDelegate>)listContainerView:(JXCategoryListContainerView *)listContainerView
                                         initListForIndex:(NSInteger)index{
    return self.childVCsMutArr[index];
}

- (NSInteger)numberOfListsInlistContainerView:(JXCategoryListContainerView *)listContainerView {
    return self.titlesMutArr.count;
}
#pragma mark —— lazyLoad
-(UIButton *)logoBtn{
    if (!_logoBtn) {
        _logoBtn = UIButton.new;
        [_logoBtn setTitle:@"U球直播"
                  forState:UIControlStateNormal];
        [_logoBtn setTitleColor:kCyanColor
                       forState:UIControlStateNormal];
        _logoBtn.titleLabel.font = [UIFont systemFontOfSize:10
                                                     weight:UIFontWeightMedium];
        [_logoBtn setImage:KBuddleIMG(@"⚽️PicResource",
                                      @"Others",
                                      nil,
                                      @"Logo")
                  forState:UIControlStateNormal];
        [_logoBtn layoutButtonWithEdgeInsetsStyle:GLButtonEdgeInsetsStyleTop
                                       imageTitleSpace:3];
        @weakify(self)
        [[_logoBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
            @strongify(self)
            //临时占位，测试注册登录忘记密码
            [UIViewController comingFromVC:self
                                      toVC:UBLDoorVC.new
                               comingStyle:ComingStyle_PUSH
                         presentationStyle:UIModalPresentationAutomatic
                             requestParams:@""
                                   success:^(id data) {}
                                  animated:YES];
        }];

        [self.view addSubview:_logoBtn];
        [_logoBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.view).offset(rectOfStatusbar());
            make.height.mas_equalTo(categoryTitleViewHeight);
            make.width.mas_equalTo(42);
            make.left.equalTo(self.view).offset(12);
        }];
        [UIView setView:_logoBtn
                  layer:_logoBtn.titleLabel.layer
          gradientLayer:HEXCOLOR(0x24EFE8)
               endColor:HEXCOLOR(0x16A2FA)];
    }return _logoBtn;
}

-(UIButton *)searchBtn{
    if (!_searchBtn) {
        _searchBtn =  UIButton.new;
        [_searchBtn setImage:KIMG(@"🔍")
                    forState:UIControlStateNormal];
        @weakify(self)
        [[_searchBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
            @strongify(self)
            [UIViewController comingFromVC:self
                                      toVC:UBLSearchVC.new
                               comingStyle:ComingStyle_PUSH
                         presentationStyle:UIModalPresentationAutomatic
                             requestParams:@""
                                   success:^(id data) {}
                                  animated:YES];
        }];
        [self.view addSubview:_searchBtn];
        [_searchBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.view).offset(rectOfStatusbar());
            make.height.mas_equalTo(categoryTitleViewHeight);
            make.width.mas_equalTo(17);
            make.right.equalTo(self.view).offset(-11);
        }];
    }return _searchBtn;
}

-(JXCategoryTitleImageView *)categoryTitleView{
    if (!_categoryTitleView) {
        _categoryTitleView = JXCategoryTitleImageView.new;
        _categoryTitleView.backgroundColor = kWhiteColor;
        _categoryTitleView.titles = self.titlesMutArr;
        _categoryTitleView.indicators = @[self.backgroundView];
        _categoryTitleView.delegate = self;
        _categoryTitleView.titleSelectedColor = kWhiteColor;
        _categoryTitleView.titleColor = HEXCOLOR(0x6A7A93);
        _categoryTitleView.imageNames = self.imageNamesMutArr;
        _categoryTitleView.selectedImageNames = self.selectedImageNamesMutArr;
        _categoryTitleView.titleFont = [UIFont systemFontOfSize:12
                                                         weight:UIFontWeightMedium];
        _categoryTitleView.listContainer = self.listContainerView;
        _categoryTitleView.defaultSelectedIndex = DefaultShow;//默认从第二个开始显示
        _categoryTitleView.cellSpacing = 10; //cell之间的间距，默认20
        _categoryTitleView.titleImageSpacing = 2;
        _categoryTitleView.titleColorGradientEnabled = YES;
        _categoryTitleView.titleLabelZoomEnabled = YES;
        [self.view addSubview:_categoryTitleView];
        [_categoryTitleView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.view).offset(rectOfStatusbar());
            make.height.mas_equalTo(categoryTitleViewHeight);
            make.left.equalTo(self.logoBtn.mas_right);
//            make.right.equalTo(self.searchBtn.mas_left);
            make.right.equalTo(self.view).offset(-120);
        }];
    }return _categoryTitleView;
}

- (JXCategoryListContainerView *)listContainerView {
    if (!_listContainerView) {
        _listContainerView = [[JXCategoryListContainerView alloc] initWithType:JXCategoryListContainerType_ScrollView
                                                                      delegate:self];
        [self.view addSubview:_listContainerView];
        [_listContainerView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.equalTo(self.view);
            make.top.equalTo(self.view).offset(categoryTitleViewHeight + rectOfStatusbar());
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

-(UIImageView *)selectedBgimgV{
    if (!_selectedBgimgV) {
        _selectedBgimgV = UIImageView.new;
        _selectedBgimgV.image = KIMG(@"已选中背景");
        [self.backgroundView addSubview:_selectedBgimgV];
        [_selectedBgimgV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.backgroundView).offset(-20);
            make.bottom.equalTo(self.backgroundView).offset(20);
            make.left.equalTo(self.backgroundView).offset(-20);
            make.right.equalTo(self.backgroundView).offset(20);
        }];
    }return _selectedBgimgV;
}

-(NSMutableArray<NSString *> *)imageNamesMutArr{
    if (!_imageNamesMutArr) {
        _imageNamesMutArr = NSMutableArray.array;
        [_imageNamesMutArr addObject:@"热门未点击"];
        [_imageNamesMutArr addObject:@"足球未点击"];
    }return _imageNamesMutArr;
}

-(NSMutableArray<NSString *> *)selectedImageNamesMutArr{
    if (!_selectedImageNamesMutArr) {
        _selectedImageNamesMutArr = NSMutableArray.array;
        [_selectedImageNamesMutArr addObject:@"热门已点击"];
        [_selectedImageNamesMutArr addObject:@"足球已点击"];
    }return _selectedImageNamesMutArr;
}

-(NSMutableArray<UIViewController *> *)childVCsMutArr{
    if (!_childVCsMutArr) {
        _childVCsMutArr = NSMutableArray.array;
        [_childVCsMutArr addObject:UBLMSHotVC.new];
        [_childVCsMutArr addObject:UBLMSSoccerVC.new];
    }return _childVCsMutArr;
}

-(NSMutableArray<NSString *> *)titlesMutArr{
    if (!_titlesMutArr) {
        _titlesMutArr = NSMutableArray.array;
        [_titlesMutArr addObject:NSLocalizedString(@"热门", @"热门")];
        [_titlesMutArr addObject:@"足球"];
    }return _titlesMutArr;
}


@end
