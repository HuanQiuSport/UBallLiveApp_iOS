//
//  Pods.h
//  My_BaseProj
//
//  Created by 刘赓 on 2019/9/26.
//  Copyright © 2019 Corp. All rights reserved.
//

#ifndef Pods_h
#define Pods_h

#if DEBUG

#if __has_include(<FBRetainCycleDetector/FBRetainCycleDetector.h>)
#import <FBRetainCycleDetector/FBRetainCycleDetector.h>
#else
#import "FBRetainCycleDetector.h"
#endif

#if __has_include(<DoraemonManager/DoraemonManager.h>)
#import <DoraemonKit/DoraemonManager.h>
#else
#import "DoraemonManager.h"
#endif

#endif

#if __has_include(<IQKeyboardManager/IQKeyboardManager.h>)
#import <IQKeyboardManager/IQKeyboardManager.h>
#else
#import "IQKeyboardManager.h"
#endif

#if __has_include(<Masonry/Masonry.h>)
#import <Masonry/Masonry.h>
#else
#import "Masonry.h"
#endif

#if __has_include(<Reachability/Reachability.h>)
#import <Reachability/Reachability.h>
#else
#import "Reachability.h"//检查联网情况
#endif

#if __has_include(<AFNetworking/AFNetworking.h>)
#import <AFNetworking/AFNetworking.h>
#else
#import "AFNetworking.h"
#endif

#if __has_include(<SDWebImage/SDWebImage.h>)
#import <SDWebImage/SDWebImage.h>
#else
#import "SDWebImage.h"
#endif

#if __has_include(<MJExtension/MJExtension.h>)
#import <MJExtension/MJExtension.h>
#else
#import "MJExtension.h"
#endif

#if __has_include(<MJRefresh/MJRefresh.h>)
#import <MJRefresh/MJRefresh.h>
#else
#import "MJRefresh.h"
#endif

#if __has_include(<SPAlertController/SPAlertController.h>)
#import <SPAlertController/SPAlertController.h>
#else
#import "SPAlertController.h"
#endif

#if __has_include(<ReactiveObjC/ReactiveObjC.h>)
#import <ReactiveObjC/ReactiveObjC.h>
#else
#import "ReactiveObjC.h"
#endif

#if __has_include(<BRPickerView/BRPickerView.h>)
#import <BRPickerView/BRPickerView.h>
#else
#import "BRPickerView.h"
#endif

#if __has_include(<JXCategoryView/JXCategoryView.h>)
#import <JXCategoryView/JXCategoryView.h>
#else
#import "JXCategoryView.h"
#endif

#if __has_include(<JXPagingView/JXPagerView.h>)
#import <JXPagingView/JXPagerView.h>
#else
#import "JXPagerView.h"
#endif

#if __has_include(<TXFileOperation/TXFileOperation.h>)
#import <TXFileOperation/TXFileOperation.h>
#else
#import "TXFileOperation.h"
#endif

#if __has_include(<JPImageresizerView/JPImageresizerView.h>)
#import <JPImageresizerView/JPImageresizerView.h>
#else
#import "JPImageresizerView.h"
#endif

#if __has_include(<GKNavigationBar/GKNavigationBar.h>)
#import <GKNavigationBar/GKNavigationBar.h>
#else
#import "GKNavigationBar.h"
#endif

#if __has_include(<TFPopup/TFPopup.h>)
#import <TFPopup/TFPopup.h>
#else
#import "TFPopup.h"
#endif

#if __has_include(<PPBadgeView/PPBadgeView.h>)
#import <PPBadgeView/PPBadgeView.h>
#else
#import "PPBadgeView.h"
#endif

#if __has_include(<LYEmptyViewHeader/LYEmptyViewHeader.h>)
#import <LYEmptyViewHeader/LYEmptyViewHeader.h>
#else
#import "LYEmptyViewHeader.h"
#endif

#if __has_include(<WHToast/WHToast.h>)
#import <WHToast/WHToast.h>
#else
#import "WHToast.h"
#endif

#if __has_include(<MBProgressHUD/MBProgressHUD.h>)
#import <MBProgressHUD/MBProgressHUD.h>
#else
#import "MBProgressHUD.h"
#endif

#if __has_include(<lottie-ios/Lottie.h>)
#import <lottie-ios/Lottie.h>
#else
#import "Lottie.h"
#endif

#if __has_include(<MGSwipeTableCell/MGSwipeTableCell.h>)
#import <MGSwipeTableCell/MGSwipeTableCell.h>
#else
#import "MGSwipeTableCell.h"
#endif

#import <Shimmer/Shimmer-umbrella.h>

//WebSocket
#import "GCDAsyncSocket.h" // for TCP
#import "GCDAsyncUdpSocket.h" // for UDP
//MQTT
#if __has_include(<MQTTClient/MQTTClient.h>)
#import<MQTTClient/MQTTClient.h>
#else
#import "MQTTClient.h"
#endif

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

#endif /* Pods_h */
