//
//  main.m
//  UBallLive
//
//  Created by Jobs on 2020/10/9.
//

#import "UBLAppDelegate.h"
#import <UIKit/UIKit.h>
//                            _ooOoo_
//                           o8888888o
//                           88" . "88
//                           (| -_- |)
//                            O\ = /O
//                        ____/`---'\____
//                      .   ' \\| |// `.
//                       / \\||| : |||// \
//                     / _||||| -:- |||||- \
//                       | | \\\ - /// | |
//                     | \_| ''\---/'' | |
//                      \ .-\__ `-` ___/-. /
//                   ___`. .' /--.--\ `. . __
//                ."" '< `.___\_<|>_/___.' >'"".
//               | | : `- \`.;`\ _ /`;.`/ - ` : | |
//                 \ \ `-. \_ __\ /__ _/ .-` / /
//         ======`-.____`-.___\_____/___.-`____.-'======
//                            `=---='
//
//         .............................................
//                  佛祖镇楼                  BUG辟易
//          佛曰:
//                  写字楼里写字间，写字间里程序员；
//                  程序人员写程序，又拿程序养技师。
//                  醒时只在网上坐，迎来技师网下眠；
//                  灯红酒红日复日，网上网下年复年。
//                  但愿老死电脑间，不愿鞠躬老板前；
//                  奔驰宝马贵者趣，公交自行程序员。
//                  别人笑我忒疯癫，我笑自己命太贱；
//                  不见满街漂亮妹，哪个归得程序员？

int main(int argc, char * argv[]) {
    NSString * appDelegateClassName;
    @autoreleasepool {
        NSArray *array = @[@"  (___)\n",
                           @"  (o o)\n",
                           @"   \\ /\n",
                           @" \\--O--/\n",
                           @"// -----\\\n",
                           @"\\\\/_^{} /==V===[]\n",
                           @"  \\_____\\\\//\n",
                           @"   \\__/\n",
                           @"   //\\\\         The Boss\n",
                           @"   //  \\\\   (JOBS HuanQiu)\n",
                           @"   //   //\n",
                           @"   ^^    ^^\n"];
        NSArray *Array1 =@[
            @"                _______\n",
            @"               |   |   |\n",
            @"               |___|___|\n",
            @"               |\\_____/|\n",
            @"               |       |\n",
            @"               |_______|\n",
            @"           _   |   _   |\n",
            @"  /-------//   |--(_)--|\n",
            @" / |     ||    |_______|  (__)\n",
            @"*  ||----||    |       |  (++)\n",
            @"   ^^    ^^    |_______|   \\/\n",
            @"     Marie Antoinette's Cow\n"];
        NSLog(@"%@",[array componentsJoinedByString:@""]);
        NSLog(@"\n\n\n\n\n\n\n\n\n\n");
        NSLog(@"快醒来，牛奶来了%@",[Array1 componentsJoinedByString:@""]);
        NSArray *Array2 = @[
            @"\n",
            @"\n",
            @"\n",
            @"\n",
            @"                            _ooOoo_\n",
            @"                           o8888888o\n",
            @"                           88\" . \"88\n",
            @"                           (| -_- |)\n\n",
            @"                            O\\ = /O\n",
            @"                        ____/`---'\\____\n",
            @"                      .   ' \\| |// `.\n",
            @"                       / \\||| : |||// \\\n",
            @"                     / _||||| -:- |||||- \\\n",
            @"                       | | \\\\ - /// | |\n",
            @"                     | \\_| ''\\---/'' | |\n",
            @"                      \\ .-\\__ `-` ___/-. /\n",
            @"                   ___`. .' /--.--\\ `. . __\n",
            @"                  ."" '< `.___\\_<|>_/___.' >'"".\n",
            @"               | | : `- \\`.;`\\ _ /`;.`/ - ` : | |\n",
            @"                 \\ \\ `-. \\_ __\\ /__ _/ .-` / /\n",
            @"         ======`-.____`-.___\\_____/___.-`____.-'======\n",
            @"                            `=---='\n",
            @"\n",
            @"         .............................................\n",
            @"                  佛祖镇楼                  BUG辟易\n",
            @"          佛曰:\n",
            @"                  写字楼里写字间，写字间里程序员；\n",
            @"                  程序人员写程序，又拿程序养技师。\n",
            @"                  醒时只在网上坐，迎来技师网下眠；\n",
            @"                  灯红酒红日复日，网上网下年复年。\n",
            @"                  但愿老死电脑间，不愿鞠躬老板前；\n",
            @"                  奔驰宝马贵者趣，公交自行程序员。\n",
            @"                  别人笑我忒疯癫，我笑自己命太贱；\n",
            @"                  不见满街漂亮妹，哪个归得程序员？\n",
            @"                  四方来，八方去，一行一行又一行, \n",
            @"                  南来罐，西来杯，罐空杯尽伤满怀。\n"
        ];
        NSLog(@"哦吼，你来了%@",[Array2 componentsJoinedByString:@""]);
        
        
        // Setup code that might create autoreleased objects goes here.
        appDelegateClassName = NSStringFromClass([UBLAppDelegate class]);
    }
 
    return UIApplicationMain(argc, argv, nil, appDelegateClassName);
}
