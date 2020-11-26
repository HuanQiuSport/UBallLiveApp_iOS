//
//  ViewController@4.m
//  U球直播
//
//  Created by Jobs on 2020/10/9.
//

#import "ViewController@4.h"

@interface ViewController_4 ()

@end

@implementation ViewController_4

- (void)dealloc {
    NSLog(@"Running self.class = %@;NSStringFromSelector(_cmd) = '%@';__FUNCTION__ = %s", self.class, NSStringFromSelector(_cmd),__FUNCTION__);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = RandomColor;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

@end
