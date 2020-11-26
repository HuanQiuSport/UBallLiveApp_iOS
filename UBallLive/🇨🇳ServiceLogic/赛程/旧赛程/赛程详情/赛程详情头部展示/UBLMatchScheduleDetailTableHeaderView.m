//
//  UBLMatchScheduleDetailTableHeaderView.m
//  UBallLive
//
//  Created by Jobs on 2020/11/2.
//

#import "UBLMatchScheduleDetailTableHeaderView.h"

#import "UBLMidView@Style1.h"
#import "UBLMidView@Style2.h"
#import "UBLMidView@Style3.h"
#import "UBLMidView@Style4.h"

#import "UIButton+CountDownBtn.h"

@interface UBLMatchScheduleDetailTableHeaderView ()

@property(nonatomic,strong)UIImageView *imageView;
@property(nonatomic,strong)UIButton *hostTeamBtn;
@property(nonatomic,strong)UIButton *guestTeamBtn;
@property(nonatomic,strong)UILabel *titleLab;

@property(nonatomic,strong)UBLMidView_Style1 *midView_Style1;
@property(nonatomic,strong)UBLMidView_Style2 *midView_Style2;
@property(nonatomic,strong)UBLMidView_Style3 *midView_Style3;
@property(nonatomic,strong)UBLMidView_Style4 *midView_Style4;

@property(nonatomic,copy)MKDataBlock matchScheduleDetailTableHeaderViewBlock;
@property(nonatomic,assign)CGRect imageViewFrame;
@property(nonatomic,assign)CGRect hostTeamBtnFrame;
@property(nonatomic,assign)CGRect guestTeamBtnFrame;
@property(nonatomic,assign)CGRect titleLabFrame;
@property(nonatomic,assign)CGRect midView_Style1Frame;
@property(nonatomic,assign)CGRect midView_Style2Frame;
@property(nonatomic,assign)CGRect midView_Style3Frame;
@property(nonatomic,assign)CGRect midView_Style4Frame;
@property(nonatomic,assign)BOOL isOK;
//data
@property(nonatomic,strong)NSString *hostTeamNameStr;
@property(nonatomic,strong)NSString *guestTeamNameStr;
@property(nonatomic,strong)NSString *titleStr_1;
@property(nonatomic,strong)NSString *titleStr_2;
@property(nonatomic,strong)UIImage *hostTeamIMG;
@property(nonatomic,strong)UIImage *guestTeamIMG;

@property(nonatomic,strong)NSMutableArray <RichLabelDataStringsModel *>*richLabelDataStringsMutArr;

@end

@implementation UBLMatchScheduleDetailTableHeaderView

-(void)dealloc{
    NSLog(@"Running self.class = %@;NSStringFromSelector(_cmd) = '%@';__FUNCTION__ = %s", self.class, NSStringFromSelector(_cmd),__FUNCTION__);
    [self.midView_Style1 timerDestroy];
}

-(instancetype)init{
    if (self = [super init]) {

    }return self;
}

-(void)drawRect:(CGRect)rect{
    [super drawRect:rect];
    if (!self.isOK) {
        
        self.hostTeamNameStr = @"河北华夏幸福(主)";
        self.guestTeamNameStr = @"广州恒大淘宝";
        
        self.titleStr_1 = @"韩国K联 第26轮";
        self.titleStr_2 = @"2020/09/09 18:00";
        
        self.hostTeamIMG = KIMG(@"巴塞罗那");
        self.guestTeamIMG = KIMG(@"皇家马德里");
        
        self.imageView.alpha = 1;
        self.hostTeamBtn.alpha = 1;
        self.guestTeamBtn.alpha = 1;
        self.titleLab.alpha = 1;
        
        switch (self.midView_Style) {
            case MidView_Style1:{
                self.midView_Style1.alpha = 1;
            }break;
            case MidView_Style2:{
                self.midView_Style2.alpha = 1;
            }break;
            case MidView_Style3:{
                self.midView_Style3.alpha = 1;
            }break;
            case MidView_Style4:{
                self.midView_Style4.alpha = 1;
            }break;
                
            default:
                break;
        }
    
        self.isOK = YES;
    }
}

-(void)scrollViewDidScroll:(CGFloat)contentOffsetY{
    if (self.isZoom) {
        
        CGRect imageViewFrame = self.imageViewFrame;
        imageViewFrame.size.height -= contentOffsetY;
        imageViewFrame.origin.y = contentOffsetY;
        self.imageView.frame = imageViewFrame;
        
        CGRect hostTeamBtnFrame = self.hostTeamBtnFrame;
        hostTeamBtnFrame.origin.y -= contentOffsetY;
        self.hostTeamBtn.frame = hostTeamBtnFrame;

        CGRect guestTeamBtnFrame = self.guestTeamBtnFrame;
        guestTeamBtnFrame.origin.y -= contentOffsetY;
        self.guestTeamBtn.frame = guestTeamBtnFrame;
        
        CGRect titleLabFrame = self.titleLabFrame;
        titleLabFrame.origin.y -= contentOffsetY;
        self.titleLab.frame = titleLabFrame;
        
        CGRect midView_Style1Frame = self.midView_Style1Frame;
        midView_Style1Frame.origin.y -= contentOffsetY;
        _midView_Style1.frame = midView_Style1Frame;
        
        CGRect midView_Style2Frame = self.midView_Style2Frame;
        midView_Style2Frame.origin.y -= contentOffsetY;
        _midView_Style2.frame = midView_Style2Frame;
        
        CGRect midView_Style3Frame = self.midView_Style3Frame;
        midView_Style3Frame.origin.y -= contentOffsetY;
        _midView_Style3.frame = midView_Style3Frame;
        
        CGRect midView_Style4Frame = self.midView_Style4Frame;
        midView_Style4Frame.origin.y -= contentOffsetY;
        _midView_Style4.frame = midView_Style4Frame;

    }
}

-(void)actiobBlockMatchScheduleDetailTableHeaderView:(MKDataBlock)matchScheduleDetailTableHeaderViewBlock{
    self.matchScheduleDetailTableHeaderViewBlock = matchScheduleDetailTableHeaderViewBlock;
}
#pragma mark —— lazyLoad
-(UIImageView *)imageView{
    if (!_imageView) {
        _imageView = UIImageView.new;
        _imageView.image = KBuddleIMG(@"⚽️PicResource", @"Others", nil, @"赛程背景图");
        [self addSubview:_imageView];
        if (self.isZoom) {
            _imageView.frame = CGRectMake(0,
                                          0,
                                          self.mj_w,
                                          self.mj_h);
            self.imageViewFrame = _imageView.frame;
        }else{
            [_imageView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.edges.equalTo(self);
            }];
        }
    }return _imageView;
}

-(UIButton *)hostTeamBtn{
    if (!_hostTeamBtn) {
        _hostTeamBtn = UIButton.new;
        _hostTeamBtn.userInteractionEnabled = NO;
        [_hostTeamBtn setTitleColor:kWhiteColor
                           forState:UIControlStateNormal];
        _hostTeamBtn.titleLabel.font = [UIFont systemFontOfSize:12
                                                         weight:UIFontWeightRegular];
        [_hostTeamBtn setTitle:self.hostTeamNameStr
                      forState:UIControlStateNormal];
        [_hostTeamBtn setImage:self.hostTeamIMG
                      forState:UIControlStateNormal];
        [self.imageView addSubview:_hostTeamBtn];
        _hostTeamBtn.mj_x = 0;
        _hostTeamBtn.mj_y = 100;
        _hostTeamBtn.mj_h = 90;
        _hostTeamBtn.mj_w = (MAINSCREEN_WIDTH - 109) / 2;
        self.hostTeamBtnFrame = _hostTeamBtn.frame;
        [_hostTeamBtn layoutButtonWithEdgeInsetsStyle:GLButtonEdgeInsetsStyleTop
                                      imageTitleSpace:4];
    }return _hostTeamBtn;
}

-(UIButton *)guestTeamBtn{
    if (!_guestTeamBtn) {
        _guestTeamBtn = UIButton.new;
        _guestTeamBtn.userInteractionEnabled = NO;
        [_guestTeamBtn setTitleColor:kWhiteColor
                            forState:UIControlStateNormal];
        _guestTeamBtn.titleLabel.font = [UIFont systemFontOfSize:12
                                                          weight:UIFontWeightRegular];
        [_guestTeamBtn setTitle:self.guestTeamNameStr
                       forState:UIControlStateNormal];
        [_guestTeamBtn setImage:self.guestTeamIMG
                       forState:UIControlStateNormal];
        [self.imageView addSubview:_guestTeamBtn];
        _guestTeamBtn.mj_w = (MAINSCREEN_WIDTH - 109) / 2;
        _guestTeamBtn.mj_x = MAINSCREEN_WIDTH - _guestTeamBtn.mj_w;
        _guestTeamBtn.mj_y = 100;
        _guestTeamBtn.mj_h = 90;
        self.guestTeamBtnFrame = _guestTeamBtn.frame;
        [_guestTeamBtn layoutButtonWithEdgeInsetsStyle:GLButtonEdgeInsetsStyleTop
                                       imageTitleSpace:4];
    }return _guestTeamBtn;
}

-(UILabel *)titleLab{
    if (!_titleLab) {
        _titleLab = UILabel.new;
        _titleLab.textColor = kWhiteColor;
//        _titleLab.text = self.titleStr;
        //富文本
        [NSObject makeRichTextWithDataConfigMutArr:self.richLabelDataStringsMutArr];
        _titleLab.numberOfLines = 0;
        _titleLab.font = [UIFont systemFontOfSize:14 weight:UIFontWeightMedium];
        _titleLab.lineBreakMode = NSLineBreakByWordWrapping;
        [_titleLab sizeToFit];
        [self.imageView addSubview:_titleLab];
        _titleLab.mj_w = 107;
//        _titleLab.size = CGSizeMake(107, 38);
        _titleLab.mj_y = rectOfStatusbar() + 20;
        _titleLab.mj_x = MAINSCREEN_WIDTH / 2 - 107 / 2;
        self.titleLabFrame = _titleLab.frame;
    }return _titleLab;
}

-(UBLMidView_Style1 *)midView_Style1{
    if (!_midView_Style1) {
        _midView_Style1 = [[UBLMidView_Style1 alloc] initWithType:CountDownBtnType_countDown
                                                          runType:CountDownBtnRunType_auto
                                                 layerBorderWidth:1
                                                layerCornerRadius:1
                                                 layerBorderColor:kClearColor
                                                       titleColor:kWhiteColor
                                                    titleBeginStr:@""
                                                   titleLabelFont:[UIFont systemFontOfSize:20 weight:UIFontWeightMedium]];
        
        _midView_Style1.titleRuningStr = @"开始倒计时";
        _midView_Style1.showTimeType = ShowTimeType_HHMMSS;
        _midView_Style1.bgCountDownColor = kClearColor;
        _midView_Style1.countDownBtnNewLineType = CountDownBtnNewLineType_newLine;
        
        [_midView_Style1 timeFailBeginFrom:9999];

        [self addSubview:_midView_Style1];
        _midView_Style1.size = CGSizeMake(109, 52);
        _midView_Style1.mj_y = self.hostTeamBtn.centerY;
        _midView_Style1.centerX = self.titleLab.centerX;
        self.midView_Style1Frame = _midView_Style1.frame;
    }return _midView_Style1;
}

-(UBLMidView_Style2 *)midView_Style2{
    if (!_midView_Style2) {
        _midView_Style2 = UBLMidView_Style2.new;
        [self addSubview:_midView_Style2];
        _midView_Style2.size = CGSizeMake(109, 52);
        _midView_Style2.mj_y = self.hostTeamBtn.centerY;
        _midView_Style2.centerX = self.titleLab.centerX;
        self.midView_Style2Frame = _midView_Style2.frame;
    }return _midView_Style2;
}

-(UBLMidView_Style3 *)midView_Style3{
    if (!_midView_Style3) {
        _midView_Style3 = UBLMidView_Style3.new;
        [self addSubview:_midView_Style3];
        _midView_Style3.size = CGSizeMake(109, 52);
        _midView_Style3.mj_y = self.hostTeamBtn.centerY;
        _midView_Style3.centerX = self.titleLab.centerX;
        self.midView_Style3Frame = _midView_Style3.frame;
    }return _midView_Style3;
}

-(UBLMidView_Style4 *)midView_Style4{
    if (!_midView_Style4) {
        _midView_Style4 = UBLMidView_Style4.new;
        [self addSubview:_midView_Style4];
        _midView_Style4.size = CGSizeMake(109, 52);
        _midView_Style4.mj_y = self.hostTeamBtn.centerY;
        _midView_Style4.centerX = self.titleLab.centerX;
        self.midView_Style4Frame = _midView_Style4.frame;
    }return _midView_Style4;
}

-(NSMutableArray<RichLabelDataStringsModel *> *)richLabelDataStringsMutArr{
    if (!_richLabelDataStringsMutArr) {
        _richLabelDataStringsMutArr = NSMutableArray.array;
        
        RichLabelFontModel *richLabelFontModel_1 = RichLabelFontModel.new;
        richLabelFontModel_1.font = [UIFont systemFontOfSize:14 weight:UIFontWeightMedium];
        richLabelFontModel_1.range = NSMakeRange(0, self.titleStr_1.length);
        
        RichLabelFontModel *richLabelFontModel_2 = RichLabelFontModel.new;
        richLabelFontModel_2.font = [UIFont fontWithName:@"Helvetica" size:12];
        richLabelFontModel_2.range = NSMakeRange(self.titleStr_1.length, self.titleStr_2.length);
        
        RichLabelTextCorModel *richLabelTextCorModel_1 = RichLabelTextCorModel.new;
        richLabelTextCorModel_1.cor = HEXCOLOR(0xFFFFFF);
        richLabelTextCorModel_1.range = NSMakeRange(0, self.titleStr_1.length);

        RichLabelTextCorModel *richLabelTextCorModel_2 = RichLabelTextCorModel.new;
        richLabelTextCorModel_2.cor = HEXCOLOR(0xFFFFFF);
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
