//
//  UBLCollectionViewCellImageView.h
//  UBallLive
//
//  Created by Jobs on 2020/11/9.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
//UIImageView的子类不会调用-(void)drawRect:(CGRect)rect方法
@interface UBLCollectionViewCellImageView : UIImageView

@property(nonatomic,strong,nullable)UIImage *firstFrameFigureIMG;//首帧图
@property(nonatomic,strong,nullable)NSString *videoURLString;//视频资源地址

-(instancetype)initWithFirstFrameFigureIMG:(UIImage *)firstFrameFigureIMG
                            videoURLString:(NSString *)videoURLString;

@end

NS_ASSUME_NONNULL_END
