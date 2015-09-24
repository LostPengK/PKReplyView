//
//  PKReplyView.h
//  JianBuXing
//
//  Created by 彭康 on 15/9/23.
//  Copyright (c) 2015年 pengkang. All rights reserved.
//

@protocol replyDelegate <NSObject>

-(void)sendMessage:(NSString *)messageString;

@end


#import <UIKit/UIKit.h>

@interface PKReplyView : UIView
@property(nonatomic,weak)id<replyDelegate>delegate;




/*发送消息*/
-(void)send;

/*清空*/
-(void)clear;

/*取消第一响应*/
-(void)resign;

/*设置回复控件的最大高度*/
-(void)setMaxHeight:(CGFloat)maxHeight;

/*设置回复控件的最大高度*/
-(void)setMinHeight:(CGFloat)minHeight;
@end
