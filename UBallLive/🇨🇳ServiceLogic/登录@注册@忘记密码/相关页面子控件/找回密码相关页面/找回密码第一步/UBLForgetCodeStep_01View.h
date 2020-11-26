//
//  ForgetCodeStep_01.h
//  Shooting
//
//  Created by Jobs on 2020/9/6.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UBLDoorInputView.h"

NS_ASSUME_NONNULL_BEGIN

@interface UBLForgetCodeStep_01View : UIView

@property(nonatomic,strong)NSMutableArray <UBLDoorInputViewStyle_3 *> *inputViewMutArr;

-(void)showForgetCodeStep_01ViewWithOffsetY:(CGFloat)offsetY;
-(void)removeForgetCodeStep_01ViewWithOffsetY:(CGFloat)offsetY;

-(void)actionForgetCodeStep_01ViewBlock:(MKDataBlock)forgetCodeStep_01ViewBlock;
-(void)actionForgetCodeStep_01ViewKeyboardBlock:(MKDataBlock)forgetCodeStep_01ViewKeyboardBlock;

-(void)actionForgetCodeStep_01ViewEnbleBlock:(MKDataBlock)forgetCodeStep_01ViewEnabledBlock;

@end

NS_ASSUME_NONNULL_END
