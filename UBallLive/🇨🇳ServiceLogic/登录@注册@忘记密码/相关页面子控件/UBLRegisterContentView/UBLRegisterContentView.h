//
//  RegisterContentView.h
//  Shooting
//
//  Created by Jobs on 2020/9/3.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UBLDoorInputView.h"

NS_ASSUME_NONNULL_BEGIN

@interface UBLRegisterContentView : UIView

@property(nonatomic,strong)NSMutableArray <UBLDoorInputViewBaseStyle *> *inputViewMutArr;

-(void)showRegisterContentViewWithOffsetY:(CGFloat)offsetY;
-(void)removeRegisterContentViewWithOffsetY:(CGFloat)offsetY;

-(void)actionRegisterContentViewBlock:(MKDataBlock)registerContentViewBlock;
-(void)actionRegisterContentViewKeyboardBlock:(MKDataBlock)registerContentViewKeyboardBlock;
-(void)actionRegisterContentViewAuthcodeBlock:(MKDataBlock)registerContentViewAuthcodeBlock;

@end

NS_ASSUME_NONNULL_END
