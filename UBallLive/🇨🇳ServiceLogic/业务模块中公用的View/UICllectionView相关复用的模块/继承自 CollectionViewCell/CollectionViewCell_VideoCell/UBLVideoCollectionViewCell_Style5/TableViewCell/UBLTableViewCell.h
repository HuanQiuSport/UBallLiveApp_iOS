//
//  TableViewCell.h
//  UBallLive
//
//  Created by Jobs on 2020/10/20.
//

#import <UIKit/UIKit.h>
#import "UITableViewCell+Margin.h"

NS_ASSUME_NONNULL_BEGIN

@interface UBLTableViewCell : UITableViewCell

+(instancetype)cellWithTableView:(UITableView *)tableView;
+(CGFloat)cellHeightWithModel:(id _Nullable)model;
-(void)richElementsInCellWithModel:(id _Nullable)model;

@end

NS_ASSUME_NONNULL_END
