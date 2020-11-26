#  项目里面ZFPlayer的架构说明

1、关注 @implementation UIView (ZFPlayer)。用分类而不是基类减少代码入侵；
2、使用赋值URL：
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
3、退出到后台，调用通知，通知名：UBLEnterBackgroundStopPlayer 以停止播放器
4、因为UIViewController包含Self.view，故分类的写法涵盖了所有的UI界面


