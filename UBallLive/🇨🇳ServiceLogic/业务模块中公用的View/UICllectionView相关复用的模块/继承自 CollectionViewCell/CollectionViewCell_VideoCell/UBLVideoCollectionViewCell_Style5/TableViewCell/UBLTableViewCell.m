//
//  TableViewCell.m
//  UBallLive
//
//  Created by Jobs on 2020/10/20.
//

#import "UBLTableViewCell.h"

@interface UBLTableViewCell ()

@property(nonatomic,strong)UIImageView *headerIconImgV;
@property(nonatomic,strong)UILabel *titleLab;
@property(nonatomic,strong)UILabel *subTitleLab;

@property(nonatomic,strong)NSString *titleStr;
@property(nonatomic,strong)NSString *subTitleStr;

@end

@implementation UBLTableViewCell

+(instancetype)cellWithTableView:(UITableView *)tableView{
    UBLTableViewCell *cell = (UBLTableViewCell *)[tableView dequeueReusableCellWithIdentifier:ReuseIdentifier];
    if (!cell) {
        cell = [[UBLTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                       reuseIdentifier:ReuseIdentifier];
        cell.marginY = 5;
        cell.marginX = 5;
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.contentView.backgroundColor = kWhiteColor;
        cell.transform = CGAffineTransformMakeRotation(-M_PI / 2);
        cell.contentView.transform = CGAffineTransformMakeRotation(-M_PI / 2);
        
        [UIView cornerCutToCircleWithView:cell.contentView AndCornerRadius:8];
        
    }return cell;
}

+(CGFloat)cellHeightWithModel:(id _Nullable)model{
    return 57;
}

-(void)richElementsInCellWithModel:(id _Nullable)model{
    
    self.titleStr = @"小甜甜";
    self.subTitleStr = @"粉丝 1235";
    
    self.headerIconImgV.alpha = 1;
    self.titleLab.alpha = 1;
    self.subTitleLab.alpha = 1;
}
#pragma mark —— lazyLoad
-(UIImageView *)headerIconImgV{
    if (!_headerIconImgV) {
        _headerIconImgV = UIImageView.new;
        _headerIconImgV.image = KBuddleIMG(@"⚽️PicResource", @"头像", nil, @"头像_1");
        [self.contentView addSubview:_headerIconImgV];
        [_headerIconImgV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(45, 45));
            make.left.equalTo(self.contentView).offset(6);
            make.centerY.equalTo(self.contentView);
        }];
        [UIView cornerCutToCircleWithView:_headerIconImgV AndCornerRadius:45 / 2];
        
        //旋转完了以后中心偏移，需要提前记录并旋转以后进行修正
        CGFloat centerX = _headerIconImgV.centerX;
        CGFloat centerY = _headerIconImgV.centerY;
        
        _headerIconImgV.transform = CGAffineTransformMakeRotation(-M_PI / 2);
        
        _headerIconImgV.centerX = centerX;
        _headerIconImgV.centerY = centerY;
    }return _headerIconImgV;
}

-(UILabel *)titleLab{
    if (!_titleLab) {
        _titleLab = UILabel.new;
        _titleLab.textColor = kBlackColor;
        _titleLab.text = self.titleStr;
        _titleLab.font = [UIFont systemFontOfSize:9 weight:UIFontWeightMedium];
        [self.contentView addSubview:_titleLab];
        [_titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.contentView);
            make.left.equalTo(self.headerIconImgV.mas_right).offset(0);
        }];
        [self layoutIfNeeded];
        //旋转完了以后中心偏移，需要提前记录并旋转以后进行修正
        CGFloat centerX = _titleLab.centerX;
        CGFloat centerY = _titleLab.centerY;
        _titleLab.transform = CGAffineTransformMakeRotation(-M_PI / 2);
        _titleLab.centerY = centerY;
        _titleLab.centerX = centerX;
    }return _titleLab;
}

-(UILabel *)subTitleLab{
    if (!_subTitleLab) {
        _subTitleLab = UILabel.new;
        _subTitleLab.textColor = KLightGrayColor;
        _subTitleLab.font = [UIFont systemFontOfSize:7.5 weight:UIFontWeightMedium];
        _subTitleLab.text = self.subTitleStr;
        [self.contentView addSubview:_subTitleLab];
        [_subTitleLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.contentView);
            make.left.equalTo(self.headerIconImgV.mas_right).offset(8);
        }];
        [self layoutIfNeeded];
        //旋转完了以后中心偏移，需要提前记录并旋转以后进行修正
        CGFloat centerX = _subTitleLab.centerX;
        CGFloat centerY = _subTitleLab.centerY;
        _subTitleLab.transform = CGAffineTransformMakeRotation(-M_PI / 2);
        _subTitleLab.centerY = centerY;
        _subTitleLab.centerX = centerX;
    }return _subTitleLab;
}


@end
