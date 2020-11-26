//
//  MyCell.m
//  WMZBanner
//
//  Created by wmz on 2019/9/6.
//  Copyright © 2019 wmz. All rights reserved.
//

#import "UBLMyAdCell.h"

@interface UBLMyAdCell ()

@property(nonatomic,assign)BOOL isOK;

@end

@implementation UBLMyAdCell

- (void)dealloc {
    NSLog(@"Running self.class = %@;NSStringFromSelector(_cmd) = '%@';__FUNCTION__ = %s", self.class, NSStringFromSelector(_cmd),__FUNCTION__);
}

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]){
        self.contentView.layer.masksToBounds = YES;
        self.contentView.layer.cornerRadius = 8;
    }return self;
}

-(void)drawRect:(CGRect)rect{
    [super drawRect:rect];
    if (!self.isOK) {
        self.icon.alpha = 1;
        self.isOK = YES;
    }
}
#pragma mark —— lazyLoad
-(UIImageView *)icon{
    if (!_icon) {
        _icon = UIImageView.new;
        _icon.contentMode = UIViewContentModeScaleAspectFill;
        _icon.layer.masksToBounds = YES;
        [self.contentView addSubview:_icon];
        [_icon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.contentView);
        }];
    }return _icon;
}

@end
