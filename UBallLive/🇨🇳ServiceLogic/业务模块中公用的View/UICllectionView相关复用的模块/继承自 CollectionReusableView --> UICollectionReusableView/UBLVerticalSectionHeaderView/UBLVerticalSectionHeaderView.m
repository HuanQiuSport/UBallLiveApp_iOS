//
//  VerticalSectionHeaderView.m
//  JXCategoryView
//
//  Created by jiaxin on 2018/8/22.
//  Copyright © 2018年 jiaxin. All rights reserved.
//

#import "UBLVerticalSectionHeaderView.h"

@interface UBLVerticalSectionHeaderView ()

@property(nonatomic,strong)UILabel *titleLabel;
@property(nonatomic,assign)BOOL isOK;

@end

@implementation UBLVerticalSectionHeaderView

- (void)dealloc {
    NSLog(@"Running self.class = %@;NSStringFromSelector(_cmd) = '%@';__FUNCTION__ = %s", self.class, NSStringFromSelector(_cmd),__FUNCTION__);
}

-(void)richElementsInCellWithModel:(id _Nullable)model{
    if ([model isKindOfClass:VerticalListSectionModel.class]) {
        VerticalListSectionModel *sectionModel = (VerticalListSectionModel *)model;
        self.titleLabel.text = sectionModel.sectionTitle;
        [self.titleLabel sizeToFit];
    }
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches
          withEvent:(UIEvent *)event{
    @weakify(self)
    self.selected = !self.selected;
    if (self.collectionReusableViewBlock) {
        self.collectionReusableViewBlock(weak_self.indexPath);
    }
}
#pragma mark —— lazyLoad
-(UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = UILabel.new;
        _titleLabel.textColor = KLightGrayColor;
        _titleLabel.font = kFontSize(15);
        [self addSubview:_titleLabel];
        [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(10);
            make.centerY.equalTo(self);
        }];  
    }return _titleLabel;
}

@end
