//
//  UBLVideoCollectionViewCell@Style12.m
//  UBallLive
//
//  Created by Jobs on 2020/11/2.
//

#import "UBLVideoCollectionViewCell@Style12.h"

@interface UBLVideoCollectionViewCell_Style12 ()

@property(nonatomic,copy)MKDataBlock videoCollectionViewCell_Style12Block;

@property(nonatomic,strong)UIButton *btn;

@property(nonatomic,strong)NSMutableArray <UIImage *>*titleMutArr;
@property(nonatomic,strong)NSMutableArray <NSString *>*dataMutArr;
@property(nonatomic,strong)NSMutableArray <UIButton *>*btnMutArr;

@end

@implementation UBLVideoCollectionViewCell_Style12

-(void)dealloc {
    NSLog(@"Running self.class = %@;NSStringFromSelector(_cmd) = '%@';__FUNCTION__ = %s", self.class, NSStringFromSelector(_cmd),__FUNCTION__);
}

-(void)actionBlockVideoCollectionViewCell_Style12:(MKDataBlock _Nullable)videoCollectionViewCell_Style12Block{
    self.videoCollectionViewCell_Style12Block = videoCollectionViewCell_Style12Block;
}

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        [UIView makeTargetShadowview:self
                           superView:nil
                     shadowDirection:ShadowDirection_rightDown
                   shadowWithOffsetX:5
                             offsetY:5
                        cornerRadius:8
                        shadowOffset:defaultSize
                       shadowOpacity:1
                    layerShadowColor:defaultObj
                   layerShadowRadius:defaultValue];
        
        self.backgroundColor = kWhiteColor;
        
    }return self;
}

-(void)richElementsInCellWithModel:(id _Nullable)model{

    CGFloat offsetX = (self.mj_w - 70 * self.titleMutArr.count - 27 * 2) / (self.titleMutArr.count - 1);
    for (int i = 0; i < self.titleMutArr.count; i++) {
        UIButton *btn = UIButton.new;
        
        [btn setImage:self.titleMutArr[i] forState:UIControlStateNormal];
//        [btn setTitle:self.dataMutArr[i] forState:UIControlStateNormal];
        
        NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:self.dataMutArr[i]];
        
        if (i == 2) {
            [str addAttribute:NSForegroundColorAttributeName value:HEXCOLOR(0xFF5454) range:NSMakeRange(0,2)];
            [str addAttribute:NSForegroundColorAttributeName value:KLightGrayColor range:NSMakeRange(3,self.dataMutArr[i].length - 3)];
            
            [str addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:22.8 weight:UIFontWeightSemibold] range:NSMakeRange(0,2)];
            [str addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:18.8 weight:UIFontWeightSemibold] range:NSMakeRange(3,self.dataMutArr[i].length - 3)];
        }else{
            [str addAttribute:NSForegroundColorAttributeName value:HEXCOLOR(0xFF5454) range:NSMakeRange(0,self.dataMutArr[i].length)];
            [str addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:22.8 weight:UIFontWeightSemibold] range:NSMakeRange(0,self.dataMutArr[i].length)];
        }
        
        [btn setAttributedTitle:str forState:UIControlStateNormal];
        

        [btn layoutButtonWithEdgeInsetsStyle:GLButtonEdgeInsetsStyleBottom
                             imageTitleSpace:3];
        
        [self.contentView addSubview:btn];
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(self.contentView);
            make.width.mas_equalTo(70);
            if (i == 0) {
                make.left.equalTo(self.contentView).offset(27);
            }else{
                UIButton *button = (UIButton *)self.btnMutArr[i - 1];
                make.left.equalTo(button.mas_right).offset(offsetX);
            }
            
            [self.btnMutArr addObject:btn];
        }];
    }
}

+(CGSize)cellSizeWithModel:(id _Nullable)model{
    return CGSizeMake(MAINSCREEN_WIDTH - 12 * 2, 53);
}
#pragma mark —— lazyLoad
-(NSMutableArray<UIImage *> *)titleMutArr{
    if (!_titleMutArr) {
        _titleMutArr = NSMutableArray.array;
        [_titleMutArr addObject:KBuddleIMG(@"⚽️PicResource", @"Others", @"文字切图", @"周命中率")];
        [_titleMutArr addObject:KBuddleIMG(@"⚽️PicResource", @"Others", @"文字切图", @"奖励率")];
        [_titleMutArr addObject:KBuddleIMG(@"⚽️PicResource", @"Others", @"文字切图", @"近十场")];
        [_titleMutArr addObject:KBuddleIMG(@"⚽️PicResource", @"Others", @"文字切图", @"近期连中")];
    }return _titleMutArr;
}

-(NSMutableArray<NSString *> *)dataMutArr{
    if (!_dataMutArr) {
        _dataMutArr = NSMutableArray.array;
        [_dataMutArr addObject:@"166%"];
        [_dataMutArr addObject:@"166%"];
        [_dataMutArr addObject:@"10/7"];
        [_dataMutArr addObject:@"8"];
    }return _dataMutArr;
}

-(NSMutableArray<UIButton *> *)btnMutArr{
    if (!_btnMutArr) {
        _btnMutArr = NSMutableArray.array;
    }return _btnMutArr;
}

@end
