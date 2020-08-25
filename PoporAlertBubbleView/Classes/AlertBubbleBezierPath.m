//
//  AlertBubbleBezierPath.m
//  AlertBubbleView
//
//  Created by apple on 2018/9/18.
//  Copyright © 2018年 popor. All rights reserved.
//

#import "AlertBubbleBezierPath.h"

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
        case AlertBubbleViewDirectionTop:
        case AlertBubbleViewDirectionBottom: {
            // 左越界 判断
            if (triangleX <triangleW +cornerRadius +2) {
                triangleX = triangleW +cornerRadius +2;
            }
            
            // 右越界 判断
            if (triangleX > clipView.frame.size.width - cornerRadius - triangleW -2) {
                triangleX = clipView.frame.size.width - cornerRadius - triangleW -2;
            }
            
            break;
        }
        case AlertBubbleViewDirectionLeft:
        case AlertBubbleViewDirectionRight: {
            // 上越界 判断
            if (triangleY <triangleH +cornerRadius +2) {
                triangleY = triangleH +cornerRadius +2;
            }
            
            // 下越界 判断
            if (triangleY > clipView.frame.size.height -cornerRadius -triangleH -2) {
                triangleY = clipView.frame.size.height -cornerRadius -triangleH -2;
            }
            break;
        }
        default:
            break;
    }
    
    switch (direction) {
        case AlertBubbleViewDirectionTop:{
            /*
             *   ❶**************❷
             *   0              *
             *   *              *
             *   *              *
             *   *              *
             *   *              *
             *   ❹*** **********❸
             *       v
             */
            float maxX = clipView.frame.size.width;
            float maxH = clipView.frame.size.height - triangleH;
            
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
            
            [path addLineToPoint:CGPointMake(triangleX, clipView.frame.size.height)];
            
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
             *       ^
             *   ❶*** **********❷
             *   *              *
             *   *              *
             *   *              *
             *   *              *
             *   *              *
             *   ❹**************❸
             */
            float maxX = clipView.frame.size.width;
            float minY = triangleH;
            float maxH = clipView.frame.size.height;// - triangleH
            
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
             *   0              *
             *   *              *
             *   *                >
             *   *              *
             *   *              *
             *   ❹**************❸
             */
            float maxX = clipView.frame.size.width - triangleW;
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
            [path addLineToPoint:CGPointMake(clipView.frame.size.width, triangleY)];
            [path addLineToPoint:CGPointMake(maxX, triangleY + triangleH)];
            
            // 第2个拐角到第3个
            [path addLineToPoint:CGPointMake(maxX, clipView.frame.size.height - cornerRadius)];
            [path addQuadCurveToPoint:CGPointMake(maxX - cornerRadius, clipView.frame.size.height)
                         controlPoint:CGPointMake(maxX, clipView.frame.size.height)];
            // 第3个拐角到第4个
            [path addLineToPoint:CGPointMake(cornerRadius, clipView.frame.size.height)];
            [path addQuadCurveToPoint:CGPointMake(0, clipView.frame.size.height - cornerRadius)
                         controlPoint:CGPointMake(0, clipView.frame.size.height)];
            // 收尾
            [path addLineToPoint:CGPointMake(0, cornerRadius)];
            break;
        }
        case AlertBubbleViewDirectionRight:{
            /*
             *    ❶**************❷
             *    *              *
             *    *              *
             *  <                *
             *    *              *
             *    0              *
             *    ❹**************❸
             */
            // 尖角到第1个拐角
            [path moveToPoint:CGPointMake(0, triangleY)];
            [path addLineToPoint:CGPointMake(triangleW, triangleY - triangleH)];
            [path addLineToPoint:CGPointMake(triangleW, cornerRadius)];
            [path addQuadCurveToPoint:CGPointMake(triangleW + cornerRadius, 0)
                         controlPoint:CGPointMake(triangleW, 0)];
            // 第1个拐角到第2个
            [path addLineToPoint:CGPointMake(clipView.frame.size.width - cornerRadius, 0)];
            [path addQuadCurveToPoint:CGPointMake(clipView.frame.size.width, cornerRadius)
                         controlPoint:CGPointMake(clipView.frame.size.width, 0)];
            // 第2个拐角到第3个
            [path addLineToPoint:CGPointMake(clipView.frame.size.width, clipView.frame.size.height - cornerRadius)];
            [path addQuadCurveToPoint:CGPointMake(clipView.frame.size.width - cornerRadius, clipView.frame.size.height)
                         controlPoint:CGPointMake(clipView.frame.size.width, clipView.frame.size.height)];
            // 第3个拐角到第4个
            [path addLineToPoint:CGPointMake(triangleW + cornerRadius, clipView.frame.size.height)];
            [path addQuadCurveToPoint:CGPointMake(triangleW, clipView.frame.size.height - cornerRadius)
                         controlPoint:CGPointMake(triangleW, clipView.frame.size.height)];
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
