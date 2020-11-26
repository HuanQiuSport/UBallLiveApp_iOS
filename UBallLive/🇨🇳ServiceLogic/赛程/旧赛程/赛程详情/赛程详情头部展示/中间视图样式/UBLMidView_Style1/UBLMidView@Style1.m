//
//  UBLMidView@Style1.m
//  UBallLive
//
//  Created by Jobs on 2020/11/3.
//

#import "UBLMidView@Style1.h"

@interface UBLMidView_Style1 ()

@property(nonatomic,strong)NSString *titleStr_1;
@property(nonatomic,strong)NSString *titleStr_2;
@property(nonatomic,strong)NSMutableArray <RichLabelDataStringsModel *>*richLabelDataStringsMutArr;

@end

@implementation UBLMidView_Style1

-(void)drawRect:(CGRect)rect{
    [super drawRect:rect];
    
    self.titleStr_1 = @"开始倒计时\n";
    self.titleStr_2 = @"正在计算剩余时间...";
    
//    [self setTitle:@"开始倒计时\n正在计算剩余时间..." forState:UIControlStateNormal];
    
    self.attributedString = [NSObject makeRichTextWithDataConfigMutArr:self.richLabelDataStringsMutArr];
    [self setAttributedTitle:self.attributedString forState:UIControlStateNormal];
    
}
#pragma mark —— lazyLoad
-(NSMutableArray<RichLabelDataStringsModel *> *)richLabelDataStringsMutArr{
    if (!_richLabelDataStringsMutArr) {
        _richLabelDataStringsMutArr = NSMutableArray.array;
        
        RichLabelFontModel *richLabelFontModel_1 = RichLabelFontModel.new;
        richLabelFontModel_1.font = [UIFont systemFontOfSize:20 weight:UIFontWeightMedium];
        richLabelFontModel_1.range = NSMakeRange(0, self.titleStr_1.length);
        
        RichLabelFontModel *richLabelFontModel_2 = RichLabelFontModel.new;
        richLabelFontModel_2.font = [UIFont systemFontOfSize:10 weight:UIFontWeightMedium];
        richLabelFontModel_2.range = NSMakeRange(self.titleStr_1.length, self.titleStr_2.length);
        
        RichLabelTextCorModel *richLabelTextCorModel_1 = RichLabelTextCorModel.new;
        richLabelTextCorModel_1.cor = kWhiteColor;
        richLabelTextCorModel_1.range = NSMakeRange(0, self.titleStr_1.length);
        
        RichLabelTextCorModel *richLabelTextCorModel_2 = RichLabelTextCorModel.new;
        richLabelTextCorModel_2.cor = KLightGrayColor;
        richLabelTextCorModel_2.range = NSMakeRange(self.titleStr_1.length, self.titleStr_2.length);
        //////
        
        RichLabelDataStringsModel *richLabelDataStringsModel_1 = RichLabelDataStringsModel.new;
        richLabelDataStringsModel_1.dataString = self.titleStr_1;
        richLabelDataStringsModel_1.richLabelFontModel = richLabelFontModel_1;
        richLabelDataStringsModel_1.richLabelTextCorModel = richLabelTextCorModel_1;
        
        RichLabelDataStringsModel *richLabelDataStringsModel_2 = RichLabelDataStringsModel.new;
        richLabelDataStringsModel_2.dataString = self.titleStr_2;
        richLabelDataStringsModel_2.richLabelFontModel = richLabelFontModel_2;
        richLabelDataStringsModel_2.richLabelTextCorModel = richLabelTextCorModel_2;
        
        [_richLabelDataStringsMutArr addObject:richLabelDataStringsModel_1];
        [_richLabelDataStringsMutArr addObject:richLabelDataStringsModel_2];
        
    }return _richLabelDataStringsMutArr;
}

@end
