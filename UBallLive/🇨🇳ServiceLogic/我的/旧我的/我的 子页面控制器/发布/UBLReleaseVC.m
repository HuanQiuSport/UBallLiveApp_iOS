//
//  ReleaseVC.m
//  UBallLive
//
//  Created by Jobs on 2020/10/25.
//

#import "UBLReleaseVC.h"

@interface UBLReleaseVC ()

@end

@implementation UBLReleaseVC

- (void)dealloc {
    NSLog(@"Running self.class = %@;NSStringFromSelector(_cmd) = '%@';__FUNCTION__ = %s", self.class, NSStringFromSelector(_cmd),__FUNCTION__);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
}


@end
