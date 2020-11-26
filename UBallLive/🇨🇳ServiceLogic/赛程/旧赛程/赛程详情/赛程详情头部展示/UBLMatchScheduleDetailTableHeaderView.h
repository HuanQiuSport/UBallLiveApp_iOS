//
//  UBLMatchScheduleDetailTableHeaderView.h
//  UBallLive
//
//  Created by Jobs on 2020/11/2.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    MidView_Style1 = 0,
    MidView_Style2,
    MidView_Style3,
    MidView_Style4
} MidView_Style;

NS_ASSUME_NONNULL_BEGIN

@interface UBLMatchScheduleDetailTableHeaderView : UIView

@property(nonatomic,assign)BOOL isZoom;
@property(nonatomic,assign)MidView_Style midView_Style;

-(void)actiobBlockMatchScheduleDetailTableHeaderView:(MKDataBlock)matchScheduleDetailTableHeaderViewBlock;
-(void)scrollViewDidScroll:(CGFloat)contentOffsetY;

@end

NS_ASSUME_NONNULL_END
