//
//  UIViewController+BaseVC.m
//  UBallLive
//
//  Created by Jobs on 2020/10/12.
//

#import "UIViewController+BaseVC.h"

@implementation UIViewController (BaseVC)

static char *UIViewController_BaseVC_requestParams = "UIViewController_BaseVC_requestParams";
static char *UIViewController_BaseVC_pushOrPresent = "UIViewController_BaseVC_pushOrPresent";

@dynamic requestParams;
@dynamic pushOrPresent;

- (void)dealloc{
    NSLog(@"Running self.class = %@;NSStringFromSelector(_cmd) = '%@';__FUNCTION__ = %s", self.class, NSStringFromSelector(_cmd),__FUNCTION__);
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

+(instancetype)comingFromVC:(UIViewController *)rootVC
                       toVC:(UIViewController *)toVC
                comingStyle:(ComingStyle)comingStyle
          presentationStyle:(UIModalPresentationStyle)presentationStyle
              requestParams:(nullable id)requestParams
                    success:(MKDataBlock)successBlock
                   animated:(BOOL)animated{
    toVC.requestParams = requestParams;
    @weakify(rootVC)
    @weakify(toVC)
    switch (comingStyle) {
        case ComingStyle_PUSH:{
            if (weak_rootVC.navigationController) {
                weak_toVC.pushOrPresent = ComingStyle_PUSH;
                if (successBlock) {
                    successBlock(weak_toVC);
                }
                [weak_rootVC.navigationController pushViewController:weak_toVC
                                                            animated:animated];
            }else{
                weak_toVC.pushOrPresent = ComingStyle_PRESENT;
                //iOS_13中modalPresentationStyle的默认改为UIModalPresentationAutomatic,而在之前默认是UIModalPresentationFullScreen
                weak_toVC.modalPresentationStyle = presentationStyle;
                if (successBlock) {
                    successBlock(toVC);
                }
                [weak_rootVC presentViewController:weak_toVC
                                          animated:animated
                                        completion:^{}];
            }
        }break;
        case ComingStyle_PRESENT:{
            weak_toVC.pushOrPresent = ComingStyle_PRESENT;
            //iOS_13中modalPresentationStyle的默认改为UIModalPresentationAutomatic,而在之前默认是UIModalPresentationFullScreen
            weak_toVC.modalPresentationStyle = presentationStyle;
            if (successBlock) {
                successBlock(weak_toVC);
            }
            [weak_rootVC presentViewController:weak_toVC
                                      animated:animated
                                    completion:^{}];
        }break;
        default:
            NSLog(@"错误的推进方式");
            break;
    }return toVC;
}
#pragma mark —— @property(nonatomic,strong)id requestParams;
-(id)requestParams{
    id RequestParams = objc_getAssociatedObject(self, UIViewController_BaseVC_requestParams);
    return RequestParams;
}

-(void)setRequestParams:(id)requestParams{
    objc_setAssociatedObject(self,
                             UIViewController_BaseVC_requestParams,
                             requestParams,
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
#pragma mark —— @property(nonatomic,assign)ComingStyle pushOrPresent;
-(ComingStyle)pushOrPresent{
    return [objc_getAssociatedObject(self, UIViewController_BaseVC_pushOrPresent) integerValue];
}

-(void)setPushOrPresent:(ComingStyle)pushOrPresent{
    objc_setAssociatedObject(self,
                             UIViewController_BaseVC_pushOrPresent,
                             [NSNumber numberWithInteger:pushOrPresent],
                             OBJC_ASSOCIATION_ASSIGN);
}

@end
