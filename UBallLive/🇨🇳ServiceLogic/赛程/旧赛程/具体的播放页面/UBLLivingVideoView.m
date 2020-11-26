//
//  PagingViewTableHeaderView.m
//  JXCategoryView
//
//  Created by jiaxin on 2018/8/27.
//  Copyright © 2018年 jiaxin. All rights reserved.
//

#import "UBLLivingVideoView.h"
#import "UIView+ZFPlayer.h"

@interface UBLLivingVideoView()

@property(nonatomic,assign)BOOL isOK;
@property(nonatomic,copy)MKDataBlock livingVideoViewBlock;

@end

@implementation UBLLivingVideoView

- (void)dealloc {
    NSLog(@"Running self.class = %@;NSStringFromSelector(_cmd) = '%@';__FUNCTION__ = %s", self.class, NSStringFromSelector(_cmd),__FUNCTION__);
    /* 借用进入后台的通知来stop播放器
     * 因为存在ZFIJKPlayerManager 和 ZFAVPlayerManager,因为是用分类实现，只能self.的形式调取属性不能用下划线调取属性
     * 而self取属性会触发该属性在分类里面的set和get方法，干扰我内部的逻辑，所以在不增加代码量的情况下借用用进入后台的通知，人畜无害
     */
    [[NSNotificationCenter defaultCenter] postNotificationName:UBLEnterBackgroundStopPlayer object:nil];
}

-(instancetype)init{
    if (self = [super init]) {
        
    }return self;
}

-(void)drawRect:(CGRect)rect{
    [super drawRect:rect];
    if (!self.isOK) {
//        self.avPlayerManager.assetURL = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"iph_X" ofType:@"mp4"]];// 取本地当然没问题，这是底线
//        self.avPlayerManager.assetURL = [NSURL URLWithString:@"http://1011.hlsplay.aodianyun.com/demo/game.flv"];// 不行，苹果系统Api默认不支持Flv视频
        self.ijkPlayerManager.assetURL = [NSURL URLWithString:@"http://1011.hlsplay.aodianyun.com/demo/game.flv"];
        
        [self.customPlayerControlView showTitle:@"0000"
                                     coverImage:[UIImage animatedGIFNamed:@"⚽️PicResource/Gif/Bt9h"]
                                 fullScreenMode:ZFFullScreenModePortrait];
        self.customPlayerControlView.prepareShowControlView = YES;
        self.customPlayerControlView.prepareShowLoading = YES;
        
        @weakify(self)
        [self.customPlayerControlView actionCustomZFPlayerControlViewBlock:^(NSString *data,
                                                                             NSNumber *data2) {
            @strongify(self)
            if ([data isEqualToString:@"gestureSingleTapped:"]) {
                if (self.livingVideoViewBlock) {
                    self.livingVideoViewBlock(data);
                }
            }
            
            if (self.playerCtr.currentPlayerManager.isPlaying) {
//                self.playerCtr.currentPlayerManager.loadState;// = MPMovieLoadStatePlayable;
                [self.playerCtr.currentPlayerManager pause];
            }else{
                [self.playerCtr.currentPlayerManager play];//建议不直接播，因为耗能
            }
        }];
        [self.playerCtr.currentPlayerManager play];//建议不直接播，因为耗能
        self.isOK = YES;
    }
}

-(void)actionLivingVideoViewBlock:(MKDataBlock _Nullable)livingVideoViewBlock{
    self.livingVideoViewBlock = livingVideoViewBlock;
}

@end
