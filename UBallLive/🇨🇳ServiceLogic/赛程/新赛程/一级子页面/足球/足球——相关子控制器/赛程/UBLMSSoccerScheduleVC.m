//
//  UBLMatchScheduleVC.m
//  UBallLive
//
//  Created by Jobs on 2020/11/19.
//

#import "UBLMSSoccerScheduleVC.h"

@interface UBLMSSoccerScheduleVC ()
<
JXCategoryViewDelegate,
JXCategoryListContainerViewDelegate
>

@property(nonatomic,strong)JXCategoryTimelineView *categoryTitleView;
@property(nonatomic,strong)JXCategoryIndicatorBackgroundView *backgroundView;
@property(nonatomic,strong)JXCategoryListContainerView *listContainerView;
@property(nonatomic,strong)UIImageView *bgimgV;
@property(nonatomic,strong)UIButton *choiceDateBtn;
@property(nonatomic,strong)UILabel *yearLabel;

@property(nonatomic,strong)NSMutableArray <UIViewController *>*childVCsMutArr;
@property(nonatomic,strong)NSMutableArray <NSString *>*status;
@property(nonatomic,strong)NSMutableArray <NSString *>*times;

@end

@implementation UBLMSSoccerScheduleVC

- (void)dealloc {
    NSLog(@"Running self.class = %@;NSStringFromSelector(_cmd) = '%@';__FUNCTION__ = %s", self.class, NSStringFromSelector(_cmd),__FUNCTION__);
}

-(instancetype)init{
    if (self = [super init]) {
        NSLog(@"");
    }return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = RGBCOLOR(246, 246, 246);
    self.categoryTitleView.alpha = 1;
    self.choiceDateBtn.alpha = 1;
    self.bgimgV.alpha = 1;
    [self makeDatePicker];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}

-(void)makeDatePicker{
    // datePickerView 的初始化在 @interface UIViewController (BRPickerView)
    Ivar ivar = class_getInstanceVariable([BRDatePickerView class], "_monthNames");//必须是下划线接属性
    NSArray *_monthNames = @[@"一月份", @"二月份", @"三月份", @"四月份", @"五月份", @"六月份", @"七月份", @"八月份", @"九月份", @"十月份", @"十一月份", @"十二月份"];
    object_setIvar(self.datePickerView, ivar, _monthNames);
    
    self.customStyle.pickerColor = kWhiteColor;
    self.datePickerView.pickerStyle = self.customStyle;
//    self.yearLabel.alpha = 1;
    // 滚动选择器，动态更新年份
    @weakify(self)
    self.datePickerView.changeBlock = ^(NSDate * _Nullable selectDate, NSString * _Nullable selectValue) {
        @strongify(self)
        self.yearLabel.text = selectDate ? @(selectDate.br_year).stringValue : @"";
    };
    [self BRDatePickerViewAction];
}
#pragma mark - JXCategoryViewDelegate
-(void)categoryView:(JXCategoryBaseView *)categoryView
didSelectedItemAtIndex:(NSInteger)index {//终值
    [self.listContainerView didClickSelectedItemAtIndex:index];
}
#pragma mark - JXCategoryListContainerViewDelegate
-(id<JXCategoryListContentViewDelegate>)listContainerView:(JXCategoryListContainerView *)listContainerView
                                         initListForIndex:(NSInteger)index{
    return self.childVCsMutArr[index];
}

- (NSInteger)numberOfListsInlistContainerView:(JXCategoryListContainerView *)listContainerView {
    return self.status.count;
}

#pragma mark —— lazyLoad
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

-(JXCategoryTimelineView *)categoryTitleView{
    if (!_categoryTitleView) {
        _categoryTitleView = JXCategoryTimelineView.new;
        _categoryTitleView.mj_w = MAINSCREEN_WIDTH - (18 + 17);
        _categoryTitleView.mj_h = categoryTitleViewHeight;
        _categoryTitleView.backgroundColor = RGBCOLOR(246, 246, 246);
        _categoryTitleView.titleLabelVerticalOffset = 13;//偏移量，重要参数
        _categoryTitleView.indicators = @[self.backgroundView];
        _categoryTitleView.titles = self.status;
        _categoryTitleView.timeTitles = self.times;
        _categoryTitleView.delegate = self;
        _categoryTitleView.listContainer =  self.listContainerView;
        _categoryTitleView.defaultSelectedIndex = 1;//默认从第二个开始显示
        _categoryTitleView.titleColorGradientEnabled = YES;
        _categoryTitleView.titleLabelZoomEnabled = YES;
        
        //设置底部状态
        _categoryTitleView.titleColor = [UIColor lightGrayColor];
        _categoryTitleView.titleSelectedColor = [UIColor blackColor];
        _categoryTitleView.titleFont = [UIFont systemFontOfSize:10
                                                         weight:UIFontWeightMedium];
        _categoryTitleView.titleSelectedFont = [UIFont systemFontOfSize:10
                                                                 weight:UIFontWeightMedium];
        //设置顶部时间
        _categoryTitleView.timeTitleFont = [UIFont boldSystemFontOfSize:13];
        _categoryTitleView.timeTitleSelectedFont = [UIFont boldSystemFontOfSize:15];
        _categoryTitleView.timeTitleNormalColor = [UIColor lightGrayColor];
        _categoryTitleView.timeTitleSelectedColor = [UIColor whiteColor];
        
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
        _backgroundView.indicatorHeight = 16;
        _backgroundView.indicatorCornerRadius = 8;
        _backgroundView.verticalMargin = -13;//偏移量，重要参数
        _backgroundView.indicatorColor = kWhiteColor;
    }return _backgroundView;
}

-(UIButton *)choiceDateBtn{
    if (!_choiceDateBtn) {
        _choiceDateBtn = UIButton.new;
        [_choiceDateBtn setImage:KBuddleIMG(@"⚽️PicResource", @"Others", nil, @"ChoiceDate")
                        forState:UIControlStateNormal];
        [self.view addSubview:_choiceDateBtn];
        [_choiceDateBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_offset(CGSizeMake(17, 17));
            make.centerY.equalTo(self.categoryTitleView);
            make.right.equalTo(self.view).offset(-18);
            make.left.equalTo(self.categoryTitleView.mas_right);
        }];
        @weakify(self)
        [[_choiceDateBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
            @strongify(self)
   
            [self.datePickerView show];
            
            TimeModel *timeModel = TimeModel.new;
            [timeModel makeSpecificTime];
            [self.datePickerView.alertView addSubview:self.yearLabel];
            NSLog(@"");
        }];
    }return _choiceDateBtn;
}

-(void)BRDatePickerViewAction{
    @weakify(self)
    self.datePickerView.doneBlock = ^{
        @strongify(self)
        
    };
    
    self.datePickerView.resultBlock = ^(NSDate *selectDate,
                                    NSString *selectValue) {
        @strongify(self)
        NSLog(@"选择的值：%@", selectValue);
    };
}

-(UILabel *)yearLabel{
    if (!_yearLabel) {
        _yearLabel = UILabel.new;
        _yearLabel.backgroundColor = KYellowColor;
        TimeModel *timeModel = TimeModel.new;
        [timeModel makeSpecificTime];
        _yearLabel.text = [NSString stringWithFormat:@"%ld",timeModel.currentYear];
        _yearLabel.frame = self.datePickerView.alertView.bounds;
        _yearLabel.backgroundColor = [UIColor clearColor];
        _yearLabel.textAlignment = NSTextAlignmentCenter;
        _yearLabel.textColor = [[UIColor grayColor] colorWithAlphaComponent:0.2f];
        _yearLabel.font = [UIFont boldSystemFontOfSize:100.0f];
        _yearLabel.text = @([NSDate date].br_year).stringValue;
        [self.datePickerView.alertView addSubview:_yearLabel];
    }return _yearLabel;
}

-(NSMutableArray<UIViewController *> *)childVCsMutArr{
    if (!_childVCsMutArr) {
        _childVCsMutArr = NSMutableArray.array;
        for (int i = 0; i < 6; i++) {
            [_childVCsMutArr addObject:UBLSoccerScheduleChildVC.new];
        }
    }return _childVCsMutArr;
}

-(NSMutableArray<NSString *> *)status{
    if (!_status) {
        _status = NSMutableArray.array;
        TimeModel *timeModel = TimeModel.new;
        [timeModel makeSpecificTime];
        [_status addObject:@"今"];
        [_status addObject:[NSString stringWithFormat:@"%ld",timeModel.currentDay + 1]];
        [_status addObject:[NSString stringWithFormat:@"%ld",timeModel.currentDay + 2]];
        [_status addObject:[NSString stringWithFormat:@"%ld",timeModel.currentDay + 3]];
        [_status addObject:[NSString stringWithFormat:@"%ld",timeModel.currentDay + 4]];
        [_status addObject:[NSString stringWithFormat:@"%ld",timeModel.currentDay + 5]];
    }return _status;
}

-(NSMutableArray<NSString *> *)times{
    if (!_times) {
        _times = NSMutableArray.array;
        [_times addObject:[TimeModel whatDayOfWeekDistanceNow:0]];
        [_times addObject:[TimeModel whatDayOfWeekDistanceNow:1]];
        [_times addObject:[TimeModel whatDayOfWeekDistanceNow:2]];
        [_times addObject:[TimeModel whatDayOfWeekDistanceNow:3]];
        [_times addObject:[TimeModel whatDayOfWeekDistanceNow:4]];
        [_times addObject:[TimeModel whatDayOfWeekDistanceNow:5]];
    }return _times;
}

@end
