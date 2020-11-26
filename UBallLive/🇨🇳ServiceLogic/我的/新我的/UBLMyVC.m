//
//  UBLMyVC.m
//  UBallLive
//
//  Created by Jobs on 2020/11/19.
//

#import "UBLMyVC.h"

#import "UBLMineInfoModel.h"

@interface UBLMyVC ()
<
UITableViewDelegate
,UITableViewDataSource
>

@property(nonatomic,strong)UITableView *tableView;//显示数据
@property(nonatomic,strong)UIButton *logOutBtn;
@property(nonatomic,strong)UIColor *bgColour;
@property(nonatomic,strong) NSMutableArray *titleMutArr;
//data 临时数据
@property(nonatomic,strong) NSMutableArray <NSMutableArray *>*detailTextMutArr;

@end

@implementation UBLMyVC

- (void)dealloc {
    NSLog(@"Running self.class = %@;NSStringFromSelector(_cmd) = '%@';__FUNCTION__ = %s", self.class, NSStringFromSelector(_cmd),__FUNCTION__);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.isHiddenNavigationBar = YES;//禁用系统的导航栏
    self.gk_navTitle = @"我的";
    self.gk_navTitleColor = kBlackColor;
    [self hideNavLine];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.view.backgroundColor = self.bgColour;
    self.tableView.alpha = 1;
    self.logOutBtn.alpha = 1;
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}
// 拍照
-(void)takePhoto{
    [self pushImagePickerController];
}
// 从相册选取
-(void)album{
    self.imagePickerVC = Nil;
    @weakify(self)
    [self choosePic:TZImagePickerControllerType_1 imagePickerVCBlock:^(id data) {
        @strongify(self)
        self.imagePickerVC.allowPickingVideo = NO;
        self.imagePickerVC.allowPickingImage = YES;
        self.imagePickerVC.allowPickingOriginalPhoto = YES;
        self.imagePickerVC.allowPickingGif = YES;
        self.imagePickerVC.allowPickingMultipleVideo = NO;
    }];
    [self GettingPicBlock:^(id firstArg, ...)NS_REQUIRES_NIL_TERMINATION{
        @strongify(self)
        if (firstArg) {
            // 取出第一个参数
            NSLog(@"%@", firstArg);
            // 定义一个指向个数可变的参数列表指针；
            va_list args;
            // 用于存放取出的参数
            id arg = nil;
            // 初始化变量刚定义的va_list变量，这个宏的第二个参数是第一个可变参数的前一个参数，是一个固定的参数
            va_start(args, firstArg);
            // 遍历全部参数 va_arg返回可变的参数(a_arg的第二个参数是你要返回的参数的类型)
            if ([firstArg isKindOfClass:NSNumber.class]) {
                NSNumber *num = (NSNumber *)firstArg;
                for (int i = 0; i < num.intValue; i++) {
                    arg = va_arg(args, id);
//                    NSLog(@"KKK = %@", arg);
                    if ([arg isKindOfClass:UIImage.class]) {
                        NSLog(@"");
                    }
                }
            }else{
                NSLog(@"");
            }
            // 清空参数列表，并置参数指针args无效
            va_end(args);
        }
    }];
}
#pragma mark —— UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker
didFinishPickingMediaWithInfo:(NSDictionary<UIImagePickerControllerInfoKey, id> *)info{
    NSLog(@"");
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    NSLog(@"");
    [picker dismissViewControllerAnimated:YES completion:nil];
}
#pragma mark —————————— UITableViewDelegate,UITableViewDataSource ——————————
-(CGFloat)tableView:(UITableView *)tableView
heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}

-(void)tableView:(UITableView *)tableView
didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0 && indexPath.row == 0) {
        [NSObject showSYSActionSheetTitle:nil
                                  message:nil
                          isSeparateStyle:YES
                              btnTitleArr:@[@"拍照",@"从相册选取",@"取消"]
                           alertBtnAction:@[@"takePhoto",@"album",@""]
                                 targetVC:self
                                   sender:nil
                             alertVCBlock:^(id data) {

        }];
    }
}

-(NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section{
    return [self.titleMutArr[section] count];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.titleMutArr.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView
        cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UBLMyTBVCell *cell = [UBLMyTBVCell cellWithTableView:tableView];
    
    if (0 == indexPath.section  && 0 == indexPath.row) {
        // 赋值
        cell.headImage = KBuddleIMG(@"⚽️PicResource", @"头像", nil, @"头像_1");
    }
    // 赋值model
    cell.mineInfoModel = self.titleMutArr[indexPath.section][indexPath.row];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView
heightForHeaderInSection:(NSInteger)section{
    return 10;
}

-(UIView *)tableView:(UITableView *)tableView
viewForHeaderInSection:(NSInteger)section{
    return UIView.new;
}
#pragma mark —— lazyLoad
-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = UITableView.new;
        _tableView.backgroundColor = self.bgColour;
        _tableView.pagingEnabled = YES;//这个属性为YES会使得Tableview一格一格的翻动
//        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = UIView.new;
        [self.view addSubview:_tableView];
        [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            if (self.gk_navBarAlpha && !self.gk_navigationBar.hidden) {//显示
                make.top.equalTo(self.gk_navigationBar.mas_bottom);
            }else{
                make.top.equalTo(self.view.mas_top);
            }
            make.left.right.equalTo(self.view);
            make.height.mas_equalTo(220);
        }];
        [self.view layoutIfNeeded];
        _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;

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

-(UIButton *)logOutBtn{
    if (!_logOutBtn) {
        _logOutBtn = UIButton.new;
        _logOutBtn.backgroundColor = [UIColor colorWithPatternImage:KBuddleIMG(@"⚽️PicResource", @"Others", nil, @"退出登录渐变色底图")];
        _logOutBtn.titleLabel.font = [UIFont systemFontOfSize:16 weight:UIFontWeightRegular];
        [_logOutBtn setTitle:@"退出登录"
                    forState:UIControlStateNormal];
        [_logOutBtn setTitleColor:kWhiteColor
                         forState:UIControlStateNormal];
        @weakify(self)
        [[_logOutBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
            @strongify(self)
            NSLog(@"退出登录");
        }];
        [self.view addSubview:_logOutBtn];
        [_logOutBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.view);
            make.size.mas_equalTo(CGSizeMake(347, 46));
            make.top.equalTo(self.tableView.mas_bottom).offset(28);
        }];
        [UIView cornerCutToCircleWithView:_logOutBtn AndCornerRadius:3];
    }return _logOutBtn;
}

-(UIColor *)bgColour{
    if (!_bgColour) {
        _bgColour = RGBCOLOR(246, 246, 246);
    }return _bgColour;
}

- (NSMutableArray *)titleMutArr{
    if (!_titleMutArr) {
       
        UBLMineInfoModel *photoModel = [[UBLMineInfoModel alloc] init];
        photoModel.leftStr = @"头像";
        photoModel.rightStr = @"";
        
        UBLMineInfoModel *nameModel = [[UBLMineInfoModel alloc] init];
        nameModel.leftStr = @"昵称";
        nameModel.rightStr = @"yico专属";
        
        UBLMineInfoModel *phoneModel = [[UBLMineInfoModel alloc] init];
        phoneModel.leftStr = @"手机号码";
        phoneModel.rightStr = @"134****1107";
        
        UBLMineInfoModel *mailModel = [[UBLMineInfoModel alloc] init];
        mailModel.leftStr = @"绑定邮箱";
        mailModel.rightStr = @"135****4657";
        
//        NSMutableArray *section0 = NSMutableArray.array;
//        [section0 addObject:@"头像"];
//        [section0 addObject:@"昵称"];
//
//        NSMutableArray *section1 = NSMutableArray.array;
//        [section1 addObject:@"手机号码"];
//        [section1 addObject:@"绑定邮箱"];
//
//        [_titleMutArr addObject:section0];
//        [_titleMutArr addObject:section1];
        
        NSArray *section0Arr = [NSArray arrayWithObjects:photoModel, nameModel,nil];
        
        NSArray *section1Arr = [NSArray arrayWithObjects:phoneModel, mailModel,nil];
        
        _titleMutArr = [NSMutableArray arrayWithObjects:section0Arr,section1Arr, nil];
        
    }return _titleMutArr;
}

-(NSMutableArray<NSMutableArray *> *)detailTextMutArr{
    if (!_detailTextMutArr) {
        _detailTextMutArr = NSMutableArray.array;
        
        NSMutableArray *section0 = NSMutableArray.array;
        [section0 addObject:UIImage.new];
        [section0 addObject:@"yico专属"];
        
        NSMutableArray *section1 = NSMutableArray.array;
        [section1 addObject:@"134****1107"];
        [section1 addObject:@"135****4657"];
        
        [_detailTextMutArr addObject:section0];
        [_detailTextMutArr addObject:section1];
        
    }return _detailTextMutArr;
}

@end
