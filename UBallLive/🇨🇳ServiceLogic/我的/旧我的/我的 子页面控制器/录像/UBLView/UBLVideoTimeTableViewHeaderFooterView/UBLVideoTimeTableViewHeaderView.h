//
//  VideoTimeHoveringHeaderView.h
//  UBallLive
//
//  Created by Jobs on 2020/10/27.
//

#import "ViewForTableViewHeader.h"

NS_ASSUME_NONNULL_BEGIN

@interface UBLVideoTimeTableViewHeaderView : ViewForTableViewHeader

@property(nonatomic,assign)long indexSection;

-(instancetype)initWithReuseIdentifier:(nullable NSString *)reuseIdentifier
                              withData:(id _Nullable)data;

-(void)actionBlockVideoTimeHoveringHeaderView:(MKDataBlock _Nullable)videoTimeHoveringHeaderViewBlock;

@end

NS_ASSUME_NONNULL_END
