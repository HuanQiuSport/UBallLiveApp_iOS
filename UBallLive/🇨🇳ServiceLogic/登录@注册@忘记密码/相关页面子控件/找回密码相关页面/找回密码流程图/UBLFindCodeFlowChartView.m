//
//  FindCodeFlowChartView.m
//  Shooting
//
//  Created by Jobs on 2020/9/3.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import "UBLFindCodeFlowChartView.h"

@interface UBLFlowChartSingleElementView ()

@end

@implementation UBLFlowChartSingleElementView

-(void)drawRect:(CGRect)rect{
    [super drawRect:rect];
    self.bacKIMGV.alpha = 1;
    self.titleLab.alpha = 1;
    self.subTitleLab.alpha = 1;
    
}

#pragma mark —— lazyLoad
-(UILabel *)titleLab{
    if (!_titleLab) {
        _titleLab = UILabel.new;
        _titleLab.font = [UIFont systemFontOfSize:20
                                           weight:UIFontWeightHeavy];
        [_titleLab sizeToFit];
        [self.bacKIMGV addSubview:_titleLab];
        [_titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.bacKIMGV);
            make.bottom.equalTo(self.bacKIMGV.mas_centerY).offset(7);
        }];
    }return _titleLab;
}

-(UILabel *)subTitleLab{
    if (!_subTitleLab) {
        _subTitleLab = UILabel.new;
        _subTitleLab.font = [UIFont systemFontOfSize:8
                                              weight:UIFontWeightRegular];
        [_subTitleLab sizeToFit];
        [self.bacKIMGV addSubview:_subTitleLab];
        [_subTitleLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.bacKIMGV);
            make.top.equalTo(self.bacKIMGV.mas_centerY).offset(7);
        }];
    }return _subTitleLab;
}

-(UIImageView *)bacKIMGV{
    if (!_bacKIMGV) {
        _bacKIMGV = UIImageView.new;
        [self addSubview:_bacKIMGV];
        [_bacKIMGV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self);
        }];
    }return _bacKIMGV;
}

@end

@interface UBLFindCodeFlowChartView ()

@property(nonatomic,strong)NSMutableArray <UBLFlowChartSingleElementView *>*singleElementMutArr;
@property(nonatomic,assign)BOOL isOK;//保证 makeFlowChart 只创建一次

@end

@implementation UBLFindCodeFlowChartView

-(instancetype)init{
    if (self = [super init]) {
        
    }return self;
}

-(void)drawRect:(CGRect)rect{
    [super drawRect:rect];
    if (!self.isOK) {
        [self makeFlowChart];
    }
}

-(void)makeFlowChart{
    if (self.flowNum) {
        //单个节点的高度
//        CGFloat singleElementH = self.mj_h;
        //每个节点的宽度
        CGFloat singleElementW = MAINSCREEN_WIDTH / self.flowNum;
        for (int t = 0; t < self.flowNum; t++) {
            UBLFlowChartSingleElementView *singleElement = UBLFlowChartSingleElementView.new;
            singleElement.titleLab.text = self.titleMutArr[t];
            singleElement.subTitleLab.text = self.subTitleMutArr[t];
            if (self.backImageMutArr.count - 1 > self.currentFlowSerialNum) {
                if (t > self.currentFlowSerialNum) {
                    singleElement.bacKIMGV.image = self.backImageMutArr[0];
                    singleElement.titleLab.textColor = KLightGrayColor;
                    singleElement.subTitleLab.textColor = KLightGrayColor;
                }else{
                    singleElement.bacKIMGV.image = self.backImageMutArr[t + 1];
                    singleElement.titleLab.textColor = kBlackColor;
                    singleElement.subTitleLab.textColor = kBlackColor;
                }
            }else{
                NSAssert(0,@"数组越界");
            }
            [self addSubview:singleElement];
            [singleElement mas_makeConstraints:^(MASConstraintMaker *make) {
                [singleElement mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.width.mas_equalTo(singleElementW);
                    make.top.bottom.equalTo(self);
                    if (t == 0) {//第一个元素，从左边开始布局
                        make.left.equalTo(self);
                    }else{
                        UBLFlowChartSingleElementView *lastSingleElement = self.singleElementMutArr[t - 1];
                        make.left.equalTo(lastSingleElement.mas_right);
                    }
                }];
                [self.singleElementMutArr addObject:singleElement];
            }];
        }
    }
    
    if (self.singleElementMutArr.count) {
        self.isOK = YES;
    }
}

#pragma mark —— lazyLoad
-(NSMutableArray<UBLFlowChartSingleElementView *> *)singleElementMutArr{
    if (!_singleElementMutArr) {
        _singleElementMutArr = NSMutableArray.array;
    }return _singleElementMutArr;
}


@end
