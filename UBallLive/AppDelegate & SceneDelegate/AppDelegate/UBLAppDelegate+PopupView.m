//
//  AppDelegate+PopupView.m
//  UBallLive
//
//  Created by Jobs on 2020/10/26.
//

#import "UBLAppDelegate+PopupView.h"

@implementation UBLAppDelegate (PopupView)

// 见 @implementation UIViewController (TFPopup)
-(void)Popupview{
    [self.popupView tf_showNormal:getMainWindow() animated:YES];
}

@end
