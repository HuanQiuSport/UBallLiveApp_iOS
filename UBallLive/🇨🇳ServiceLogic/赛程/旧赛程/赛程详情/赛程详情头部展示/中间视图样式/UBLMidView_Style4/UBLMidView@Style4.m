//
//  UBLMidView@Style4.m
//  UBallLive
//
//  Created by Jobs on 2020/11/3.
//

#import "UBLMidView@Style4.h"

@interface UBLMidView_Style4 ()

@end

@implementation UBLMidView_Style4

-(instancetype)init{
    if (self = [super init]) {
        self.text = @"已取消";
        self.textAlignment = NSTextAlignmentCenter;
        self.textColor = kWhiteColor;
        self.font = [UIFont systemFontOfSize:12 weight:UIFontWeightMedium];
    }return self;
}

@end
