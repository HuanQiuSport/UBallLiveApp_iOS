//
//  UIView+ZFPlayer.h
//  UBallLive
//
//  Created by Jobs on 2020/11/3.
//

#import <UIKit/UIKit.h>

#pragma mark —— ZFPlayer 播放器相关
//Core
#import "ZFPlayer.h"
//AVPlayer
#import <ZFPlayer/ZFAVPlayerManager.h>
//ijkplayer
#import <ZFPlayer/ZFIJKPlayerManager.h>
//ControlView
#import <ZFPlayer/UIImageView+ZFCache.h>
#import <ZFPlayer/UIView+ZFFrame.h>
#import <ZFPlayer/ZFLandScapeControlView.h>
#import <ZFPlayer/ZFLoadingView.h>
#import <ZFPlayer/ZFNetworkSpeedMonitor.h>
#import <ZFPlayer/ZFPlayerControlView.h>
#import <ZFPlayer/ZFPortraitControlView.h>
#import <ZFPlayer/ZFSliderView.h>
#import <ZFPlayer/ZFSmallFloatControlView.h>
#import <ZFPlayer/ZFSpeedLoadingView.h>
#import <ZFPlayer/ZFUtilities.h>
#import <ZFPlayer/ZFVolumeBrightnessView.h>

#import "CustomZFPlayerControlView.h"//播放器控制层

NS_ASSUME_NONNULL_BEGIN

@interface UIView (ZFPlayer)
/// 友情提醒，注意代码规范，先配置后播放，否则可能出现各种错
@property(nonatomic,strong,nullable)ZFPlayerController *playerCtr;
@property(nonatomic,strong,nullable)ZFAVPlayerManager *avPlayerManager;//默认不支持FLV流视频格式的
@property(nonatomic,strong,nullable)ZFIJKPlayerManager *ijkPlayerManager;//ZFPlayer的作者告诉我：如果要兼容FLV流视频格式请用这个
@property(nonatomic,strong,nullable)CustomZFPlayerControlView *customPlayerControlView;

-(void)enterBackgroundStopPlayer;

@end

NS_ASSUME_NONNULL_END

/** 用法
 self.playerManager.assetURL = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"iph_X" ofType:@"mp4"]];
 @weakify(self)
 [self.customPlayerControlView actionCustomZFPlayerControlViewBlock:^(NSString *data, NSNumber *data2) {
     @strongify(self)
     if ([data isEqualToString:@"gestureSingleTapped:"]) {
         if (self.livingVideoViewBlock) {
             self.livingVideoViewBlock(data);
         }
     }
 }];
 */
