//
//  AlertBubbleFrame.h
//  AlertBubbleView
//
//  Created by apple on 2018/9/18.
//  Copyright © 2018年 popor. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AlertBubbleHead.h"

@class AlertBubbleView;
/*
 策略: bubbleView和boxView的superView相同.
 */
@interface AlertBubbleFrame : NSObject

+ (void)moveCustomView:(UIView *)customView // 中间显示的自定义view
            bubbleView:(UIView *)bubbleView // 自定义视图的气泡view
              baseView:(UIView *)baseView   // 自定义view和气泡view所在的view
            arroudRect:(CGRect)targetRect
       AlertBubbleView:(AlertBubbleView *)abView;

@end
