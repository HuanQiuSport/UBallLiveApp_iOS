//
//  SceneDelegate.m
//  U球直播
//
//  Created by Jobs on 2020/10/9.
//

#import "UBLSceneDelegate.h"
#import "UBLAppDelegate.h"
#import "UBLAppDelegate+PopupView.h"
#import "UBLGuide.h"
API_AVAILABLE(ios(13.0))

@interface UBLSceneDelegate ()

@end

@implementation UBLSceneDelegate

static UBLSceneDelegate *static_sceneDelegate = nil;
+(instancetype)sharedInstance{
    @synchronized(self){
        if (!static_sceneDelegate) {
            static_sceneDelegate = UBLSceneDelegate.new;
        }
    }return static_sceneDelegate;
}

-(instancetype)init{
    if (self = [super init]) {
        static_sceneDelegate = self;
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(noti1:)
                                                     name:UISceneWillConnectNotification
                                                   object:nil];
    }return self;
}

-(void)noti1:(NSNotification *)notification{
    self.windowScene = notification.object;
}

- (void)scene:(UIScene *)scene
willConnectToSession:(UISceneSession *)session
      options:(UISceneConnectionOptions *)connectionOptions {
    
    //在这里手动创建新的window
    if (@available(iOS 13.0, *)) {
        self.windowScene = (UIWindowScene *)scene;
        XHLaunchAd * ad = [XHLaunchAd setWaitDataDuration:10];
        
        [ad scene:self.windowScene];
        UBLGuide *guide = [UBLGuide share];
        [guide scene:self.windowScene];
        self.window.alpha = 1;
//        [[UBLAppDelegate sharedInstance] Popupview];// 弹出框
    }
}

- (void)sceneDidDisconnect:(UIScene *)scene {
    // Called as the scene is being released by the system.
    // This occurs shortly after the scene enters the background, or when its session is discarded.
    // Release any resources associated with this scene that can be re-created the next time the scene connects.
    // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
}

- (void)sceneDidBecomeActive:(UIScene *)scene {
    NSLog(@"---applicationDidBecomeActive----");//进入前台
}

- (void)sceneWillResignActive:(UIScene *)scene {
    // Called when the scene will move from an active state to an inactive state.
    // This may occur due to temporary interruptions (ex. an incoming phone call).
}

- (void)sceneWillEnterForeground:(UIScene *)scene {
    // Called as the scene transitions from the background to the foreground.
    // Use this method to undo the changes made on entering the background.
}

- (void)sceneDidEnterBackground:(UIScene *)scene {
    NSLog(@"---applicationDidEnterBackground----"); //进入后台
    [(UBLAppDelegate *)UIApplication.sharedApplication.delegate saveContext];
    [[NSNotificationCenter defaultCenter] postNotificationName:UBLEnterBackgroundStopPlayer object:nil];
}
#pragma mark —— lazyLoad
-(UIWindow *)window{
    [_window setRootViewController:UBLAppDelegate.sharedInstance.tabBarVC];
    [_window makeKeyAndVisible];
    return _window;
}

@end
