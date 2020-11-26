//
//  SceneDelegate.h
//  U球直播
//
//  Created by Jobs on 2020/10/9.
//

#import <UIKit/UIKit.h>

API_AVAILABLE(ios(13.0))
@interface UBLSceneDelegate : UIResponder <UIWindowSceneDelegate>

@property(nonatomic,strong)UIWindow *window;
@property(nonatomic,strong)UIWindowScene *windowScene;

+(instancetype)sharedInstance;

@end

