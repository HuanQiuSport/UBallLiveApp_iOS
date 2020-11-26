//
//  VideoCollectionViewCell@Style1.h
//  UBallLive
//
//  Created by Jobs on 2020/10/18.
//

#import <UIKit/UIKit.h>
#import "CollectionViewCell.h"

NS_ASSUME_NONNULL_BEGIN
//静态图 + 动图 + 取得信号源以后的视频播放
@interface UBLVideoCollectionViewCell_Style1 : CollectionViewCell

@property(nonatomic,strong,nullable)ZFPlayerController *player;
@property(nonatomic,strong)NSIndexPath *indexPath;

@end

NS_ASSUME_NONNULL_END
