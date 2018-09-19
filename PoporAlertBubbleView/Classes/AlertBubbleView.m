//
//  AlertBubbleView.m
//  linRunShengPi
//
//  Created by apple on 2018/9/14.
//  Copyright © 2018年 艾慧勇. All rights reserved.
//

#import "AlertBubbleView.h"

#import "UIView+Tool.h"
#import "AlertBubbleFrame.h"
#import <PoporFoundation/NSAssistant.h>
#import <PoporFoundation/PrefixColor.h>

@interface AlertBubbleView ()

@end

@implementation AlertBubbleView

- (id)initWithDic:(NSDictionary *)dic {
    if (self = [super init]) {
        [NSAssistant setEntity:self dic:dic];
    }
    return self;
}

- (void)showCustomView:(UIView *)customeView around:(CGRect)aroundRect close:(BlockPVoid)close {
    {
        [self addSubview:self.bubbleView];
        self.customeView = customeView;
        [self addSubview:customeView];
        self.closeBlock = close;
        self.aroundRect = aroundRect;
        
        self.frame = self.baseView.bounds;
        if (self.bgColor) {
            self.backgroundColor = self.bgColor;
        }
        
        [self.baseView addSubview:self];
        self.closeTapGR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(closeAction:)];
        [self addGestureRecognizer:self.closeTapGR];
    }
    
    [self showTargetView];
    [self updateTextCVLayer];
}

- (void)updateTextCVLayer {
    [AlertBubbleFrame moveCustomView:self.customeView
                          bubbleView:self.bubbleView
                            baseView:self.baseView
                          arroudRect:self.aroundRect
                     AlertBubbleView:self];
    
    UIBezierPath * path = [AlertBubbleBezierPath pathAtClipView:self.bubbleView
                                                      direction:self.direction
                                                          scale:1.0
                                                      triangleX:-(self.trangleX-self.lableInnerGap)
                                                      triangleY:-(self.trangleY-self.lableInnerGap)
                                                      triangleW:self.trangleWidth
                                                      triangleH:self.trangleHeight
                                                   cornerRadius:self.corner];
    // 绘制边界
    if (self.borderLayer) {
        [self.borderLayer removeFromSuperlayer];
        self.borderLayer.path = path.CGPath;
    } else {
        self.borderLayer = [CAShapeLayer layer];
        self.borderLayer.path = path.CGPath;
        
        self.borderLayer.strokeColor = self.borderLineColor.CGColor;
        self.borderLayer.fillColor   = [UIColor clearColor].CGColor;
        self.borderLayer.lineWidth   = self.borderLineWidth;
        
        [self.bubbleView.layer addSublayer:self.borderLayer];
    }
}

- (void)closeAction:(UITapGestureRecognizer *)tapGR {
    CGPoint point = [tapGR locationInView:self.baseView];
    if (CGRectContainsPoint(self.bubbleView.frame, point)) {
        //NSLog(@"AlertBubbleView 忽略");
        return;
    }
    if (self.closeBlock) {
        self.closeBlock();
    }
    [UIView removeDestroyView:self];
}

- (void)showTargetView {
    if (self.showAroundRect) {
        UIView * view = [UIView new];
        view.frame = self.aroundRect;
        view.backgroundColor = RGBA(0, 0, 0, 0.4);
        [self addSubview:view];
    }
}

#pragma mark get
- (UIView *)bubbleView{
    if (!_bubbleView) {
        UIView * view = [UIView new];
        if (_bubbleBgColor) {
            view.backgroundColor = _bubbleBgColor;
        }else{
            view.backgroundColor = [UIColor whiteColor];
        }
        
        [self addSubview:view];
        _bubbleView = view;
    }
    return _bubbleView;
}

@end
