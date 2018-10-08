//
//  AlertBubbleHead.h
//  AlertBubbleView
//
//  Created by apple on 2018/9/18.
//  Copyright © 2018年 popor. All rights reserved.
//

#ifndef AlertBubbleHead_h
#define AlertBubbleHead_h

// 以targetRect为中心点
#define ABDArray @[@"NAN", @"上", @"下", @"左", @"右", @"Error"]
typedef NS_ENUM(int, AlertBubbleViewDirection) {
    AlertBubbleViewDirectionNone = 0,
    
    AlertBubbleViewDirectionTop, // 优先顺序
    AlertBubbleViewDirectionBottom,
    AlertBubbleViewDirectionLeft,
    AlertBubbleViewDirectionRight,
    
    AlertBubbleViewDirectionError,
};

#endif /* AlertBubbleHead_h */
