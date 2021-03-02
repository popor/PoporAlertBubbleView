//
//  AlertBubbleFrame.m
//  AlertBubbleView
//
//  Created by apple on 2018/9/18.
//  Copyright © 2018年 popor. All rights reserved.
//

#import "AlertBubbleFrame.h"
#import "AlertBubbleView.h"

@implementation AlertBubbleFrame

+ (void)moveCustomView:(UIView *)customView // 中间显示的自定义view
            bubbleView:(UIView *)bubbleView // 自定义视图的气泡view
              baseView:(UIView *)baseView   // 自定义view和气泡view所在的view
            arroudRect:(CGRect)arroudRect
       AlertBubbleView:(AlertBubbleView *)abView
{
    AlertBubbleViewDirection direction = abView.direction;
    NSArray * directionSortArray       = abView.directionSortArray;
    
    CGFloat trangleWidth  = abView.trangleWidth;
    CGFloat trangleHeight = abView.trangleHeight;
    
    // t target 焦点rect
    CGFloat tX  = arroudRect.origin.x;
    CGFloat tY  = arroudRect.origin.y;
    CGFloat tW  = arroudRect.size.width;
    CGFloat tH  = arroudRect.size.height;
    
    // t c 焦点对应的custome rect
    CGFloat tCX = tX + tW/2;
    CGFloat tCY = tY + tH/2;
    
    __block CGRect  cRect;
    __block CGRect  bRect;
    __block CGPoint point;
    __block float trangleX = 0;
    __block float trangleY = 0;
    
    UIEdgeInsets mixInset =
    UIEdgeInsetsMake(abView.borderInset.top    +abView.customInset.top,
                     abView.borderInset.left   +abView.customInset.left,
                     abView.borderInset.bottom +abView.customInset.bottom,
                     abView.borderInset.right  +abView.customInset.right);
    
    //....................................................................................
    BOOL (^ rectBlock)(AlertBubbleViewDirection) = ^(AlertBubbleViewDirection direction){
        switch (direction) {
            case AlertBubbleViewDirectionTop:{
                point = CGPointMake(tCX, tY);
                break;
            }
            case AlertBubbleViewDirectionLeft:{
                point = CGPointMake(tX, tCY);
                break;
            }
            case AlertBubbleViewDirectionBottom:{
                point = CGPointMake(tCX, tY +tH);
                break;
            }
            case AlertBubbleViewDirectionRight:{
                point = CGPointMake(tX +tW, tCY);
                break;
            }
            default:{
                direction = AlertBubbleViewDirectionTop;
                point = CGPointMake(tCX, tY);
                break;
            }
        }
        
        switch (direction) {
            case AlertBubbleViewDirectionTop:
            case AlertBubbleViewDirectionBottom:{
                
                if (point.x - mixInset.left < customView.frame.size.width/2) {
                    // 左 越界
                    trangleX = - (point.x - mixInset.left);
                }else if(abView.frame.size.width -mixInset.right -point.x < customView.frame.size.width/2){
                    // 右 越界
                    trangleX = - (customView.frame.size.width - (abView.frame.size.width -mixInset.right -point.x));
                }else{
                    trangleX = -customView.frame.size.width/2;
                }
                // 赋值
                if (direction == AlertBubbleViewDirectionTop) {
                    cRect = CGRectMake(point.x + trangleX, point.y - customView.frame.size.height
                                       , customView.frame.size.width, customView.frame.size.height);
                }else{
                    cRect = CGRectMake(point.x + trangleX, point.y
                                       , customView.frame.size.width, customView.frame.size.height);
                }
                break;
            }
            case AlertBubbleViewDirectionLeft:
            case AlertBubbleViewDirectionRight:{
                if (point.y -mixInset.top < customView.frame.size.height/2) { // 上 越界
                    trangleY = - (point.y -mixInset.top);
                    
                }else if (abView.frame.size.height -mixInset.bottom -point.y < customView.frame.size.height/2) { // 下 越界
                    trangleY = - (customView.frame.size.height - (abView.frame.size.height -mixInset.bottom -point.y));
                    
                }else{
                    trangleY = -customView.frame.size.height/2;
                    //trangleY = point.y;
                }
                // 赋值
                if (direction == AlertBubbleViewDirectionLeft) {
                    cRect = CGRectMake(point.x - customView.frame.size.width, point.y + trangleY
                                       , customView.frame.size.width, customView.frame.size.height);
                }else{
                    cRect = CGRectMake(point.x, point.y + trangleY
                                       , customView.frame.size.width, customView.frame.size.height);
                }
                
                break;
            }
                
            default:
                break;
        }
        
        switch (direction) {
            case AlertBubbleViewDirectionTop: {
                bRect = CGRectMake(cRect.origin.x    -abView.borderInset.left,
                                   cRect.origin.y    -abView.borderInset.top  -trangleHeight,
                                   cRect.size.width  +abView.borderInset.left +abView.borderInset.right,
                                   cRect.size.height +abView.borderInset.top  +abView.borderInset.bottom +trangleHeight);
                
                cRect = CGRectMake(cRect.origin.x, cRect.origin.y -trangleHeight, cRect.size.width, cRect.size.height);
                break;
            }
            case AlertBubbleViewDirectionBottom: {
                bRect = CGRectMake(cRect.origin.x    -abView.borderInset.left,
                                   cRect.origin.y    -abView.borderInset.top,
                                   cRect.size.width  +abView.borderInset.left +abView.borderInset.right,
                                   cRect.size.height +abView.borderInset.top  +abView.borderInset.bottom +trangleHeight);
                
                cRect = CGRectMake(cRect.origin.x, cRect.origin.y +trangleHeight, cRect.size.width, cRect.size.height);
                break;
            }
            case AlertBubbleViewDirectionLeft: {
                bRect = CGRectMake(cRect.origin.x    -abView.borderInset.left -trangleWidth,
                                   cRect.origin.y    -abView.borderInset.top,
                                   cRect.size.width  +abView.borderInset.left +abView.borderInset.right +trangleWidth,
                                   cRect.size.height +abView.borderInset.top  +abView.borderInset.bottom);
                
                cRect = CGRectMake(cRect.origin.x -trangleWidth, cRect.origin.y, cRect.size.width, cRect.size.height);
                break;
            }
            case AlertBubbleViewDirectionRight: {
                bRect = CGRectMake(cRect.origin.x    -abView.borderInset.left,
                                   cRect.origin.y    -abView.borderInset.top,
                                   cRect.size.width  +abView.borderInset.left +abView.borderInset.right +trangleWidth,
                                   cRect.size.height +abView.borderInset.top  +abView.borderInset.bottom);
                
                cRect = CGRectMake(cRect.origin.x +trangleWidth, cRect.origin.y, cRect.size.width, cRect.size.height);
                break;
            }
                
            default:
                break;
        }
        
        return [self checkAvaibleAbView:abView direction:direction bRect:bRect arroudRect:arroudRect];
    };
    
    //....................................................................................
    // 假如发现异常,那么重新查找合适的方向
    if (!rectBlock(direction)) {
        BOOL ok = NO;
        AlertBubbleViewDirection updateDirection = AlertBubbleViewDirectionNone;
        if (directionSortArray.count > 0) { // 使用自定义的书序检查
            for (NSNumber * number in directionSortArray) {
                NSInteger i = number.integerValue;
                if (direction == i) {
                    continue;
                }else{
                    if (rectBlock(i)) {
                        updateDirection = i;
                        ok = YES;
                        //NSLog(@"AlertBubbleView OK 2");
                        break;
                    }
                }
            }
        } else {
            for (NSInteger i = AlertBubbleViewDirectionTop; i<AlertBubbleViewDirectionError; i++) {
                if (direction == i) {
                    continue;
                }else{
                    if (rectBlock(i)) {
                        updateDirection = i;
                        ok = YES;
                        //NSLog(@"AlertBubbleView OK 2");
                        break;
                    }
                }
            }
        }
        if (!ok) {
            //NSLog(@"AlertBubbleView 提取失败");
        }else{
            direction = updateDirection;
        }
    }else{
        //NSLog(@"AlertBubbleView OK 1");
    }
    
    {
        // 传递回去参数
        customView.frame = cRect;
        bubbleView.frame = bRect;
        
        abView.direction = direction;
        abView.trangleX  = trangleX;
        abView.trangleY  = trangleY;
    }
}

+ (BOOL)checkAvaibleAbView:(AlertBubbleView *)abView
                 direction:(AlertBubbleViewDirection)direction
                     bRect:(CGRect)bRect
                arroudRect:(CGRect)arroudRect
{
    
    UIEdgeInsets availableInset = abView.customInset;
    CGRect availableRect =
    CGRectMake(availableInset.left,      availableInset.top,
               abView.frame.size.width  -availableInset.left -availableInset.right,
               abView.frame.size.height -availableInset.top  -availableInset.bottom);
    
    //    NSLog(@"\n\ndirection: %li", direction);
    //    NSLog(@"abView: %@", NSStringFromCGRect(abView.bounds));
    //    NSLog(@"arroudRect: %@", NSStringFromCGRect(arroudRect));
    //    NSLog(@"availableRect: %@", NSStringFromCGRect(availableRect));
    //    NSLog(@"bRect: %@.", NSStringFromCGRect(bRect));
    
    
    CGRect editBRect = CGRectInset(bRect, 0.1, 0.1); // 因为系统会给某个x,y,w,h, 增加0.000000012个单位. 导致判断失误.
    
    if (CGRectContainsRect(availableRect, editBRect)) {
        if (abView.showLogInfo) {
            //NSLog(@"AlertBubbleView %@, 显示范围未越界.", ABDArray[direction]);
        }
        switch (direction) {
            case AlertBubbleViewDirectionTop:
            case AlertBubbleViewDirectionBottom: {
                if (CGRectGetMaxX(editBRect) < arroudRect.origin.x || editBRect.origin.x > CGRectGetMaxX(arroudRect) ) {
                    return NO;
                }
                break;
            }
            case AlertBubbleViewDirectionLeft:
            case AlertBubbleViewDirectionRight: {
                if (CGRectGetMaxY(editBRect) < arroudRect.origin.y || editBRect.origin.y > CGRectGetMaxY(arroudRect) ) {
                    return NO;
                }
                break;
            }
                
            default:
                break;
        }
        return YES;
    }else{
        if (abView.showLogInfo) {
            NSLog(@"AlertBubbleView %@, 显示范围越界了, 可能是customInset过大或者其他问题.", ABDArray[direction]);
            
            //customView.alpha = 0.2;
            //bubbleView.alpha = 0.2;
            
            // // 显示边界线
            // UIView * colorView = ({
            //     UIView * view = [UIView new];
            //     view.frame             = editBRect;
            //     view.backgroundColor   = UIColor.clearColor;
            //     view.layer.borderWidth = 1;
            //     view.userInteractionEnabled = NO;
            //
            //     [abView insertSubview:view atIndex:0];
            //     view;
            // });
            //
            // switch (direction) {
            //     case AlertBubbleViewDirectionTop: {
            //         colorView.layer.borderColor = UIColor.redColor.CGColor;
            //         break;
            //     }
            //     case AlertBubbleViewDirectionBottom: {
            //         colorView.layer.borderColor = UIColor.blueColor.CGColor;
            //         break;
            //     }
            //     case AlertBubbleViewDirectionLeft: {
            //         colorView.layer.borderColor = UIColor.brownColor.CGColor;
            //         break;
            //     }
            //     case AlertBubbleViewDirectionRight: {
            //         colorView.layer.borderColor = UIColor.blackColor.CGColor;
            //         break;
            //     }
            //
            //     default:
            //         break;
            // }
            
        }
        return NO;
    }
}

@end
