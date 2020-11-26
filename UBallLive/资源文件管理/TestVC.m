//
//  TestVC.m
//  UBallLive
//
//  Created by Jobs on 2020/11/3.
//

#import "TestVC.h"

@interface TestVC ()

@end

@implementation TestVC

- (void)dealloc {
    NSLog(@"Running self.class = %@;NSStringFromSelector(_cmd) = '%@';__FUNCTION__ = %s", self.class, NSStringFromSelector(_cmd),__FUNCTION__);
    PrintRetainCount(self);
}

- (instancetype)init{
    if (self = [super init]) {
//        @weakify(self)
        PrintRetainCount(self);
    }return self;
}

-(void)viewDidLoad{
    [super viewDidLoad];
    PrintRetainCount(self);
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.isHiddenNavigationBar = YES;//禁用系统的导航栏
    self.gk_navLeftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.backBtnCategory];
    [self hideNavLine];
}

-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    PrintRetainCount(self);
}

@end
