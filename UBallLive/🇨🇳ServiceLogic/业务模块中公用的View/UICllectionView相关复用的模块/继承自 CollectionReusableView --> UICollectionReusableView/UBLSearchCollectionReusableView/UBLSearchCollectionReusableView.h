//
//  UBLSearchCollectionReusableView.h
//  UBallLive
//
//  Created by Jobs on 2020/10/30.
//

#import "CollectionReusableView.h"

NS_ASSUME_NONNULL_BEGIN

@interface UBLSearchCollectionReusableView : CollectionReusableView

//data
@property(nonatomic,strong)UIImage *img;
@property(nonatomic,strong)NSString *titleStr;
@property(nonatomic,assign)BOOL isShowMoreBtn;

-(void)actionBlockSearchCollectionReusableView:(MKDataBlock _Nullable)searchCollectionReusableViewBlock;

@end

NS_ASSUME_NONNULL_END
