//
//  UBLVideoVC.m
//  UBallLive
//
//  Created by Jobs on 2020/10/25.
//

#import "UBLVideoVC.h"
#import "UBLVideoTBVCell.h"

#import "UBLTableView.h"

#import "UBLVideoTimeTableViewHeaderView.h"

@interface UBLVideoVC ()
<
UITableViewDelegate
,UITableViewDataSource
>

@property(nonatomic,strong)UBLTableView *tableView;

@end

@implementation UBLVideoVC

- (void)dealloc {
    NSLog(@"Running self.class = %@;NSStringFromSelector(_cmd) = '%@';__FUNCTION__ = %s", self.class, NSStringFromSelector(_cmd),__FUNCTION__);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = RGBCOLOR(248, 248, 248);
    self.tableView.alpha = 1;
}
#pragma mark —————————— UITableViewDelegate,UITableViewDataSource ——————————
-(CGFloat)tableView:(UITableView *)tableView
heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [UBLVideoTBVCell cellHeightWithModel:nil];
}

-(void)tableView:(UITableView *)tableView
didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

}

-(NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section{
    return 2;
}

-(UITableViewCell *)tableView:(UITableView *)tableView
        cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UBLVideoTBVCell *cell = [UBLVideoTBVCell cellWithTableView:tableView];
    cell.indexRow = indexPath.row;
    cell.indexSection = indexPath.section;
    [cell richElementsInCellWithModel:nil];
    return cell;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 20;
}

-(CGFloat)tableView:(UITableView *)tableView
heightForHeaderInSection:(NSInteger)section{
    return 50;
}

-(UIView *)tableView:(UITableView *)tableView
viewForHeaderInSection:(NSInteger)section{
    UBLVideoTimeTableViewHeaderView *header = [[UBLVideoTimeTableViewHeaderView alloc] initWithReuseIdentifier:NSStringFromClass(UBLVideoTimeTableViewHeaderView.class)
                                                                                              withData:nil];
    self.scrollViewClass = UBLTableView.class;//这一属性决定UITableViewHeaderFooterView是否悬停
    header.indexSection = section;
    return header;
}
#pragma mark —— lazyLoad
-(UBLTableView *)tableView{
    if (!_tableView) {
        _tableView = UBLTableView.new;
        _tableView.backgroundColor = [UIColor colorWithPatternImage:KIMG(@"桌布")];
        _tableView.pagingEnabled = YES;//这个属性为YES会使得Tableview一格一格的翻动
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView registerClass:UBLVideoTimeTableViewHeaderView.class
forHeaderFooterViewReuseIdentifier:NSStringFromClass(UBLVideoTimeTableViewHeaderView.class)];
//        _tableView.mj_footer.automaticallyHidden = NO;//默认根据数据来源 自动显示 隐藏footer，这个功能可以关闭
//        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cellId"];
        [self.scrollView addSubview:_tableView];
        [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.view).with.insets(UIEdgeInsetsMake(10, 10, 10, 10));
        }];
        [self.view layoutIfNeeded];
        _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        _tableView.estimatedRowHeight = 0;
        _tableView.estimatedSectionFooterHeight = 0;
        _tableView.estimatedSectionHeaderHeight = 0;

        [UIView makeTargetShadowview:_tableView
                           superView:self.view
                     shadowDirection:ShadowDirection_rightDown
                   shadowWithOffsetX:5
                             offsetY:5
                        cornerRadius:8
                        shadowOffset:defaultSize
                       shadowOpacity:1
                    layerShadowColor:defaultObj
                   layerShadowRadius:defaultValue];
        
//        _tableView.mj_header = self.tableViewHeader;
//        _tableView.mj_footer = self.tableViewFooter;
//        _tableView.mj_footer.hidden = NO;
//        _tableView.ly_emptyView = [EmptyView emptyViewWithImageStr:@"Indeterminate Spinner - Small"
//                                                          titleStr:@""
//                                                         detailStr:@""];
//        if (self.walletMyFlowsListModelMutArr.count) {
//            [_tableView ly_hideEmptyView];
//        }else{
//            [_tableView ly_showEmptyView];
//        }
    }return _tableView;
}



@end
