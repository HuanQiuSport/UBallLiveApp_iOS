//
//  ViewController@1.m
//  U球直播
//
//  Created by Jobs on 2020/10/9.
//

#import "ViewController@1.h"

SuspendBtn *viewController_1_suspendBtn;//extern 外界可以对其进行开始和停止操作

@interface ViewController_1 ()

@property(nonatomic,strong)SuspendBtn *suspendBtn;//单个VC里面的旋转按钮,当在旋转的时候不能被拖动

@end

@implementation ViewController_1

- (void)dealloc {
    NSLog(@"Running self.class = %@;NSStringFromSelector(_cmd) = '%@';__FUNCTION__ = %s", self.class, NSStringFromSelector(_cmd),__FUNCTION__);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.suspendBtn.alpha = 1;
    self.view.backgroundColor = RandomColor;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches
          withEvent:(UIEvent *)event{
    [self.suspendBtn stopRotateAnimation];
    
    [self.navigationController pushViewController:ViewController_5.new animated:YES];
}
#pragma mark —— lazyLoad
-(SuspendBtn *)suspendBtn{
    if (!_suspendBtn) {
        _suspendBtn = SuspendBtn.new;
        viewController_1_suspendBtn = _suspendBtn;
        [_suspendBtn setImage:KBuddleIMG(@"⚽️PicResource",
                                         @"Others",
                                         nil,
                                         @"旋转")
                     forState:UIControlStateNormal];
        _suspendBtn.isAllowDrag = YES;//悬浮效果必须要的参数
        @weakify(self)
        self.view.vc = weak_self;
        [self.view addSubview:_suspendBtn];
        _suspendBtn.frame = CGRectMake(80, 100, 50, 50);
        [UIView cornerCutToCircleWithView:_suspendBtn AndCornerRadius:25];
        [[_suspendBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
            @strongify(self)
            [self->_suspendBtn startRotateAnimation];
            
        }];
    }return _suspendBtn;
}



@end
