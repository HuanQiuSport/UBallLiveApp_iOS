//
//  FAPremierLeagueVC.m
//  UBallLive
//
//  Created by Jobs on 2020/10/29.
//

#import "UBLFAPremierLeagueVC.h"

@interface UBLFAPremierLeagueVC ()

@end

@implementation UBLFAPremierLeagueVC

- (void)dealloc {
    NSLog(@"Running self.class = %@;NSStringFromSelector(_cmd) = '%@';__FUNCTION__ = %s", self.class, NSStringFromSelector(_cmd),__FUNCTION__);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = RGBCOLOR(246, 246, 246);
}

@end
