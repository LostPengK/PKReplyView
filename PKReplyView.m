//
//  PKReplyView.m
//  JianBuXing
//
//  Created by 彭康 on 15/9/23.
//  Copyright (c) 2015年 pengkang. All rights reserved.
//

#import "PKReplyView.h"
#import <UIKit/UIKit.h>
#import "Masonry.h"


@interface PKReplyView()<UITextViewDelegate>

//*输入框 *//
@property(nonatomic,strong)UITextView *inputView;

/*发送按钮*/
@property(nonatomic,strong)UIButton *sendButton;

@property(nonatomic,assign)CGFloat  minHeight;

@property(nonatomic,assign)CGFloat  maxHeight;
@end


@implementation PKReplyView

-(instancetype)init{
    self = [super init];
    if (self ) {
        
        self.inputView = [[UITextView alloc]init];
        self.inputView.delegate = self;
        self.inputView.font = [UIFont systemFontOfSize:17];
        self.backgroundColor = UIColorFromRGB(0xb0b0b0);
        [self addSubview:self.inputView];
        [self.inputView.layer setCornerRadius:3];
        
        self.sendButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [self addSubview:self.sendButton];
        [self.sendButton addTarget:self action:@selector(send) forControlEvents:UIControlEventTouchUpInside];
        [self.sendButton setBackgroundColor:[UIColor whiteColor]];
        [self.sendButton setTitle:@"发送" forState:UIControlStateNormal];
        [self.sendButton setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];

        [self.sendButton.layer setBorderWidth:0.5];
        [self.sendButton.layer setCornerRadius:3];
        [self.sendButton.layer setBorderColor:UIColorFromRGB(0xeaeaea).CGColor];
        
        
        _minHeight = 50;
        _maxHeight = 100;
        
    }
    
    return self;
}


-(void)setMinHeight:(CGFloat)minHeight{
    
    _minHeight = minHeight;
}

-(void)setMaxHeight:(CGFloat)maxHeight{
    _maxHeight = maxHeight;
}


-(void)send{
    
    
    if (self.delegate&&[self.delegate respondsToSelector:@selector(sendMessage:)]) {
        [self.delegate sendMessage:self.inputView.text];
    }

}

-(void)updateConstraints{
    [super updateConstraints];
    
    [self.inputView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self).insets(UIEdgeInsetsMake(5, 5, 5, 80));
    }];
    
    [self.sendButton mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.mas_bottom).offset(-5);
        make.left.equalTo(self.inputView.mas_right).offset(10);
        make.width.equalTo(@(60));
        make.height.equalTo(@(40));
    }];
    

}




-(void)layoutIfNeeded{

    [super layoutIfNeeded];

}

-(void)clear{


}

-(void)resign{

    [_inputView resignFirstResponder];

}



#pragma  mark  UITextViewDelegate
-(void)textViewDidChange:(UITextView *)textView{
    
    if (textView.text.length) {
        [self.sendButton setTitleColor:mainColor forState:UIControlStateNormal];
    }else{
        [self.sendButton setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    }
    
    CGFloat finalHeigt = textView.contentSize.height+10;
    if (finalHeigt<_minHeight) {
        finalHeigt = _minHeight;
    }
    
    if (finalHeigt>_maxHeight) {
        finalHeigt =_maxHeight;
    }
    
    [self mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@(finalHeigt));
    }];
    
    [self updateConstraintsIfNeeded];
    
}

//- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range
// replacementText:(NSString *)text
//{
//    // Any new character added is passed in as the "text" parameter
//    if ([text isEqualToString:@"\n"]) {
//        // Be sure to test for equality using the "isEqualToString" message
//        
//        NSLog(@"added an \\n");
//        [textView resignFirstResponder];
//        
//        // Return NO so that the final '\n' character doesn't get added
//        //        return NO;
//    }
//    // For any other character return YES so that the text gets added to the view
//    return YES;
//}



@end
