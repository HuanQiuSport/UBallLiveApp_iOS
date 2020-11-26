//
//  DynamicVC.m
//  UBallLive
//
//  Created by Jobs on 2020/10/25.
//

#import "UBLDynamicVC.h"

@interface UBLDynamicVC ()

@property (nonatomic, copy) void(^listScrollViewScrollBlock)(UIScrollView *scrollView);

@end

@implementation UBLDynamicVC

- (void)dealloc {
    NSLog(@"Running self.class = %@;NSStringFromSelector(_cmd) = '%@';__FUNCTION__ = %s", self.class, NSStringFromSelector(_cmd),__FUNCTION__);
}

- (void)viewDidLoad {
    [super viewDidLoad];

}




@end
