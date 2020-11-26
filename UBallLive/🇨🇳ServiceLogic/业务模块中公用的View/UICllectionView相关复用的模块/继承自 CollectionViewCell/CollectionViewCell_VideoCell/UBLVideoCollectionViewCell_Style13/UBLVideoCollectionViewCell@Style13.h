//
//  UBLVideoCollectionViewCell@Style13.h
//  UBallLive
//
//  Created by Jobs on 2020/11/8.
//

#import "CollectionViewCell.h"

typedef NS_ENUM(NSUInteger, IntelligenceType) {
    IntelligenceTypeUnknown,
    IntelligenceTypeAdvantage,
    IntelligenceTypeDisadvantage,
    IntelligenceTypeNeutrality
};

NS_ASSUME_NONNULL_BEGIN

@interface UBLVideoCollectionViewCell_Style13 : CollectionViewCell

@property(nonatomic,assign)IntelligenceType intelligenceType;

@end

NS_ASSUME_NONNULL_END
