//
//  UBLMyTBVCell.h
//  UBallLive
//
//  Created by Jobs on 2020/11/19.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class UBLMineInfoModel;

@interface UBLMyTBVCell : UITableViewCell

+(instancetype)cellWithTableView:(UITableView *)tableView;
+(CGFloat)cellHeightWithModel:(id _Nullable)model;
-(void)richElementsInCellWithModel:(id _Nullable)model;

/// 数据model
@property (nonatomic, strong) UBLMineInfoModel *mineInfoModel;
/// 头像图标
@property (nonatomic, strong) UIImage *headImage;

@end

NS_ASSUME_NONNULL_END
