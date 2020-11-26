//
//  UBLVideoCollectionViewCell@Style10.m
//  UBallLive
//
//  Created by Jobs on 2020/10/31.
//

#import "UBLVideoCollectionViewCell@Style10.h"

@interface UBLVideoCollectionViewCell_Style10 ()

@property(nonatomic,strong)UIImageView *imageView;
@property(nonatomic,strong)UIImage *image;

@end

@implementation UBLVideoCollectionViewCell_Style10

-(void)dealloc {
    NSLog(@"Running self.class = %@;NSStringFromSelector(_cmd) = '%@';__FUNCTION__ = %s", self.class, NSStringFromSelector(_cmd),__FUNCTION__);
}

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = kWhiteColor;
        self.contentView.backgroundColor = kWhiteColor;
    }return self;
}

-(void)richElementsInCellWithModel:(id _Nullable)model{
    if ([model isKindOfClass:UIImage.class]) {
        self.image = (UIImage *)model;
        self.imageView.alpha = 1;
    }
}

+(CGSize)cellSizeWithModel:(id _Nullable)model{
    return CGSizeMake(92, 61);
}
#pragma mark —— lazyLoad
-(UIImageView *)imageView{
    if (!_imageView) {
        _imageView = UIImageView.new;
        _imageView.image = self.image;
        [self.contentView addSubview:_imageView];
        [_imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.contentView);
        }];
    }return _imageView;
}

@end
