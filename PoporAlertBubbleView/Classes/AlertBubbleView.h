//
//  AlertBubbleView.h
//  linRunShengPi
//
//  Created by apple on 2018/9/14.
//  Copyright © 2018年 艾慧勇. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "AlertBubbleBezierPath.h"
#import "AlertBubbleLable.h"
#import <PoporFoundation/PrefixBlock.h>

@interface AlertBubbleView : UIView

// --- dic可设置参数
@property (nonatomic        ) AlertBubbleViewDirection direction;

@property (nonatomic, strong) UIColor  * borderLineColor;
@property (nonatomic        ) float    borderLineWidth;
@property (nonatomic        ) float    corner;

@property (nonatomic        ) float    trangleWidth;
@property (nonatomic        ) float    trangleHeight;// 三角的高度
@property (nonatomic        ) float    borderInnerGap;// 边界 insertEdge  gap
@property (nonatomic        ) float    lableInnerGap;// lable insertEdge  gap

@property (nonatomic, weak  ) UIView   * baseView;

@property (nonatomic, strong) UIColor  * bubbleBgColor;
@property (nonatomic, strong) UIColor  * bgColor;

// --- 内部不可设置参数
@property (nonatomic        ) float                    trangleX;
@property (nonatomic        ) float                    trangleY;
@property (nonatomic, copy  ) BlockPVoid               closeBlock;

@property (nonatomic, strong) UIView                   * customeView;
@property (nonatomic, strong) UIView                   * bubbleView;
@property (nonatomic, strong) CAShapeLayer             * borderLayer;
@property (nonatomic, strong) UITapGestureRecognizer   * closeTapGR;

@property (nonatomic        ) CGRect                   aroundRect;
@property (nonatomic        ) BOOL                     showAroundRect;
@property (nonatomic        ) BOOL                     showLogInfo;

// 初始化
- (id)initWithDic:(NSDictionary *)dic;

/*
 rect:变大rect的size,可以扩大尖角和指示页面之间的距离,例如 rect = CGRectInset(rect, -3, -3);
 */
- (void)showCustomView:(UIView *)customeView around:(CGRect)aroundRect close:(BlockPVoid)close;

@end
