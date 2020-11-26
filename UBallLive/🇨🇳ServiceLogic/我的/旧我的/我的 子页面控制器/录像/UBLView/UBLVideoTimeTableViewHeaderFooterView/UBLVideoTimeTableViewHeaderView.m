//
//  VideoTimeHoveringHeaderView.m
//  UBallLive
//
//  Created by Jobs on 2020/10/27.
//

#import "UBLVideoTimeTableViewHeaderView.h"

@interface UBLVideoTimeTableViewHeaderView ()

@property(nonatomic,strong)UIImageView *dotIMGV;
@property(nonatomic,strong)UILabel *topLineLab;
@property(nonatomic,strong)UILabel *buttomLineLab;
@property(nonatomic,strong)UILabel *timeLab;

@property(nonatomic,assign)BOOL isOK;
@property(nonatomic,copy)MKDataBlock videoTimeHoveringHeaderViewBlock;
@property(nonatomic,strong)NSString *timeStr;

@end

@implementation UBLVideoTimeTableViewHeaderView

-(instancetype)initWithReuseIdentifier:(nullable NSString *)reuseIdentifier
                              withData:(id)data{
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        self.timeStr = @"09.24 昨天";
        self.backgroundColor = RGBCOLOR(231, 243, 252);
        self.contentView.backgroundColor = RGBCOLOR(231, 243, 252);
    }return self;
}

-(void)drawRect:(CGRect)rect{
    [super drawRect:rect];
    if (!self.isOK) {
        self.dotIMGV.alpha = 1;
        self.timeLab.alpha = 1;

        if (self.indexSection) {
            self.topLineLab.alpha = 1;
        }
        
        self.buttomLineLab.alpha = 1;
        self.isOK = YES;
    }
}

-(void)actionBlockVideoTimeHoveringHeaderView:(MKDataBlock _Nullable)videoTimeHoveringHeaderViewBlock{
    self.videoTimeHoveringHeaderViewBlock = videoTimeHoveringHeaderViewBlock;
}
#pragma mark —— lazyLoad
-(UIImageView *)dotIMGV{
    if (!_dotIMGV) {
        _dotIMGV = UIImageView.new;
        if (self.indexSection) {
            _dotIMGV.image = KBuddleIMG(@"⚽️PicResource",
                                        @"Others",
                                        nil,
                                        @"椭圆形");
        }else{
            _dotIMGV.image = KBuddleIMG(@"⚽️PicResource",
                                        @"Others",
                                        nil,
                                        @"椭圆形（空心）");
        }
        [self.contentView addSubview:_dotIMGV];
        [_dotIMGV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.contentView);
            make.left.equalTo(self.contentView).offset(4);
            make.size.mas_equalTo(CGSizeMake(11, 11));
        }];
    }return _dotIMGV;
}

-(UILabel *)topLineLab{
    if (!_topLineLab) {
        _topLineLab = UILabel.new;
        _topLineLab.backgroundColor = HEXCOLOR(0x85A8D2);
        [self.contentView addSubview:_topLineLab];
        [_topLineLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.dotIMGV.mas_top).offset(-6);
            make.top.equalTo(self.contentView);
            make.width.mas_equalTo(2);
            make.centerX.equalTo(self.dotIMGV);
        }];
    }return _topLineLab;
}

-(UILabel *)buttomLineLab{
    if (!_buttomLineLab) {
        _buttomLineLab = UILabel.new;
        _buttomLineLab.backgroundColor = HEXCOLOR(0x85A8D2);
        [self.contentView addSubview:_buttomLineLab];
        [_buttomLineLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.dotIMGV.mas_bottom).offset(6);
            make.centerX.equalTo(self.dotIMGV);
            make.bottom.equalTo(self.contentView);
            make.width.mas_equalTo(2);
        }];
    }return _topLineLab;
}

-(UILabel *)timeLab{
    if (!_timeLab) {
        _timeLab = UILabel.new;
        _timeLab.text = self.timeStr;
        _timeLab.font = [UIFont systemFontOfSize:16
                                          weight:UIFontWeightMedium];
        _timeLab.textColor = HEXCOLOR(0x85A8D2);
        [_timeLab sizeToFit];
        [self.contentView addSubview:_timeLab];
        [_timeLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.contentView);
            make.left.equalTo(self.dotIMGV.mas_right).offset(14);
            
        }];
    }return _timeLab;
}

@end
