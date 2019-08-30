//
//  AlertBubbleBezierPath.m
//  AlertBubbleView
//
//  Created by apple on 2018/9/18.
//  Copyright © 2018年 popor. All rights reserved.
//

#import "AlertBubbleBezierPath.h"
#import <PoporUI/UIView+pExtension.h>

@implementation AlertBubbleBezierPath

+ (UIBezierPath *)pathAtClipView:(UIView *)clipView
                       direction:(AlertBubbleViewDirection)direction
                           scale:(float)scale
                       triangleX:(float)triangleX
                       triangleY:(float)triangleY
                       triangleW:(float)triangleW
                       triangleH:(float)triangleH
                    cornerRadius:(float)cornerRadius
{
    triangleW    = triangleW * scale;
    triangleH    = triangleH * scale;
    triangleX    = triangleX * scale;
    triangleY    = triangleY * scale;
    cornerRadius = cornerRadius * scale;
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    switch (direction) {
        case AlertBubbleViewDirectionTop:{
            /*
             *   ❶**************❷
             *   *              *
             *   *              *
             *   *              *
             *   *              *
             *   *              *
             *   ❹*** **********❸
             *       v
             */
            float maxX = clipView.width;
            float maxH = clipView.height - triangleH;
            
            // 第一个拐角
            [path moveToPoint:CGPointMake(0, cornerRadius)];
            [path addQuadCurveToPoint:CGPointMake(cornerRadius, 0)
                         controlPoint:CGPointMake(0, 0)];
            // 第1个拐角到第2个
            [path addLineToPoint:CGPointMake(maxX - cornerRadius, 0)];
            [path addQuadCurveToPoint:CGPointMake(maxX, cornerRadius)
                         controlPoint:CGPointMake(maxX, 0)];
            
            // 第2个拐角到第3个
            [path addLineToPoint:CGPointMake(maxX, maxH - cornerRadius)];
            [path addQuadCurveToPoint:CGPointMake(maxX-cornerRadius, maxH)
                         controlPoint:CGPointMake(maxX, maxH)];
            // 第3个拐角到尖角
            [path addLineToPoint:CGPointMake(triangleX + triangleW, maxH)];
            
            [path addLineToPoint:CGPointMake(triangleX, clipView.height)];
            
            [path addLineToPoint:CGPointMake(triangleX - triangleW, maxH)];
            
            // 第3个拐角到第4个
            [path addLineToPoint:CGPointMake(cornerRadius, maxH)];
            [path addQuadCurveToPoint:CGPointMake(0, maxH - cornerRadius)
                         controlPoint:CGPointMake(0, maxH)];
            // 收尾
            [path addLineToPoint:CGPointMake(0, cornerRadius)];
            
            break;
        }
        case AlertBubbleViewDirectionBottom:{
            /*
             *   ❶***^**********❷
             *   *              *
             *   *              *
             *   *              *
             *   *              *
             *   *              *
             *   ❹**************❸
             */
            float maxX = clipView.width;
            float minY = triangleH;
            float maxH = clipView.height;// - triangleH
            
            // 第一个拐角
            [path moveToPoint:CGPointMake(0, minY+cornerRadius)];
            [path addQuadCurveToPoint:CGPointMake(cornerRadius, minY)
                         controlPoint:CGPointMake(0, minY)];
            // 第1个拐角到尖角
            [path addLineToPoint:CGPointMake(triangleX - triangleW, minY)];
            
            [path addLineToPoint:CGPointMake(triangleX, 0)];
            
            [path addLineToPoint:CGPointMake(triangleX + triangleW, minY)];
            
            // 第1个拐角到第2个
            [path addLineToPoint:CGPointMake(maxX - cornerRadius, minY)];
            [path addQuadCurveToPoint:CGPointMake(maxX, minY+cornerRadius)
                         controlPoint:CGPointMake(maxX, minY)];
            
            // 第2个拐角到第3个
            [path addLineToPoint:CGPointMake(maxX, maxH - cornerRadius)];
            [path addQuadCurveToPoint:CGPointMake(maxX-cornerRadius, maxH)
                         controlPoint:CGPointMake(maxX, maxH)];
            
            // 第3个拐角到第4个
            [path addLineToPoint:CGPointMake(cornerRadius, maxH)];
            [path addQuadCurveToPoint:CGPointMake(0, maxH - cornerRadius)
                         controlPoint:CGPointMake(0, maxH)];
            // 收尾
            [path addLineToPoint:CGPointMake(0, cornerRadius)];
            
            break;
        }
        case AlertBubbleViewDirectionLeft:{
            /*
             *   ❶**************❷
             *   *              *
             *   *              *
             *   *               >
             *   *              *
             *   *              *
             *   ❹**************❸
             */
            float maxX = clipView.width - triangleW;
            // 第一个拐角
            [path moveToPoint:CGPointMake(0, cornerRadius)];
            [path addQuadCurveToPoint:CGPointMake(cornerRadius, 0)
                         controlPoint:CGPointMake(0, 0)];
            // 第1个拐角到第2个
            [path addLineToPoint:CGPointMake(maxX - cornerRadius, 0)];
            [path addQuadCurveToPoint:CGPointMake(maxX, cornerRadius)
                         controlPoint:CGPointMake(maxX, 0)];
            // 完整的尖角
            [path addLineToPoint:CGPointMake(maxX, triangleY - triangleH)];
            [path addLineToPoint:CGPointMake(clipView.width, triangleY)];
            [path addLineToPoint:CGPointMake(maxX, triangleY + triangleH)];
            
            // 第2个拐角到第3个
            [path addLineToPoint:CGPointMake(maxX, clipView.height - cornerRadius)];
            [path addQuadCurveToPoint:CGPointMake(maxX - cornerRadius, clipView.height)
                         controlPoint:CGPointMake(maxX, clipView.height)];
            // 第3个拐角到第4个
            [path addLineToPoint:CGPointMake(cornerRadius, clipView.height)];
            [path addQuadCurveToPoint:CGPointMake(0, clipView.height - cornerRadius)
                         controlPoint:CGPointMake(0, clipView.height)];
            // 收尾
            [path addLineToPoint:CGPointMake(0, cornerRadius)];
            break;
        }
        case AlertBubbleViewDirectionRight:{
            /*
             *   ❶**************❷
             *   *              *
             *   *              *
             *  <               *
             *   *              *
             *   *              *
             *   ❹**************❸
             */
            // 尖角到第1个拐角
            [path moveToPoint:CGPointMake(0, triangleY)];
            [path addLineToPoint:CGPointMake(triangleW, triangleY - triangleH)];
            [path addLineToPoint:CGPointMake(triangleW, cornerRadius)];
            [path addQuadCurveToPoint:CGPointMake(triangleW + cornerRadius, 0)
                         controlPoint:CGPointMake(triangleW, 0)];
            // 第1个拐角到第2个
            [path addLineToPoint:CGPointMake(clipView.width - cornerRadius, 0)];
            [path addQuadCurveToPoint:CGPointMake(clipView.width, cornerRadius)
                         controlPoint:CGPointMake(clipView.width, 0)];
            // 第2个拐角到第3个
            [path addLineToPoint:CGPointMake(clipView.width, clipView.height - cornerRadius)];
            [path addQuadCurveToPoint:CGPointMake(clipView.width - cornerRadius, clipView.height)
                         controlPoint:CGPointMake(clipView.width, clipView.height)];
            // 第3个拐角到第4个
            [path addLineToPoint:CGPointMake(triangleW + cornerRadius, clipView.height)];
            [path addQuadCurveToPoint:CGPointMake(triangleW, clipView.height - cornerRadius)
                         controlPoint:CGPointMake(triangleW, clipView.height)];
            // 第4个拐角到拐角
            [path addLineToPoint:CGPointMake(triangleW, triangleY + triangleH)];
            [path addLineToPoint:CGPointMake(0, triangleY)];
            break;
        }
        default:
            [path closePath];
            return nil;
    }
    
    // 关闭
    [path closePath];
    {
        CAShapeLayer * shapeLayer = [CAShapeLayer layer];
        shapeLayer.path = path.CGPath;
        
        [clipView.layer setMask:shapeLayer];
    }
    return path;
}

@end
