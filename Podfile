# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

# 下面两行是指明依赖库的来源地址
source 'https://github.com/CocoaPods/Specs.git'# 使用官方默认地址（默认）
source 'https://github.com/Artsy/Specs.git'# 使用其他来源地址

# install! 只走一次，多次使用只以最后一个标准执行
# deterministic_uuids 解决与私有库的冲突
# generate_multiple_pod_projects 可以让每个依赖都作为一个单独的项目引入，大大增加了解析速度；cocoapods 1.7 以后支持
# disable_input_output_paths ？？？
# 需要特别说明的：在 post_install 时，为了一些版本的兼容，需要遍历所有 target，调整一部分库的版本；但是如果开启了 generate_multiple_pod_projects 的话，由于项目结构的变化，installer.pod_targets 就没办法获得所有 pods 引入的 target 了
install! 'cocoapods',:deterministic_uuids=>false,generate_multiple_pod_projects: true,disable_input_output_paths: true

platform :ios, '9.0'
inhibit_all_warnings!
use_frameworks!
#pod 'CocoaAsyncSocket'
# 特别说明：Ruby对大小写敏感，所以方法名不要用大写，否则执行失败

def longConnection
  pod 'CocoaAsyncSocket' # https://github.com/robbiehanson/CocoaAsyncSocket WebSocket的OC框架
  # CocoaAsyncSocket 的学习资料
  # https://juejin.im/post/6844904062408720391#heading-0
  # https://www.jianshu.com/p/9153d5628363
  pod 'MQTTClient' # https://github.com/novastone-media/MQTT-Client-Framework
  end
# 单元测试框架
def testApp

  end
# 调试框架
def debugPods
  pod 'DoraemonKit' # https://github.com/didi/DoraemonKit 滴滴打车出的工具 NO_SMP
#  pod 'CocoaDebug' # https://github.com/CocoaDebug/CocoaDebug NO_SMP
  pod 'FLEX'  # https://github.com/Flipboard/FLEX 调试界面相关插件 NO_SMP
  pod 'JJException' # https://github.com/jezzmemo/JJException 保护App,一般常见的问题不会导致闪退，增强App的健壮性，同时会将错误抛出来，根据每个App自身的日志渠道记录 NO_SMP
  pod 'FBRetainCycleDetector' # https://github.com/facebook/FBRetainCycleDetector
  end
# 几乎每个App都会用到的
def appCommon
  pod 'Masonry' # https://github.com/SnapKit/Masonry NO_SMP
  pod 'AFNetworking' # https://github.com/AFNetworking/AFNetworking YES_SMP
  pod 'Reachability'  # https://github.com/tonymillion/Reachability 检查联网情况 NO_SMP 
  pod 'IQKeyboardManager' # https://github.com/hackiftekhar/IQKeyboardManager Codeless drop-in universal library allows to prevent issues of keyboard sliding up and cover UITextField/UITextView. Neither need to write any code nor any setup required and much more.  YES_SMP
  pod 'ReactiveObjC' # https://github.com/ReactiveCocoa/ReactiveObjC NO_SMP
  pod 'MJRefresh' # https://github.com/CoderMJLee/MJRefresh NO_SMP
  pod 'MJExtension' # https://github.com/CoderMJLee/MJExtension NO_SMP
  pod 'SDWebImage' # https://github.com/SDWebImage/SDWebImage YES_SMP
  pod 'MBProgressHUD', '~> 1.2.0' #toast
#  pod 'YYKit' # https://github.com/ibireme/YYKit NO_SMP
  end
## GK一族
def gk
  pod 'GKNavigationBar' # https://github.com/QuintGao/GKNavigationBar NO_SMP
  end
## JX一族
def jx
  pod 'JXCategoryView' # https://github.com/pujiaxin33/JXCategoryView NO_SMP
  pod 'JXPagingView/Pager' # https://github.com/pujiaxin33/JXPagingView NO_SMP
  end
## 提示框
def alert
  pod 'SPAlertController'# https://github.com/SPStore/SPAlertController 深度定制AlertController NO_SMP
  pod 'TFPopup'# https://github.com/shmxybfq/TFPopup 不耦合view代码,可以为已创建过 / 未创建过的view添加弹出方式;只是一种弹出方式;
  end
# UI相关
def ui
  pod 'MGSwipeTableCell' # https://github.com/MortimerGoro/MGSwipeTableCell 滑动tableViewCell
  pod 'Shimmer' # Facebook 推出的一款具有闪烁效果的第三方控件
  pod 'RQShineLabel'  # https://github.com/zipme/RQShineLabel 一个类似Secret文字渐变效果的开源库
  pod 'SZTextView' # https://github.com/glaszig/SZTextView SZTextView 用于替代内置的 UITextView，实现了 placeholder
  pod 'BRPickerView'  # https://github.com/91renb/BRPickerView 该组件封装的是iOS中常用的选择器组件，主要包括：日期选择器、时间选择器（DatePickerView）、地址选择器（AddressPickerView）、自定义字符串选择器（StringPickerView）。支持自定义主题样式，适配深色模式，支持将选择器组件添加到指定容器视图。
  pod 'LYEmptyView' # https://github.com/dev-liyang/LYEmptyView iOS一行代码集成空白页面占位图(无数据、无网络占位图)
#  pod 'ZZCircleProgress' # https://github.com/zhouxing5311/ZZCircleProgress 可以高度自定义的环形进度条 我用手动pods管理
  pod 'FLAnimatedImageView+RGWrapper' #
  pod 'PPBadgeView' # https://github.com/jkpang/PPBadgeView iOS自定义Badge组件, 支持UIView, UITabBarItem, UIBarButtonItem以及子类 NO_SMP
  pod 'WHToast' # https://github.com/remember17/WHToast 一个轻量级的提示控件，没有任何依赖 NO_SMP
#  pod 'WMZBanner' # https://github.com/wwmz/WMZBanner WMZBanner - 最好用的轻量级轮播图+卡片样式+自定义样式 NO_SMP 我用手动pods管理
  gk # GK一族
  jx # JX一族
  alert # 提示框
  
  end
# 视频相关
def videoFunc
  pod 'ZFPlayer'
  pod 'ZFPlayer/ControlView'
  pod 'ZFPlayer/AVPlayer'
  pod 'ZFPlayer/ijkplayer'
#  pod 'KTVHTTPCache' # 边下边播
  pod 'VIMediaCache' # https://github.com/vitoziv/VIMediaCache 边下边播
  end
# 一些功能性
def func
  pod 'TXFileOperation' # 文件夹操作
  pod 'TZImagePickerController'## 相册选择
  pod 'JPImageresizerView' # https://github.com/Rogue24/JPImageresizerView 一个专门裁剪图片、GIF、视频的轮子，简单易用，功能丰富（高自由度的参数设定、支持旋转和镜像翻转、蒙版、压缩等），能满足绝大部分裁剪的需求。
  pod 'lottie-ios', '~> 2.5.3' # 这是OC终极版本

  videoFunc # 视频相关
  end
# 基础的公共配置
def cocoPodsConfig
  target 'UBallLiveTests' do
    inherit! :search_paths # abstract! 指示当前的target是抽象的，因此不会直接链接Xcode target。与其相对应的是 inherit！
    # Pods for testing
    end
  
  target 'UBallLiveUITests' do
    inherit! :search_paths
    # Pods for testing
    end
  
  # 当我们下载完成，但是还没有安装之时，可以使用hook机制通过pre_install指定要做更改，更改完之后进入安装阶段。 格式如下：
  pre_install do |installer|
      # 做一些安装之前的更改
    end
  
  # 这个是cocoapods的一些配置,官网并没有太详细的说明,一般采取默认就好了,也就是不写.
  post_install do |installer|
    installer.pods_project.targets.each do |target|

      # 当我们安装完成，但是生成的工程还没有写入磁盘之时，我们可以指定要执行的操作。 比如，我们可以在写入磁盘之前，修改一些工程的配置：

      puts "!!!! #{target.name}"
      end
    end
  end

# 由上而下编译，不像OC那么智能，故只能先写定义后调用
target 'UBallLive' do
  # Pods for UBallLive
#  testApp # 单元测试框架
  longConnection # 长链接框架
  debugPods # 调试框架
  appCommon # 几乎每个App都会用到的
  ui # UI相关
  func # 一些功能性
  
  cocoPodsConfig # 基础的公共配置
end
