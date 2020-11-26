//
//  JobsIMListView.h
//  JobsIM
//
//  Created by Jobs on 2020/11/17.
//

#import <UIKit/UIKit.h>

#if __has_include(<MGSwipeTableCell/MGSwipeTableCell.h>)
#import <MGSwipeTableCell/MGSwipeTableCell.h>
#else
#import "MGSwipeTableCell.h"
#endif

#import "JobsIMListTBVCell.h"
#import "CustomGifHeader.h"
#import "JobsIMListDataModel.h"
#import "UIImage+YBGIF.h"

NS_ASSUME_NONNULL_BEGIN

@interface JobsIMListView : UIView

-(void)actionBlockJobsIMListView:(MKDataBlock)jobsIMListViewBlock;

@end

NS_ASSUME_NONNULL_END
