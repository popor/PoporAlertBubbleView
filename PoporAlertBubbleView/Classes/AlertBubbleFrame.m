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
    
    CGFloat customeViewInnerGap = abView.customeViewInnerGap ;// lable insertEdge  gap
    CGFloat miniGap             = abView.miniGap;// borderInnerGap + customeViewInnerGap
    CGFloat borderInnerGap      = abView.borderInnerGap;// lable insertEdge  gap
    CGFloat trangleHeight       = abView.trangleHeight;
    
    CGFloat tX  = arroudRect.origin.x;
    CGFloat tY  = arroudRect.origin.y;
    CGFloat tW  = arroudRect.size.width;
    CGFloat tH  = arroudRect.size.height;
    CGFloat tCX = tX + tW/2;
    CGFloat tCY = tY + tH/2;
    
    __block CGRect  cRect;
    __block CGRect  bRect;
    __block CGPoint point;
    __block float trangleX;
    __block float trangleY;
    
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
                point = CGPointMake(tCX, tY+tH);
                break;
            }
            case AlertBubbleViewDirectionRight:{
                point = CGPointMake(tX+tW, tCY);
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
                if (point.x - miniGap < customView.frame.size.width/2) {
                    // 左 越界
                    trangleX = - (point.x - miniGap);
                }else if(abView.frame.size.width - miniGap - point.x < customView.frame.size.width/2){
                    // 右 越界
                    trangleX = - (customView.frame.size.width - (abView.frame.size.width - miniGap - point.x));
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
                if (point.y - miniGap < customView.frame.size.height/2) {
                    // 上 越界
                    trangleY = - (point.y - miniGap);
                    
                }else if (abView.frame.size.height - miniGap - point.y < customView.frame.size.height/2) {
                    // 下 越界
                    trangleY = - (customView.frame.size.height - (abView.frame.size.height - miniGap - point.y));
                }else{
                    trangleY = -customView.frame.size.height/2;
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
        // 目前bRect和cRect的super相同.
        // 计算纠正bRect
        bRect = CGRectInset(cRect, -customeViewInnerGap, -customeViewInnerGap);
        switch (direction) {
                
            case AlertBubbleViewDirectionLeft:{
                bRect = CGRectMake(bRect.origin.x-customeViewInnerGap-trangleHeight, bRect.origin.y
                                   , bRect.size.width + trangleHeight, bRect.size.height);
                cRect  = CGRectOffset(cRect, -customeViewInnerGap-trangleHeight, 0);
                break;
            }
            case AlertBubbleViewDirectionRight:{
                bRect = CGRectMake(bRect.origin.x + customeViewInnerGap, bRect.origin.y
                                   , bRect.size.width + trangleHeight, bRect.size.height);
                cRect  = CGRectOffset(cRect, customeViewInnerGap+trangleHeight, 0);
                break;
            }
            case AlertBubbleViewDirectionTop:{
                bRect = CGRectMake(bRect.origin.x, bRect.origin.y-customeViewInnerGap-trangleHeight
                                   , bRect.size.width, bRect.size.height+trangleHeight);
                cRect  = CGRectOffset(cRect, 0, -customeViewInnerGap-trangleHeight);
                break;
            }
            case AlertBubbleViewDirectionBottom:{
                bRect = CGRectMake(bRect.origin.x, bRect.origin.y + customeViewInnerGap
                                   , bRect.size.width, bRect.size.height+trangleHeight);
                cRect  = CGRectOffset(cRect, 0, customeViewInnerGap+trangleHeight);
                break;
            }
                
            default:{
                break;
            }
        }
        CGRect checkRect = CGRectInset(bRect, -borderInnerGap, -borderInnerGap);
        if (CGRectContainsRect(abView.bounds, checkRect)) {
            if (abView.showLogInfo) {
                //NSLog(@"AlertBubbleView %@, 显示范围未越界.", ABDArray[direction]);
            }
            return YES;
        }else{
            if (abView.showLogInfo) {
                NSLog(@"AlertBubbleView %@, 显示范围越界了, 可能是borderInnerGap过大或者其他问题.", ABDArray[direction]);
            }
            return NO;
        }
    };
    
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

@end
