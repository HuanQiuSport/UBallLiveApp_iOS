//
//  UBLMyTBVCell.m
//  UBallLive
//
//  Created by Jobs on 2020/11/19.
//

#import "UBLMyTBVCell.h"

#import "UBLMineInfoModel.h"


@interface UBLMyTBVCell ()

@property(nonatomic,strong)UIImageView *headerIMGV;
@property(nonatomic,strong)UIImage *headerIMG;

@end

@implementation UBLMyTBVCell

+(instancetype)cellWithTableView:(UITableView *)tableView{
    UBLMyTBVCell *cell = (UBLMyTBVCell *)[tableView dequeueReusableCellWithIdentifier:ReuseIdentifier];
    if (!cell) {
        cell = [[UBLMyTBVCell alloc] initWithStyle:UITableViewCellStyleValue1
                                   reuseIdentifier:ReuseIdentifier];
        cell.contentView.backgroundColor = kWhiteColor;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.textLabel.font = [UIFont systemFontOfSize:15 weight:UIFontWeightRegular];
        cell.textLabel.textColor = RGBCOLOR(50, 50, 50);
    }return cell;
}

+(CGFloat)cellHeightWithModel:(id _Nullable)model{
    return 50;
}

- (void)setMineInfoModel:(UBLMineInfoModel *)mineInfoModel{
    
    self.textLabel.text = mineInfoModel.leftStr;
    self.detailTextLabel.text = mineInfoModel.rightStr;

}

- (void)setHeadImage:(UIImage *)headImage{
    self.headerIMG = headImage;
    self.headerIMGV.alpha = 1;
}

-(void)richElementsInCellWithModel:(id _Nullable)model{
    if ([model isKindOfClass:UIImage.class]) {
        self.headerIMG = KBuddleIMG(@"⚽️PicResource", @"头像", nil, @"头像_1");
        self.headerIMGV.alpha = 1;
    }else if ([model isKindOfClass:NSString.class]){
        self.detailTextLabel.text = model;
    }else{}
}
#pragma mark —— lazyLoad
-(UIImageView *)headerIMGV{
    if (!_headerIMGV) {
        _headerIMGV = UIImageView.new;
        _headerIMGV.image = self.headerIMG;
        [self.contentView addSubview:_headerIMGV];
        [_headerIMGV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(40, 40));
            make.centerY.equalTo(self.contentView);
            make.right.equalTo(self.contentView).offset(-10);
        }];
        [UIView cornerCutToCircleWithView:_headerIMGV AndCornerRadius:40 / 2];
    }return _headerIMGV;
}


@end
