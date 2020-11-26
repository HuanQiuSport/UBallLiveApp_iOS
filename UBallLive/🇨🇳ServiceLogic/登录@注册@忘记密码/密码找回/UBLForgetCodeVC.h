//
//  ForgetCodeVC.h
//  Shooting
//
//  Created by Jobs on 2020/9/3.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import "UBLForgetCodeStep_01View.h"
#import "UBLForgetCodeStep_02View.h"
#import "UBLFindCodeFlowChartView.h"
#import "CustomZFPlayerControlView.h"
#import "UBLDoorInputView.h"

NS_ASSUME_NONNULL_BEGIN

@interface UBLForgetCodeVC : UIViewController

@property(nonatomic,strong,nullable)UBLForgetCodeStep_01View *__block step_01;
@property(nonatomic,strong,nullable)UBLForgetCodeStep_02View *__block step_02;
@property(nonatomic,strong,nullable)UBLFindCodeFlowChartView *findCodeFlowChartView;
@property(nonatomic,strong)UIButton *successBtn;
@property(nonatomic,strong)UIButton *nextStepBtn;//下一步
@property(nonatomic,assign)int __block Step;
@property(nonatomic,strong)NSString *telStr;
///一共几个流程节点
@property(nonatomic,assign)NSInteger flowNum;
///当前流程序号 从0开始
@property(nonatomic,assign)NSInteger currentFlowSerialNum;

- (void)removeAll;

@end

NS_ASSUME_NONNULL_END
