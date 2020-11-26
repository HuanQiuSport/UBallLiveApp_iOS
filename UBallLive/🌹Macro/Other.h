//
//  Other.h
//  My_BaseProj
//
//  Created by 刘赓 on 2019/9/26.
//  Copyright © 2019 Corp. All rights reserved.
//

#ifndef Other_h
#define Other_h

//SYS
#import <objc/runtime.h>
#import <Foundation/Foundation.h>
#import <QuartzCore/QuartzCore.h>
#import <UIKit/UIKit.h>
#import <CoreTelephony/CTTelephonyNetworkInfo.h>
#import <CoreTelephony/CTCarrier.h>

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
//播放器控制层
#import "CustomZFPlayerControlView.h"
#import "ZFCustomControlView.h"

//////////////////////////////////////  以下为公共自定义业务控制器

#import "TestVC.h"
#import "NoticePopupView.h"

#import "ViewController@1.h"
#import "ViewController@2.h"//旧赛程
#import "ViewController@3.h"
#import "ViewController@4.h"
#import "ViewController@5.h"//旧我的

#import "UBLMatchScheduleVC.h"//新赛程
#import "UBLMyVC.h"//新我的

#import "UICollectionView+RegisterClass.h"//所有的UICollectionView注册，省去很多麻烦
#import "KFZShopCatoryFlowLayput.h"

#import "UBLLivingMainVC.h"//直播
#import "UBLMatchScheduleDetailVC.h"//赛程详情

#import "TabbarControllerSysEx.h"
#import "UBLLivingVC.h"

#import "UBLAppDelegate.h"
#import "UBLSceneDelegate.h"

#import "VerticalListSectionModel.h"

// 用户信息模块
#import "UBLUserInfo.h"
// 注册@登录@忘记密码
///相关页面独立出来的View控件
#import "UBLDoor.h"
#import "UBLDoorInputView.h"
#import "UBLDoorInputViewBaseStyle.h"
#import "UBLDoorInputViewStyle_1.h"
#import "UBLDoorInputViewStyle_2.h"
#import "UBLDoorInputViewStyle_3.h"
#import "UBLRegisterContentView.h"
#import "UBLLogoContentView.h"
#import "UBLLoginContentView.h"
#import "UBLFindCodeFlowChartView.h"
#import "UBLForgetCodeStep_01View.h"
#import "UBLForgetCodeStep_02View.h"
///登录注册
#import "UBLDoorVC.h"
///密码找回
#import "UBLForgetCodeVC.h"

#endif /* Other_h */
