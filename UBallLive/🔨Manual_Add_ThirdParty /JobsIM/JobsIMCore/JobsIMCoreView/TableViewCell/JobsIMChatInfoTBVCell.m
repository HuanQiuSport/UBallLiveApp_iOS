//
//  JobsIMChatInfoTBVCell.m
//  JobsIM
//
//  Created by Jobs on 2020/11/10.
//

#import "JobsIMChatInfoTBVCell.h"
#import "JobsIMChatInfoModel.h"

static inline CGFloat JobsIMChatInfoTimeLabWidth(){
    return 55;
}

static inline CGFloat JobsIMChatInfoTBVDefaultCellHeight(){
    return 50;
}

static inline CGFloat JobsIMChatInfoTBVChatContentLabWidth(){
    return MAINSCREEN_WIDTH - JobsIMChatInfoTimeLabWidth() - (JobsIMChatInfoTBVDefaultCellHeight() - 5) - 20;
}

static inline CGFloat JobsIMChatInfoTBVChatContentLabDefaultWidth(){
    return 30;
}

@interface JobsIMChatInfoTBVCell ()

@property(nonatomic,strong)UIImageView *iconIMGV;//用户头像
@property(nonatomic,strong)UIImageView *chatBubbleIMGV;//聊天气泡
@property(nonatomic,strong)UILabel *chatUserNameLab;//用户名
@property(nonatomic,strong)UILabel *chatContentLab;//聊天信息承接
@property(nonatomic,strong)UILabel *timeLab;
@property(nonatomic,strong)UILongPressGestureRecognizer *longPG;

@property(nonatomic,assign)InfoLocation infoLocation;
@property(nonatomic,strong)NSMutableArray <UIImage *>*chatBubbleMutArr;
@property(nonatomic,strong)NSMutableArray <UIMenuItem *>*menuItemMutArr;

@property(nonatomic,strong)NSMutableArray <MGSwipeButtonModel *>*leftBtnMutArr;
@property(nonatomic,strong)NSMutableArray <MGSwipeButtonModel *>*rightBtnMutArr;
//data
@property(nonatomic,strong)NSString *senderChatTextStr;//该聊天的文本信息
@property(nonatomic,strong)NSString *senderChatTextTimeStr;//该聊天的时间戳
@property(nonatomic,strong)NSString *senderUserNameStr;//用户名
@property(nonatomic,strong)UIImage *senderChatUserIconIMG;//该聊天的用户头像
@property(nonatomic,strong)NSString *identification;//该聊天对应的数据库坐标ID
@property(nonatomic,assign)CGFloat contentHeight;//内容高
@property(nonatomic,assign)CGFloat contentWidth;//内容宽

@end

@implementation JobsIMChatInfoTBVCell

+(instancetype)cellWithTableView:(UITableView *)tableView{
    JobsIMChatInfoTBVCell *cell = (JobsIMChatInfoTBVCell *)[tableView dequeueReusableCellWithIdentifier:ReuseIdentifier];
    if (!cell) {
        cell = [[JobsIMChatInfoTBVCell alloc] initWithStyle:UITableViewCellStyleDefault
                                            reuseIdentifier:ReuseIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.contentView.backgroundColor = kClearColor;
        cell.backgroundColor = kClearColor;
    }return cell;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style
             reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style
                    reuseIdentifier:reuseIdentifier]) {
        self.longPG.enabled = YES;
        self.swipeBackgroundColor = kClearColor;
        self.selectedBackgroundView = UIView.new;
        self.selectedBackgroundView.backgroundColor = [KYellowColor colorWithAlphaComponent:0.3];
        self.leftSwipeSettings.transition = MGSwipeTransitionBorder;
        self.rightSwipeSettings.transition = MGSwipeTransitionDrag;
        self.leftExpansion.buttonIndex = 0;
        self.leftExpansion.fillOnTrigger = NO;
        self.rightExpansion.buttonIndex = 0;
        self.rightExpansion.fillOnTrigger = YES;
        self.leftButtons = [self createLeftButtons];
        self.rightButtons = [self createRightButtons];
    }return self;
}

-(NSArray *)createLeftButtons{
    NSMutableArray * result = NSMutableArray.array;
    for (MGSwipeButtonModel *model in self.leftBtnMutArr) {
        MGSwipeButton * button = [MGSwipeButton buttonWithTitle:model.titleStr
                                                           icon:model.IconIMG
                                                backgroundColor:model.bgCor
                                                        padding:15
                                                       callback:^BOOL(MGSwipeTableCell * sender){
            NSLog(@"Convenience callback received (left).");
            return YES;
        }];
        [result addObject:button];
    }return result;
}

-(NSArray *)createRightButtons{
    NSMutableArray * result = NSMutableArray.array;
    for (MGSwipeButtonModel *model in self.rightBtnMutArr) {
        MGSwipeButton * button = [MGSwipeButton buttonWithTitle:model.titleStr
                                                           icon:model.IconIMG
                                                backgroundColor:model.bgCor
                                                        padding:15
                                                       callback:^BOOL(MGSwipeTableCell * sender){
            NSLog(@"Convenience callback received (left).");
            return YES;
        }];
        [result addObject:button];
    }return result;
}
#pragma mark - 长按手势事件
- (void)cellLongPress:(UIGestureRecognizer *)recognizer{
    if (recognizer.state == UIGestureRecognizerStateBegan) {
        JobsIMChatInfoTBVCell *cell = (JobsIMChatInfoTBVCell *)recognizer.view;
        //这里把cell做为第一响应(cell默认是无法成为responder,需要重写canBecomeFirstResponder方法)
        [cell becomeFirstResponder];
        
        UIMenuController *menuController = [UIMenuController sharedMenuController];
        //控制箭头方向
        menuController.arrowDirection = UIMenuControllerArrowDefault;
        //自定义事件
        [menuController setMenuItems:self.menuItemMutArr];
        
        if (@available(iOS 13.0, *)) {
            [menuController showMenuFromView:self
                                        rect:cell.chatBubbleIMGV.frame];
        }else{
#pragma clang diagnostic push
#pragma clang diagnostic ignored"-Wdeprecated-declarations"
            [menuController setTargetRect:cell.frame
                                   inView:self];
            [menuController setMenuVisible:YES
                                  animated:YES];
#pragma clang diagnostic pop
        }
    }
}

-(void)menuTopBtnPressed:(id)sender{
    NSLog(@"123");
}

-(void)menuDelBtnPressed:(id)sender{
    NSLog(@"456");
}

-(BOOL)canPerformAction:(SEL)action
             withSender:(id)sender{
    return action == @selector(menuDelBtnPressed:) || action == @selector(menuTopBtnPressed:);
}

+(CGFloat)cellHeightWithModel:(id _Nullable)model{
    if ([model isKindOfClass:JobsIMChatInfoModel.class]){
        JobsIMChatInfoModel *chatInfoModel = (JobsIMChatInfoModel *)model;
        CGFloat CellHeight = [NSString getContentHeightOrWidthWithParagraphStyleLineSpacing:0
                                                                      calcLabelHeight_Width:CalcLabelHeight
                                                                               effectString:chatInfoModel.senderChatTextStr
                                                                                       font:NULL
                                                               boundingRectWithHeight_Width:JobsIMChatInfoTBVChatContentLabWidth()];
        NSLog(@"%f",CellHeight);
        return (CellHeight < JobsIMChatInfoTBVDefaultCellHeight() ? JobsIMChatInfoTBVDefaultCellHeight() : CellHeight) + (JobsIMChatInfoTBVDefaultCellHeight() / 2 - 5);
    }else{
        return 0;
    }
}

-(void)richElementsInCellWithModel:(id _Nullable)model{
    if ([model isKindOfClass:JobsIMChatInfoModel.class]) {
        JobsIMChatInfoModel *chatInfoModel = (JobsIMChatInfoModel *)model;
        if ([chatInfoModel.identification isEqualToString:@"我是服务器"]) {//对方发的消息
            self.infoLocation = InfoLocation_Left;
        }else if ([chatInfoModel.identification isEqualToString:@"我是我自己"]){//自己发的消息
            self.infoLocation = InfoLocation_Right;
        }else{
            self.infoLocation = InfoLocation_Unknown;
        }
        
        self.senderChatTextStr = chatInfoModel.senderChatTextStr;
        self.senderChatTextTimeStr = chatInfoModel.senderChatTextTimeStr;
        self.senderChatUserIconIMG = chatInfoModel.senderChatUserIconIMG;
        self.senderUserNameStr = chatInfoModel.senderUserNameStr;
        self.identification = chatInfoModel.identification;
        
        //先定宽，再定高
        CGFloat contentWidthTemp = [NSString getContentHeightOrWidthWithParagraphStyleLineSpacing:0
                                                                            calcLabelHeight_Width:CalcLabelWidth
                                                                                     effectString:self.senderChatTextStr
                                                                                             font:NULL
                                                                     boundingRectWithHeight_Width:JobsIMChatInfoTBVDefaultCellHeight()];
        //保证最小宽度 且 小于最大宽度
        self.contentWidth = MIN(JobsIMChatInfoTBVChatContentLabWidth(), MAX(JobsIMChatInfoTBVChatContentLabDefaultWidth(), contentWidthTemp));
        
        self.contentHeight = [NSString getContentHeightOrWidthWithParagraphStyleLineSpacing:0
                                                                   calcLabelHeight_Width:CalcLabelHeight
                                                                            effectString:self.senderChatTextStr
                                                                                    font:NULL
                                                            boundingRectWithHeight_Width:self.contentWidth];
        
        NSLog(@"contentHeight = %f",self.contentHeight);
        NSLog(@"contentWidth = %f",self.contentWidth);
        
        self.iconIMGV.alpha = 1;
        self.chatUserNameLab.alpha = self.isShowChatUserName;
        self.chatBubbleIMGV.alpha = 1;
        self.chatContentLab.alpha = 1;
        self.timeLab.alpha= 1;
    }
}

- (BOOL)canBecomeFirstResponder{
    return YES;
}
#pragma mark —— lazyLoad
-(UIImageView *)iconIMGV{
    if (!_iconIMGV) {
        _iconIMGV = UIImageView.new;
        _iconIMGV.image = self.senderChatUserIconIMG;
        [self.contentView addSubview:_iconIMGV];
        [_iconIMGV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(JobsIMChatInfoTBVDefaultCellHeight() - 5, JobsIMChatInfoTBVDefaultCellHeight() - 5));
            make.top.equalTo(self.contentView).offset(5);
            
            switch (self.infoLocation) {
                case InfoLocation_Left:{
                    make.left.equalTo(self.contentView).offset(10);
                }break;
                case InfoLocation_Right:{
                    make.right.equalTo(self.contentView).offset(-10);
                }break;
                default:
                    break;
            }
        }];
    }return _iconIMGV;
}

-(UIImageView *)chatBubbleIMGV{
    if (!_chatBubbleIMGV) {
        _chatBubbleIMGV = UIImageView.new;
        
        switch (self.infoLocation) {
            case InfoLocation_Left:{
                _chatBubbleIMGV.image = self.chatBubbleMutArr[0];
            }break;
            case InfoLocation_Right:{
                _chatBubbleIMGV.image = self.chatBubbleMutArr[1];
            }break;
            default:
                break;
        }
        
        [self.contentView addSubview:_chatBubbleIMGV];
        [_chatBubbleIMGV mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.equalTo(self.iconIMGV.mas_centerY);
            make.bottom.equalTo(self.contentView).offset(-5);
            make.width.mas_equalTo(self.contentWidth);
            
            switch (self.infoLocation) {
                case InfoLocation_Left:{
                    make.left.equalTo(self.iconIMGV.mas_right).offset(5);
                    
                }break;
                case InfoLocation_Right:{
                    make.right.equalTo(self.iconIMGV.mas_left).offset(-5);
                }break;
                default:
                    break;
            }
        }];
    }return _chatBubbleIMGV;
}

-(UILabel *)chatUserNameLab{
    if (!_chatUserNameLab) {
        _chatUserNameLab = UILabel.new;
        _chatUserNameLab.textColor = kBlackColor;
        _chatUserNameLab.font = [UIFont systemFontOfSize:10 weight:UIFontWeightRegular];
        _chatUserNameLab.textAlignment = NSTextAlignmentCenter;
        _chatUserNameLab.text = self.senderUserNameStr;
        [_chatUserNameLab sizeToFit];
        [self.contentView addSubview:_chatUserNameLab];
        [_chatUserNameLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.iconIMGV);
            make.bottom.equalTo(self.iconIMGV.mas_centerY).offset(-3);
            switch (self.infoLocation) {
                case InfoLocation_Left:{
                    make.left.equalTo(self.iconIMGV.mas_right).offset(5);
                    
                }break;
                case InfoLocation_Right:{
                    make.right.equalTo(self.iconIMGV.mas_left).offset(-5);
                }break;
                default:
                    break;
            }
        }];
    }return _chatUserNameLab;
}

-(UILabel *)chatContentLab{
    if (!_chatContentLab) {
        _chatContentLab = UILabel.new;
        _chatContentLab.numberOfLines = 0;
        _chatContentLab.textColor = kBlackColor;
        _chatContentLab.font = [UIFont systemFontOfSize:10 weight:UIFontWeightRegular];
        
        switch (self.infoLocation) {
            case InfoLocation_Left:{
                _chatContentLab.textAlignment = NSTextAlignmentRight;
            }break;
            case InfoLocation_Right:{
                _chatContentLab.textAlignment = NSTextAlignmentLeft;
            }break;
            default:
                break;
        }
        
        _chatContentLab.text = self.senderChatTextStr;
        [self.chatBubbleIMGV addSubview:_chatContentLab];
        [_chatContentLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.chatBubbleIMGV).with.insets(UIEdgeInsetsMake(5, 5, 5, 5));
        }];
    }return _chatContentLab;
}

-(UILabel *)timeLab{
    if (!_timeLab) {
        _timeLab = UILabel.new;
        _timeLab.font = [UIFont systemFontOfSize:10 weight:UIFontWeightRegular];
        _timeLab.textAlignment = NSTextAlignmentCenter;
        _timeLab.text = self.senderChatTextTimeStr;
        _timeLab.textColor = kWhiteColor;
        _timeLab.backgroundColor = KLightGrayColor;
        [_timeLab sizeToFit];
        
        [self.contentView addSubview:_timeLab];
        [_timeLab mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.bottom.equalTo(self.chatBubbleIMGV);
            make.size.mas_equalTo(CGSizeMake(JobsIMChatInfoTimeLabWidth(), 20));
            
            switch (self.infoLocation) {
                case InfoLocation_Left:{
                    make.left.equalTo(self.chatBubbleIMGV.mas_right).offset(5);
                }break;
                case InfoLocation_Right:{
                    make.right.equalTo(self.chatBubbleIMGV.mas_left).offset(-5);
                }break;
                default:
                    break;
            }
        }];
        [UIView cornerCutToCircleWithView:_timeLab AndCornerRadius:20 / 2];
    }return _timeLab;
}

-(NSMutableArray<UIImage *> *)chatBubbleMutArr{
    if (!_chatBubbleMutArr) {
        _chatBubbleMutArr = NSMutableArray.array;
        [_chatBubbleMutArr addObject:KIMG(@"左气泡")];//左气泡
        [_chatBubbleMutArr addObject:KIMG(@"右气泡")];//右气泡
    }return _chatBubbleMutArr;
}

-(UILongPressGestureRecognizer *)longPG{
    if (!_longPG) {
        _longPG = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(cellLongPress:)];
        [self addGestureRecognizer:_longPG];
    }return _longPG;
}

-(NSMutableArray<UIMenuItem *> *)menuItemMutArr{
    if (!_menuItemMutArr) {
        _menuItemMutArr = NSMutableArray.array;
        [_menuItemMutArr addObject:[[UIMenuItem alloc] initWithTitle:@"置顶" action:@selector(menuTopBtnPressed:)]];
        [_menuItemMutArr addObject:[[UIMenuItem alloc] initWithTitle:@"删除" action:@selector(menuDelBtnPressed:)]];
    }return _menuItemMutArr;
}

-(NSMutableArray<MGSwipeButtonModel *> *)leftBtnMutArr{
    if (!_leftBtnMutArr) {
        _leftBtnMutArr = NSMutableArray.array;
        MGSwipeButtonModel *model_1 = MGSwipeButtonModel.new;
        model_1.titleStr = @"L1";
        model_1.IconIMG = KIMG(@"Check");
        model_1.bgCor = KGreenColor;
        
        MGSwipeButtonModel *model_2 = MGSwipeButtonModel.new;
        model_2.titleStr = @"L2";
        model_2.IconIMG = KIMG(@"Fav");
        model_2.bgCor = RGBA_COLOR(0, 0x99, 0xcc, 1);
        
        MGSwipeButtonModel *model_3 = MGSwipeButtonModel.new;
        model_3.titleStr = @"L3";
        model_3.IconIMG = KIMG(@"Menu");
        model_3.bgCor = RGBA_COLOR(0.59, 0.29, 0.08, 1);
        
        [_leftBtnMutArr addObject:model_1];
        [_leftBtnMutArr addObject:model_2];
        [_leftBtnMutArr addObject:model_3];
        
    }return _leftBtnMutArr;
}

-(NSMutableArray<MGSwipeButtonModel *> *)rightBtnMutArr{
    if (!_rightBtnMutArr) {
        _rightBtnMutArr = NSMutableArray.array;
        
        MGSwipeButtonModel *model_1 = MGSwipeButtonModel.new;
        model_1.titleStr = @"R1";
        model_1.IconIMG = KIMG(@"Class");
        model_1.bgCor = KPurpleColor;
        
        MGSwipeButtonModel *model_2 = MGSwipeButtonModel.new;
        model_2.titleStr = @"R2";
        model_2.IconIMG = KIMG(@"Drop");
        model_2.bgCor = KDarkTextColor;
        
        MGSwipeButtonModel *model_3 = MGSwipeButtonModel.new;
        model_3.titleStr = @"R3";
        model_3.IconIMG = KIMG(@"Header");
        model_3.bgCor = kCyanColor;
        
        [_rightBtnMutArr addObject:model_1];
        [_rightBtnMutArr addObject:model_2];
        [_rightBtnMutArr addObject:model_3];
        
    }return _rightBtnMutArr;
}

@end
