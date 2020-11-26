//
//  UBLEarlyOfMatchVC.m
//  UBallLive
//
//  Created by Jobs on 2020/11/2.
//

#import "UBLEarlyOfMatchVC.h"

@interface UBLEarlyOfMatchVC ()

@end

@implementation UBLEarlyOfMatchVC

-(void)dealloc {
    NSLog(@"Running self.class = %@;NSStringFromSelector(_cmd) = '%@';__FUNCTION__ = %s", self.class, NSStringFromSelector(_cmd),__FUNCTION__);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = RandomColor;
}


@end
