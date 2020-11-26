//
//  VideoTBVCell.m
//  UBallLive
//
//  Created by Jobs on 2020/10/27.
//

#import "UBLVideoTBVCell.h"

@interface UBLVideoTBVCell ()

@property(nonatomic,strong)UILabel *lineLab;
@property(nonatomic,strong)UILabel *timeLab;
@property(nonatomic,strong)UIView *contentsView;
@property(nonatomic,strong)UIImageView *imgview;
@property(nonatomic,strong)UILabel *titleLab;
@property(nonatomic,strong)UILabel *subTitleLab;
// data
@property(nonatomic,strong)NSString *timeStr;
@property(nonatomic,strong)UIImage *img;
@property(nonatomic,strong)NSString *titleStr;
@property(nonatomic,strong)NSString *subTitleStr;

@end

@implementation UBLVideoTBVCell

+(instancetype)cellWithTableView:(UITableView *)tableView{
    UBLVideoTBVCell *cell = (UBLVideoTBVCell *)[tableView dequeueReusableCellWithIdentifier:ReuseIdentifier];
    if (!cell) {
        cell = [[UBLVideoTBVCell alloc] initWithStyle:UITableViewCellStyleDefault
                                   reuseIdentifier:ReuseIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = RGBCOLOR(231, 243, 252);
        cell.contentView.backgroundColor = RGBCOLOR(231, 243, 252);
    }return cell;
}

+(CGFloat)cellHeightWithModel:(id _Nullable)model{
    return 170 + 35 + 20 + 4 * 2;
}

-(void)richElementsInCellWithModel:(id _Nullable)model{
    self.timeStr = @"13：50：00 开播";
    self.img = [UIImage animatedGIFNamed:@"⚽️PicResource/Gif/Bt9h"];
    self.titleStr = @" 中超B组第12轮 ";
    self.subTitleStr = @"北京国安 vs 四川全兴";
    
    self.lineLab.alpha = 1;
    self.timeLab.alpha = 1;
    self.contentsView.alpha = 1;
    self.imgview.alpha = 1;
    self.titleLab.alpha = 1;
    self.subTitleLab.alpha = 1;
}
#pragma mark —— lazyLoad
-(UILabel *)lineLab{
    if (!_lineLab) {
        _lineLab = UILabel.new;
        _lineLab.backgroundColor = HEXCOLOR(0x85A8D2);
        [self.contentView addSubview:_lineLab];
        [_lineLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(2);
            make.top.bottom.equalTo(self.contentView);
            make.left.equalTo(self.contentView).offset(9);
        }];
    }return _lineLab;
}

-(UILabel *)timeLab{
    if (!_timeLab) {
        _timeLab = UILabel.new;
        _timeLab.textColor = HEXCOLOR(0x7A7D8F);
        _timeLab.font = [UIFont systemFontOfSize:14
                                          weight:UIFontWeightMedium];
        _timeLab.text = self.timeStr;
        [_timeLab sizeToFit];
        [self.contentView addSubview:_timeLab];
        [_timeLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentView);
            make.left.equalTo(self.lineLab.mas_right).offset(18);
        }];
    }return _timeLab;
}

-(UIView *)contentsView{
    if (!_contentsView) {
        _contentsView = UIView.new;
        _contentsView.backgroundColor = kWhiteColor;
        [self.contentView addSubview:_contentsView];
        [_contentsView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.timeLab.mas_bottom).offset(4);
            make.left.equalTo(self.timeLab);
            make.height.mas_equalTo(170 + 35);
            make.right.equalTo(self.contentView).offset(-20);
        }];
        
        _contentsView.clipsToBounds = YES;
        _contentsView.layer.cornerRadius = 8.0f;
        _contentsView.layer.shadowColor = KLightGrayColor.CGColor;
        _contentsView.layer.shadowOffset = CGSizeMake(4, 4);
        _contentsView.layer.shadowRadius = 8.0f;
        _contentsView.layer.shadowOpacity = 0.7f;
        
        
    }return _contentsView;
}

-(UIImageView *)imgview{
    if (!_imgview) {
        _imgview = UIImageView.new;
        _imgview.image = self.img;
        [self.contentsView addSubview:_imgview];
        [_imgview mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.equalTo(self.contentsView);
            make.height.mas_equalTo(170);
        }];
    }return _imgview;
}

-(UILabel *)titleLab{
    if (!_titleLab) {
        _titleLab = UILabel.new;
        _titleLab.text = self.titleStr;
        _titleLab.textColor = HEXCOLOR(0x9B9B9B);
        _titleLab.backgroundColor = RGBCOLOR(243, 243, 243);
        _titleLab.font = [UIFont systemFontOfSize:10
                                           weight:UIFontWeightMedium];
        [self.contentsView addSubview:_titleLab];
        [_titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.imgview.mas_bottom).offset(12);
            make.left.equalTo(self.imgview).offset(18);
            make.height.mas_equalTo(14);
        }];
        [UIView cornerCutToCircleWithView:_titleLab AndCornerRadius:6];
    }return _titleLab;
}

-(UILabel *)subTitleLab{
    if (!_subTitleLab) {
        _subTitleLab = UILabel.new;
        _subTitleLab.font = [UIFont systemFontOfSize:13
                                              weight:UIFontWeightMedium];
        _subTitleLab.text = self.subTitleStr;
        [self.contentsView addSubview:_subTitleLab];
        [_subTitleLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.contentsView).offset(-11);
            make.centerY.equalTo(self.titleLab);
            make.height.mas_equalTo(18);
        }];
    }return _subTitleLab;
}


@end
