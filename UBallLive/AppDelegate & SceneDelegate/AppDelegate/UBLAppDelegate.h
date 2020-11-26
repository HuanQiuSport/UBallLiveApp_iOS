//
//  AppDelegate.h
//  U球直播
//
//  Created by Jobs on 2020/10/9.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "TabbarVC.h"
#import "NoticePopupView.h"

@interface UBLAppDelegate : UIResponder <UIApplicationDelegate>

@property(readonly,strong)NSPersistentCloudKitContainer *persistentContainer;
@property(nonatomic,strong)UIWindow *window;//仅仅为了iOS 13 版本向下兼容而存在
@property(nonatomic,strong)TabbarVC *tabBarVC;
@property(nonatomic,strong)NoticePopupView *popupView;

-(void)saveContext;
+(instancetype)sharedInstance;

@end

