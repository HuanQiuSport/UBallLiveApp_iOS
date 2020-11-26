//
//  ChatVC.m
//  UBallLive
//
//  Created by Jobs on 2020/10/22.
//

#import "UBLChatVC.h"
#import "UUMarqueeView.h"

static const CGFloat ScrollLabelViewHeight = 28;

@interface UBLChatVC ()<UUMarqueeViewDelegate>

@property(nonatomic,strong)UUMarqueeView *scrollLabelView;
@property(nonatomic,strong)NSMutableArray *scrollContentMutArr;

@end

@implementation UBLChatVC

- (void)viewDidLoad {
    self.gk_navBarAlpha = 0;
    self.gk_navigationBar.hidden = YES;
    [super viewDidLoad];
    
    self.view.backgroundColor = kWhiteColor;
    self.scrollLabelView.alpha = 1;
    self.isHiddenNavigationBar = YES;//禁用系统的导航栏
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

-(void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
}

-(void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    [self reconstraintTableview];
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}

-(void)reconstraintTableview{
    //我写的JobsIM 控件都不暴露在.h 这个是常规操作，所以对.m属性需要进行set操作的时候用runtime
    Ivar ivar = class_getInstanceVariable([JobsIMVC class], "_tableView");//必须是下划线接属性
    UITableView *tableView = object_getIvar(self, ivar);
    tableView.mj_y += ScrollLabelViewHeight;
}
#pragma mark —— UUMarqueeViewDelegate
- (NSUInteger)numberOfVisibleItemsForMarqueeView:(UUMarqueeView*)marqueeView {
    // 指定可视条目的行数，仅[UUMarqueeViewDirectionUpward]时被调用。
    // 当[UUMarqueeViewDirectionLeftward]时行数固定为1。
    return 1;
}

- (NSUInteger)numberOfDataForMarqueeView:(UUMarqueeView*)marqueeView {
    // 指定数据源的个数。例:数据源是字符串数组@[@"A", @"B", @"C"]时，return 3。
    return self.scrollContentMutArr.count;
}

- (void)createItemView:(UIView*)itemView
        forMarqueeView:(UUMarqueeView*)marqueeView {
    // 在marquee view创建时（即'-(void)reloadData'调用后），用于创建条目视图的初始结构，可自行添加任意subview。
    // ### 给必要的subview添加tag，可在'-(void)updateItemView:withData:forMarqueeView:'调用时快捷获取并设置内容。
    UIImageView *icon = [itemView viewWithTag:1002];
    if (!icon) {
        icon = [[UIImageView alloc] initWithFrame:CGRectMake(5.0f,
                                                             (CGRectGetHeight(itemView.bounds) - 16.0f) / 2.0f,
                                                             16.0f,
                                                             16.0f)];
        icon.image = KBuddleIMG(@"⚽️PicResource", @"Others", nil, @"speaker");
        icon.tag = 1002;
        [itemView addSubview:icon];
    }

    UILabel *content = [itemView viewWithTag:1001];
    if (!content) {
        content = [[UILabel alloc] initWithFrame:CGRectMake(5.0f + 16.0f + 5.0f,
                                                            0.0f,
                                                            CGRectGetWidth(itemView.bounds) - 5.0f - 16.0f - 5.0f - 5.0f,
                                                            CGRectGetHeight(itemView.bounds))];
        content.font = [UIFont systemFontOfSize:12 weight:UIFontWeightMedium];
        content.textColor = RGBCOLOR(101, 179, 249);
        content.tag = 1001;
        [itemView addSubview:content];
    }
}

- (void)updateItemView:(UIView*)itemView
               atIndex:(NSUInteger)index
        forMarqueeView:(UUMarqueeView*)marqueeView {
    // 设定即将显示的条目内容，在每次marquee view滑动时被调用。
    // 'index'即为数据源数组的索引值。
    UILabel *content = [itemView viewWithTag:1001];
    content.text = self.scrollContentMutArr[index];
}

- (CGFloat)itemViewWidthAtIndex:(NSUInteger)index
                 forMarqueeView:(UUMarqueeView*)marqueeView {
    // 指定条目在显示数据源内容时的视图宽度，仅[UUMarqueeViewDirectionLeftward]时被调用。
    // ### 在数据源不变的情况下，宽度可以仅计算一次并缓存复用。
    UILabel *content = UILabel.new;//没有进行持有，厨房放作用域即被销毁，这里仅仅是求得一个尺寸
    content.font = [UIFont systemFontOfSize:12 weight:UIFontWeightMedium];
    content.text = self.scrollContentMutArr[index];
    return content.intrinsicContentSize.width;
}

- (void)didTouchItemViewAtIndex:(NSUInteger)index
                 forMarqueeView:(UUMarqueeView*)marqueeView {
    // 点击事件回调。在'touchEnabled'设置为YES后，触发点击事件时被调用。
    NSLog(@"Touch at index %lu", (unsigned long)index);
}
#pragma mark —— LazyLoad
-(UUMarqueeView *)scrollLabelView{
    if (!_scrollLabelView) {
        _scrollLabelView = [[UUMarqueeView alloc] initWithFrame:CGRectMake(0,
                                                                           0,
                                                                           MAINSCREEN_WIDTH,
                                                                           ScrollLabelViewHeight)
                                                      direction:UUMarqueeViewDirectionLeftward];
        _scrollLabelView.delegate = self;
        _scrollLabelView.backgroundColor = RGBCOLOR(212, 232, 247);
        _scrollLabelView.timeIntervalPerScroll = 2.0f;    // 条目滑动间隔
        _scrollLabelView.scrollSpeed = 60.0f;    // 滑动速度
        _scrollLabelView.itemSpacing = 20.0f;    // 左右相邻两个条目的间距，当左侧条目内容的长度超出marquee view整体长度时有效
        _scrollLabelView.touchEnabled = YES;    // 设置为YES可监听点击事件，默认值为NO
        [self.view addSubview:_scrollLabelView];
        [_scrollLabelView reloadData];
        [_scrollLabelView start];
    }return _scrollLabelView;
}

-(NSMutableArray *)scrollContentMutArr{
    if (!_scrollContentMutArr) {
        _scrollContentMutArr = NSMutableArray.array;
        [_scrollContentMutArr addObject:@"活动广告公告信息_1"];
        [_scrollContentMutArr addObject:@"活动广告公告信息_2"];
        [_scrollContentMutArr addObject:@"活动广告公告信息_3"];
    }return _scrollContentMutArr;
}

@end
