//
//  UBLCollectionViewCellImageView.m
//  UBallLive
//
//  Created by Jobs on 2020/11/9.
//

#import "UBLCollectionViewCellImageView.h"

@interface UBLCollectionViewCellImageView ()

@property(nonatomic,assign)BOOL isOK;

@end

@implementation UBLCollectionViewCellImageView

-(instancetype)initWithFirstFrameFigureIMG:(UIImage *)firstFrameFigureIMG
                            videoURLString:(NSString *)videoURLString{
    if (self = [super init]) {
        self.firstFrameFigureIMG = firstFrameFigureIMG;
        self.videoURLString = videoURLString;
        self.image = self.firstFrameFigureIMG;
        
        self.customPlayerControlView.prepareShowControlView = YES;
        self.customPlayerControlView.prepareShowLoading = YES;//resetControlView
        self.customPlayerControlView.effectViewShow = NO;
        [self.customPlayerControlView showTitle:@"0000"
                                     coverImage:self.image
                                 fullScreenMode:ZFFullScreenModePortrait];
        @weakify(self)
        [self.customPlayerControlView actionCustomZFPlayerControlViewBlock:^(NSString *data,
                                                                             NSNumber *data2) {
            @strongify(self)
            if (self.playerCtr.currentPlayerManager.isPlaying) {
                [self.playerCtr.currentPlayerManager pause];
            }else{
                [self.playerCtr.currentPlayerManager play];//建议不直接播，因为耗能
            }
        }];
        
    }return self;
}
//hitTest:withEvent 和 touchesBegan：withEvent：混用，可以实现强行阻断点击事件的响应链
-(UIView *)hitTest:(CGPoint)point
         withEvent:(UIEvent *)event{
    NSLog(@"%@",self.customPlayerControlView);
    if (CGRectContainsPoint(self.frame, point)) {//
        return self;
    }else{
        return nil;
    }
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches
          withEvent:(UIEvent *)event{
    if (![NSString isNullString:self.videoURLString]) {
        
//        self.avPlayerManager.assetURL = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"iph_X" ofType:@"mp4"]];// 取本地当然没问题，这是底线
//        self.avPlayerManager.assetURL = [NSURL URLWithString:@"http://1011.hlsplay.aodianyun.com/demo/game.flv"];// 不行，苹果系统Api默认不支持Flv视频
        self.ijkPlayerManager.assetURL = [NSURL URLWithString:self.videoURLString];
        if (!self.isOK) {// 不能用 self.playerCtr.currentPlayerManager.isPlaying
            [self.playerCtr.currentPlayerManager play];//建议不直接播，因为耗能
        }else{
            [self.playerCtr.currentPlayerManager pause];//建议不直接播，因为耗能
        }
        self.isOK = !self.isOK;
    }
}
#pragma mark —— lazyLoad


@end
