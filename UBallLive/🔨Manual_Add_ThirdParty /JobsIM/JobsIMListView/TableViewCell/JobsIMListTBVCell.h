//
//  JobsIMListTBVCell.h
//  JobsIM
//
//  Created by Jobs on 2020/11/17.
//

#import <UIKit/UIKit.h>
#import "MGSwipeButtonModel.h"
#import "JobsIMListDataModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface JobsIMListTBVCell : MGSwipeTableCell

+(instancetype)cellWithTableView:(UITableView *)tableView;
+(CGFloat)cellHeightWithModel:(id _Nullable)model;
-(void)richElementsInCellWithModel:(id _Nullable)model;

@end

NS_ASSUME_NONNULL_END
