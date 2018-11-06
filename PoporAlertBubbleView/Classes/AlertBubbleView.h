//
//  AlertBubbleView.h
//  AlertBubbleView
//
//  Created by apple on 2018/9/14.
//  Copyright © 2018年 popor. All rights reserved.
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

// AlertBubbleView距离baseView边界的 insertEdge gap, 防止AlertBubbleView紧紧贴边显示.
@property (nonatomic        ) float    borderInnerGap;

// customeView距离AlertBubbleView边界的insertEdge gap, 防止customeView紧紧贴AlertBubbleView显示
@property (nonatomic        ) float    customeViewInnerGap;
@property (nonatomic        ) float    lableInnerGap NS_DEPRECATED_IOS(1_0, 1_0, "Use -customeViewInnerGap");

@property (nonatomic, weak  ) UIView   * baseView;

@property (nonatomic, strong) UIColor  * bubbleBgColor;
@property (nonatomic, strong) UIColor  * bgColor;

// --- 内部不可设置参数
@property (nonatomic        ) float                    miniGap;// borderInnerGap + customeViewInnerGap
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

- (void)closeEvent;

@end
