//
//  JobsIMVC.m
//  JobsIM
//
//  Created by Jobs on 2020/11/10.
//

#import "JobsIMVC.h"
#define isAllowSysEdit NO// 编译期就要优先进去，所以不能用属性

static inline CGFloat JobsIMInputviewHeight(){
    return 60;
}

@interface JobsIMVC ()
<
UITableViewDelegate
,UITableViewDataSource
,MGSwipeTableCellDelegate
>

@property(nonatomic,strong)JobsIMInputview *inputview;
@property(nonatomic,strong)UITableView *tableView;//显示数据
@property(nonatomic,strong)UIBarButtonItem *shareBtnItem;
@property(nonatomic,strong)UIButton *shareBtn;
@property(nonatomic,strong)UIColor *bgColour;
//data
@property(nonatomic,strong)NSMutableArray <JobsIMChatInfoModel *>*chatInfoModelMutArr;//聊天信息

@end

@implementation JobsIMVC

- (void)dealloc {
    NSLog(@"Running self.class = %@;NSStringFromSelector(_cmd) = '%@';__FUNCTION__ = %s", self.class, NSStringFromSelector(_cmd),__FUNCTION__);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = kWhiteColor;
    [self keyboard];
    [IQKeyboardManager sharedManager].enable = NO;//该页面禁用

    if ([self.requestParams isKindOfClass:JobsIMChatInfoModel.class]) {
        JobsIMChatInfoModel *chatInfoModel = (JobsIMChatInfoModel *)self.requestParams;
        [self.chatInfoModelMutArr addObject:chatInfoModel];
        self.gk_navTitle = chatInfoModel.senderUserNameStr;
    }
    
    if (self.navigationController.viewControllers.count - 1) {//从上个页面推过来才有返回键，直接的个人中心是没有的
        self.gk_navLeftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.backBtnCategory];
    }
    
    self.gk_navRightBarButtonItems = @[self.shareBtnItem];
    self.gk_navBackgroundColor = KLightGrayColor;
    
    self.inputview.alpha = 1;
    self.tableView.alpha = 1;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.isHiddenNavigationBar = YES;//禁用系统的导航栏
}

-(void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
}
//必须这么写。在输入的时候会调用UIKeyboardWillChangeFrameNotification，只有在这里强制性的赋值
-(void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    if (self.inputview.inputTextField.TFRiseHeight) {
        self.inputview.mj_y = self.inputview.inputTextField.TFRiseHeight;
    }
}
///下拉刷新
-(void)pullToRefresh{
    NSLog(@"下拉刷新");
    [self.tableView.mj_header endRefreshing];
//
}
///上拉加载更多
- (void)loadMoreRefresh{
    NSLog(@"上拉加载更多");
//    [self.tableView reloadData];
    //特别说明：pagingEnabled = YES 在此会影响Cell的偏移量，原作者希望我们在这里临时关闭一下，刷新完成以后再打开
    self.tableView.pagingEnabled = NO;
    [self performSelector:@selector(delayMethods)
               withObject:nil
               afterDelay:2];
}

-(void)delayMethods{
    self.tableView.mj_footer.state = MJRefreshStateIdle;
    self.tableView.mj_footer.hidden = YES;
    self.tableView.pagingEnabled = YES;
//    [self.mj_footer endRefreshingWithNoMoreData];
}

-(void)keyboard{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillChangeFrameNotification:)
                                                 name:UIKeyboardWillChangeFrameNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardDidChangeFrameNotification:)
                                                 name:UIKeyboardDidChangeFrameNotification
                                               object:nil];
}
//键盘 弹出 和 收回 走这个方法
-(void)keyboardWillChangeFrameNotification:(NSNotification *)notification{
    NSDictionary *userInfo = notification.userInfo;
    CGRect beginFrame = [userInfo[UIKeyboardFrameBeginUserInfoKey] CGRectValue];
    CGRect endFrame = [userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGFloat KeyboardOffsetY = beginFrame.origin.y - endFrame.origin.y;// 正则抬起 ，负值下降
    NSLog(@"KeyboardOffsetY = %f",KeyboardOffsetY);
    NSLog(@"BottomSafeAreaHeight = %f",BottomSafeAreaHeight());
 
    if (KeyboardOffsetY > 0) {
        NSLog(@"键盘抬起");
        KeyboardOffsetY -= BottomSafeAreaHeight();
    }else if(KeyboardOffsetY < 0){
        NSLog(@"键盘收回");
        KeyboardOffsetY += BottomSafeAreaHeight();
    }else{
        NSLog(@"键盘");
    }
    
    self.inputview.inputTextField.TFRiseHeight = self.inputview.mj_y;
    self.inputview.inputTextField.TFRiseHeight -= KeyboardOffsetY;
    self.inputview.mj_y = self.inputview.inputTextField.TFRiseHeight;
}

-(void)keyboardDidChangeFrameNotification:(NSNotification *)notification{}

-(void)simulateServer{
    
    if ([self.requestParams isKindOfClass:JobsIMChatInfoModel.class]) {
        JobsIMChatInfoModel *requestParamsChatInfoModel = (JobsIMChatInfoModel *)self.requestParams;
        
        JobsIMChatInfoModel *chatInfoModel = JobsIMChatInfoModel.new;
        chatInfoModel.senderChatTextStr = @"有内鬼，取消交易";
        TimeModel *timeModel = TimeModel.new;
        [timeModel makeSpecificTime];
        chatInfoModel.senderChatTextTimeStr = [NSString stringWithFormat:@"%ld:%ld:%ld",timeModel.currentHour,timeModel.currentMin,timeModel.currentSec];
        chatInfoModel.senderChatUserIconIMG = requestParamsChatInfoModel.senderChatUserIconIMG;//KBuddleIMG(@"⚽️PicResource", @"头像", nil, @"头像_2");//我自己的头像
        chatInfoModel.identification = @"我是服务器";
        chatInfoModel.senderUserNameStr = requestParamsChatInfoModel.senderUserNameStr;
        
        [self.chatInfoModelMutArr addObject:chatInfoModel];
        [self.tableView reloadData];
    }
}
#pragma mark —————————— UITableViewDelegate,UITableViewDataSource ——————————
-(CGFloat)tableView:(UITableView *)tableView
heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [JobsIMChatInfoTBVCell cellHeightWithModel:self.chatInfoModelMutArr[indexPath.row]];
}

-(void)tableView:(UITableView *)tableView
didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

}

-(NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section{
    return self.chatInfoModelMutArr.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView
        cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    JobsIMChatInfoTBVCell *cell = [JobsIMChatInfoTBVCell cellWithTableView:tableView];
    cell.isShowChatUserName = YES;
    cell.indexPath = indexPath;
    cell.delegate = self;
    cell.allowsMultipleSwipe = YES;
    [cell richElementsInCellWithModel:self.chatInfoModelMutArr[indexPath.row]];
    return cell;
}
#if isAllowSysEdit
//右划
-(nullable UISwipeActionsConfiguration *)tableView:(UITableView *)tableView
 leadingSwipeActionsConfigurationForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (@available(iOS 11.0, *)) {
        UIContextualAction *deleteRowAction = [UIContextualAction contextualActionWithStyle:UIContextualActionStyleNormal
                                                                                      title:@"删除"
                                                                                    handler:^(UIContextualAction * _Nonnull action,
                                                                                              __kindof UIView * _Nonnull sourceView,
                                                                                              void (^ _Nonnull completionHandler)(BOOL)) {
            [WHToast showErrorWithMessage:@"删除"
                                 duration:2
                            finishHandler:^{
              
            }];
        }];
        //设置图片，但是设置不了原图，都是被默认为白色了，字体也是
        UIImage *image = [KBuddleIMG(@"⚽️PicResource", @"Others", nil, @"分享") imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        [deleteRowAction setImage:image];
        deleteRowAction.backgroundColor = [UIColor redColor];

        UIContextualAction *editRowAction = [UIContextualAction contextualActionWithStyle:UIContextualActionStyleNormal
                                                                                    title:@"编辑"
                                                                                  handler:^(UIContextualAction * _Nonnull action,
                                                                                            __kindof UIView * _Nonnull sourceView,
                                                                                            void (^ _Nonnull completionHandler)(BOOL)) {
            [WHToast showErrorWithMessage:@"编辑"
                                 duration:2
                            finishHandler:^{
              
            }];
        }];
        editRowAction.image = KBuddleIMG(@"⚽️PicResource", @"Others", nil, @"删除");
        editRowAction.backgroundColor = [UIColor blueColor];
        UISwipeActionsConfiguration *config = [UISwipeActionsConfiguration configurationWithActions:@[deleteRowAction,editRowAction]];
        //设置全屏滑动时不自定响应事件
        config.performsFirstActionWithFullSwipe = false;
        return config;
    }else{
        return nil;
    }
}
//左划
-(UISwipeActionsConfiguration *)tableView:(UITableView *)tableView
trailingSwipeActionsConfigurationForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (@available(iOS 11.0, *)) {
        UIContextualAction *deleteRowAction = [UIContextualAction contextualActionWithStyle:UIContextualActionStyleNormal
                                                                                      title:@"删除"
                                                                                    handler:^(UIContextualAction * _Nonnull action,
                                                                                              __kindof UIView * _Nonnull sourceView,
                                                                                              void (^ _Nonnull completionHandler)(BOOL)) {
        }];
        UIImage *image = [KBuddleIMG(@"⚽️PicResource", @"Others", nil, @"分享")  imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        [deleteRowAction setImage:image];
        deleteRowAction.backgroundColor = [UIColor redColor];
        UIContextualAction *editRowAction = [UIContextualAction contextualActionWithStyle:UIContextualActionStyleNormal
                                                                                    title:@"编辑"
                                                                                  handler:^(UIContextualAction * _Nonnull action,
                                                                                            __kindof UIView * _Nonnull sourceView,
                                                                                            void (^ _Nonnull completionHandler)(BOOL)) {
        }];
        editRowAction.image = KBuddleIMG(@"⚽️PicResource", @"Others", nil, @"删除");
        editRowAction.backgroundColor = [UIColor blueColor];

        UISwipeActionsConfiguration *config = [UISwipeActionsConfiguration configurationWithActions:@[deleteRowAction,editRowAction]];
        config.performsFirstActionWithFullSwipe = false;
        return config;
    }else{
        return nil;
    }
}
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
#pragma clang diagnostic ignored "-Wdeprecated-implementations"
-(NSArray<UITableViewRowAction *> *)tableView:(UITableView *)tableView
                 editActionsForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (@available(iOS 13.0, *)) {
        //UITableViewRowAction' is deprecated: first deprecated in iOS 13.0 - Use UIContextualAction and related APIs instead.
        return nil;
    }else{
        UITableViewRowAction *action = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleNormal
                                                                          title:@"删除"
                                                                        handler:^(UITableViewRowAction * _Nonnull action,
                                                                                  NSIndexPath * _Nonnull indexPath) {
            [WHToast showErrorWithMessage:@"删除"
                                 duration:2
                            finishHandler:^{
              
            }];
            // 点击删除按钮需要执行的方法
            [tableView setEditing:NO
                         animated:YES];
        }];
        // 修改背景颜色
        action.backgroundColor = HEXCOLOR(0xEB1163);
        return @[action];
    }
}
#pragma clang diagnostic pop
-(void)tableView:(UITableView *)tableView
willBeginEditingRowAtIndexPath:(NSIndexPath *)indexPath {
    // 在 iOS11 以下系统,因为方法线程问题,需要放到主线程执行, 不然没有效果
    dispatch_async(dispatch_get_main_queue(), ^{
        [self setupSlideBtnWithEditingIndexPath:indexPath];
    });
}
//MARK: 设置左滑按钮的样式
-(void)setupSlideBtnWithEditingIndexPath:(NSIndexPath *)editingIndexPath{
    // 判断系统是否是 iOS13 及以上版本
    if (@available(iOS 13.0, *)) {
        for (UIView *subView in self.tableView.subviews) {
            if ([subView isKindOfClass:NSClassFromString(@"_UITableViewCellSwipeContainerView")] && [subView.subviews count] >= 1) {
                // 修改图片
                UIView *remarkContentView = subView.subviews.firstObject;
                [self setupRowActionView:remarkContentView];
            }
        }
        return;
    }
    // 判断系统是否是 iOS11 及以上版本
    if (@available(iOS 11.0, *)) {
        for (UIView *subView in self.tableView.subviews) {
            if ([subView isKindOfClass:NSClassFromString(@"UISwipeActionPullView")] && [subView.subviews count] >= 1) {
                // 修改图片
                UIView *remarkContentView = subView;
                [self setupRowActionView:remarkContentView];
            }
        }
        return;
    }
    // iOS11 以下的版本
    JobsIMChatInfoTBVCell *cell = [self.tableView cellForRowAtIndexPath:editingIndexPath];
    for (UIView *subView in cell.subviews) {
        if ([subView isKindOfClass:NSClassFromString(@"UITableViewCellDeleteConfirmationView")] && [subView.subviews count] >= 1) {
            // 修改图片
            UIView *remarkContentView = subView;
            [self setupRowActionView:remarkContentView];
        }
    }
}

-(void)setupRowActionView:(UIView *)rowActionView{
    // 切割圆角
    [UIView cornerCutToCircleWithView:rowActionView AndCornerRadius:20];
    // 改变父 View 的frame，这句话是因为我在 contentView 里加了另一个 View，为了使划出的按钮能与其达到同一高度
    CGRect frame = rowActionView.frame;
    frame.origin.y += 7;
    frame.size.height -= 13;
    rowActionView.frame = frame;
    // 拿到按钮,设置图片
    UIButton *button = rowActionView.subviews.firstObject;
    button.backgroundColor = kRedColor;
    [button setImage:KBuddleIMG(@"⚽️PicResource", @"Others", nil, @"删除") forState:UIControlStateNormal];
    [button setTitle:@"删除" forState:UIControlStateNormal];
}
#endif

// USE_MG_DELEGATE
//-(NSArray *)swipeTableCell:(JobsIMChatInfoTBVCell *)cell
//  swipeButtonsForDirection:(MGSwipeDirection)direction
//             swipeSettings:(MGSwipeSettings *)swipeSettings
//         expansionSettings:(MGSwipeExpansionSettings *)expansionSettings{
//    if (direction == MGSwipeDirectionLeftToRight) {
//        return [cell createLeftButtons];
//    }else {
//        return [cell createRightButtons];
//    }
//}

-(void)swipeTableCellWillBeginSwiping:(nonnull MGSwipeTableCell *)cell{
    [NSObject feedbackGenerator];//震动反馈
}

// 点击了第几个滑动出现的按钮？
-(BOOL)swipeTableCell:(MGSwipeTableCell *)cell
  tappedButtonAtIndex:(NSInteger)index
            direction:(MGSwipeDirection)direction
        fromExpansion:(BOOL)fromExpansion{
    NSLog(@"Delegate: button tapped, %@ position, index %d, from Expansion: %@",direction == MGSwipeDirectionLeftToRight ? @"left" : @"right", (int)index, fromExpansion ? @"YES" : @"NO");
    return YES;
}
//
-(void)tableView:(UITableView *)tableView
accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"Tapped accessory button");
}
#pragma mark —— lazyLoad
-(JobsIMInputview *)inputview{
    if (!_inputview) {
        _inputview = JobsIMInputview.new;
        @weakify(self)
        [_inputview actionBlockJobsIMInputview:^(id data) {
            @strongify(self)
            if ([data isKindOfClass:ZYTextField.class]){
                ZYTextField *tf = (ZYTextField *)data;
                
                JobsIMChatInfoModel *chatInfoModel = JobsIMChatInfoModel.new;
                chatInfoModel.senderChatTextStr = tf.text;
                TimeModel *timeModel = TimeModel.new;
                [timeModel makeSpecificTime];
                chatInfoModel.senderChatTextTimeStr = [NSString stringWithFormat:@"%ld:%ld:%ld",timeModel.currentHour,timeModel.currentMin,timeModel.currentSec];
                chatInfoModel.senderChatUserIconIMG = KBuddleIMG(@"⚽️PicResource", @"头像", nil, @"头像_1");//我自己的头像
                chatInfoModel.identification = @"我是我自己";
                chatInfoModel.senderUserNameStr = @"Jobs";
                
                [self.chatInfoModelMutArr addObject:chatInfoModel];
                [self.tableView reloadData];
                
                [self simulateServer];
                
            }else{}
        }];
        [self.view addSubview:_inputview];
        [_inputview mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(JobsIMInputviewHeight());
            make.left.right.equalTo(self.view);
            NSLog(@"%f",BottomSafeAreaHeight());
            make.bottom.equalTo(self.view).offset(-BottomSafeAreaHeight());
        }];
    }return _inputview;
}

-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = UITableView.new;
        _tableView.backgroundColor = self.bgColour;
        _tableView.pagingEnabled = YES;//这个属性为YES会使得Tableview一格一格的翻动
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [self.view insertSubview:_tableView belowSubview:self.inputview];
        [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            if (self.gk_navBarAlpha && !self.gk_navigationBar.hidden) {//显示
                make.top.equalTo(self.gk_navigationBar.mas_bottom);
            }else{
                make.top.equalTo(self.view.mas_top);
            }
            make.left.right.equalTo(self.view);
            make.bottom.equalTo(self.inputview.mas_top);
        }];
        [self.view layoutIfNeeded];
        _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        _tableView.ly_emptyView = [LYEmptyView emptyViewWithImageStr:@"noData"
                                                            titleStr:@"暂无数据"
                                                           detailStr:@""];
        
        if (self.chatInfoModelMutArr.count) {
            [_tableView ly_hideEmptyView];
        }else{
            [_tableView ly_showEmptyView];
        }
        
//        _tableView.mj_header = MJRefreshWithLottieTableViewHeader.new;
//        _tableView.mj_header.jsonString = @"12345.json";
//        [_tableView.mj_header beginRefreshing];
        _tableView.mj_footer.hidden = NO;
        
        @weakify(self)
        _tableView.mj_header = [CustomGifHeader headerWithRefreshingBlock:^{
            @strongify(self)
            sleep(3);
            [self pullToRefresh];
        }];
        
    }return _tableView;
}

-(NSMutableArray<JobsIMChatInfoModel *> *)chatInfoModelMutArr{
    if (!_chatInfoModelMutArr) {
        _chatInfoModelMutArr = NSMutableArray.array;
    }return _chatInfoModelMutArr;
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
            [NSObject showSYSAlertViewTitle:@"正在研发中..."
                                    message:@"敬请期待"
                            isSeparateStyle:NO
                                btnTitleArr:@[@"好的"]
                             alertBtnAction:@[@""]
                                   targetVC:self
                               alertVCBlock:^(id data) {
                //DIY
            }];
        }];
    }return _shareBtn;
}

-(UIBarButtonItem *)shareBtnItem{
    if (!_shareBtnItem) {
        _shareBtnItem = [[UIBarButtonItem alloc] initWithCustomView:self.shareBtn];
    }return _shareBtnItem;
}

-(UIColor *)bgColour{
    if (!_bgColour) {
        _bgColour = [UIColor colorWithPatternImage:KBuddleIMG(@"⚽️PicResource", @"Telegram",nil, @"1")];
    }return _bgColour;
}

@end
