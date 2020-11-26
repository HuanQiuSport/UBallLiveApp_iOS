//
//  JobsIMChatInfoModel.h
//  JobsIM
//
//  Created by Jobs on 2020/11/10.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface JobsIMChatInfoModel : NSObject

//消息的发送者
@property(nonatomic,copy,nullable)NSString *senderUserID;//发出该聊天的用户ID
@property(nonatomic,copy,nullable)NSString *senderUserNameStr;//发出该聊天的用户名
@property(nonatomic,strong,nullable)UIImage *senderChatUserIconIMG;//发出该聊天的用户头像
@property(nonatomic,copy,nullable)NSString *senderChatUserIconURLStr;//发出该聊天的用户头像地址
@property(nonatomic,copy,nullable)NSString *senderChatTextStr;//发出该聊天的文本信息
@property(nonatomic,copy,nullable)NSString *senderChatTextTimeStr;//发出该聊天的时间戳
//消息的接受者
@property(nonatomic,copy,nullable)NSString *receiverUserID;//接受该聊天的用户ID
@property(nonatomic,copy,nullable)NSString *receiverUserNameStr;//接受该聊天的用户名
@property(nonatomic,strong,nullable)UIImage *receiverChatUserIconIMG;//接受该聊天的用户头像
@property(nonatomic,copy,nullable)NSString *receiverChatUserIconURLStr;//接受该聊天的用户头像地址
//全局ID
@property(nonatomic,copy,nullable)NSString *identification;//该聊天对应的数据库坐标ID

@end

NS_ASSUME_NONNULL_END
