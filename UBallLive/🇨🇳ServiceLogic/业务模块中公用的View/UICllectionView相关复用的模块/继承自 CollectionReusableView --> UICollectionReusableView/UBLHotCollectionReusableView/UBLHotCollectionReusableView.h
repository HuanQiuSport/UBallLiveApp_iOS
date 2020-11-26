//
//  HotCollectionReusableView.h
//  UBallLive
//
//  Created by Jobs on 2020/10/29.
//

#import "CollectionReusableView.h"

NS_ASSUME_NONNULL_BEGIN

@interface UBLHotCollectionReusableView : CollectionReusableView

@property(nonatomic,strong)UIImage *image;
@property(nonatomic,strong)NSString *titleStr;
@property(nonatomic,assign)BOOL isShowAllBtn;


-(void)actionBlockHotCollectionReusableView:(MKDataBlock _Nullable)hotCollectionReusableViewBlock;

@end

NS_ASSUME_NONNULL_END
