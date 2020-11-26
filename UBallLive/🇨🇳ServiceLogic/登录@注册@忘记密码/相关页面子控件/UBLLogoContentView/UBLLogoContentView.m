//
//  LogoContentView.m
//  Shooting
//
//  Created by Jobs on 2020/9/3.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import "UBLLogoContentView.h"

@interface UBLLogoContentView ()

@property(nonatomic,strong)UIImageView *mainImgV;
@property(nonatomic,strong)UIImageView *subImgV;
@property(nonatomic,assign)BOOL isOK;

@end

@implementation UBLLogoContentView

- (void)dealloc {
//    NSLog(@"Running self.class = %@;NSStringFromSelector(_cmd) = '%@';__FUNCTION__ = %s", self.class, NSStringFromSelector(_cmd),__FUNCTION__);
}

#pragma mark - Lifecycle
-(instancetype)init{
    if (self = [super init]) {
        
    }return self;
}

-(void)drawRect:(CGRect)rect{
    [super drawRect:rect];
    if (!self.isOK) {
        self.mainImgV.alpha = 1;
        self.subImgV.alpha = 1;
        self.isOK = YES;
    }
}

#pragma mark —— lazyLoad
-(UIImageView *)mainImgV{
    if (!_mainImgV) {
        _mainImgV = UIImageView.new;
        _mainImgV.image = KBuddleIMG(@"⚽️PicResource", @"登录@注册@忘记密码", nil, @"MainLogo");
        [self addSubview:_mainImgV];
        [_mainImgV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.left.equalTo(self);
            make.width.mas_equalTo(self.mj_h);
        }];
    }return _mainImgV;
}

-(UIImageView *)subImgV{
    if (!_subImgV) {
        _subImgV = UIImageView.new;
        _subImgV.image = KBuddleIMG(@"⚽️PicResource", @"登录@注册@忘记密码", nil, @"SubLogo");
        [self addSubview:_subImgV];
        [_subImgV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.right.equalTo(self);
            make.left.equalTo(self.mainImgV.mas_right);
        }];
    }return _subImgV;
}

@end
