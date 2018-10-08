//
//  AlertBubbleBezierPath.h
//  AlertBubbleView
//
//  Created by apple on 2018/9/18.
//  Copyright © 2018年 popor. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "AlertBubbleHead.h"

@interface AlertBubbleBezierPath : NSObject

+ (UIBezierPath *)pathAtClipView:(UIView *)clipView
                       direction:(AlertBubbleViewDirection)direction
                           scale:(float)scale
                       triangleX:(float)triangleX
                       triangleY:(float)triangleY
                       triangleW:(float)triangleW
                       triangleH:(float)triangleH
                    cornerRadius:(float)cornerRadius;

@end
