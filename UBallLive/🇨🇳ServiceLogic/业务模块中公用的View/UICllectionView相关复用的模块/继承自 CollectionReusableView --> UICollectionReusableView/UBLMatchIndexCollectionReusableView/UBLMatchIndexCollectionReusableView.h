//
//  UBLMatchIndexCollectionReusableView.h
//  UBallLive
//
//  Created by Jobs on 2020/11/8.
//

#import "CollectionReusableView.h"

typedef enum :NSInteger{
    MatchIndexTypeUnKnown      = 0,             //未定义
    MatchIndexType_EuropeanOdds      = 1,             //欧赔
    MatchIndexType_Ball         = 2,             //大小球、让球
}MatchIndexType;

NS_ASSUME_NONNULL_BEGIN

@interface UBLMatchIndexCollectionReusableView : CollectionReusableView

@property(nonatomic,assign)MatchIndexType indexType;

@end

NS_ASSUME_NONNULL_END
