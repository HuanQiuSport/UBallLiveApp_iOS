//
//  VideoCollectionViewCell@Style5.m
//  UBallLive
//
//  Created by Jobs on 2020/10/20.
//

#import "UBLVideoCollectionViewCell@Style5.h"
#import "UBLTableViewCell.h"

@interface UBLVideoCollectionViewCell_Style5 ()
<
UITableViewDelegate
,UITableViewDataSource
>

@property(nonatomic,strong)UITableView *tableview;

@end

@implementation UBLVideoCollectionViewCell_Style5

-(void)dealloc {
    NSLog(@"Running self.class = %@;NSStringFromSelector(_cmd) = '%@';__FUNCTION__ = %s", self.class, NSStringFromSelector(_cmd),__FUNCTION__);
}

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {

    }return self;
}

-(void)richElementsInCellWithModel:(id _Nullable)model{
    self.tableview.alpha = 1;
//    [UIView setTransform:90/180 forView:self.tableview];
}

+(CGSize)cellSizeWithModel:(id _Nullable)model{
    return CGSizeMake(MAINSCREEN_WIDTH, 96);;
}
#pragma mark —————————— UITableViewDelegate,UITableViewDataSource ——————————
-(CGFloat)tableView:(UITableView *)tableView
heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [UBLTableViewCell cellHeightWithModel:nil];
}

-(void)tableView:(UITableView *)tableView
didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

}

-(NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section{
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView
        cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UBLTableViewCell *cell = [UBLTableViewCell cellWithTableView:tableView];
    cell.indexPath = indexPath;
    [cell richElementsInCellWithModel:nil];
    return cell;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 10;
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
-(UITableView *)tableview{
    if (!_tableview) {
        _tableview = UITableView.new;
        _tableview.backgroundColor = RGBCOLOR(246, 246, 246);
        _tableview.delegate = self;
        _tableview.dataSource = self;
        _tableview.showsHorizontalScrollIndicator = NO;
        _tableview.showsVerticalScrollIndicator = NO;
        [self.contentView addSubview:_tableview];
#warning 手把手教你怎么旋转
        _tableview.frame = CGRectMake(0,
                                      0,
                                      self.contentView.mj_h,
                                      self.contentView.mj_w);
        _tableview.center = self.contentView.center;//必须中间对准，否则转出毛病 xy异常
        _tableview.transform = CGAffineTransformMakeRotation(-M_PI / 2);
    }return _tableview;
}

@end
