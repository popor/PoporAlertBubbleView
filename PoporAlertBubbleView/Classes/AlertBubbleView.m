//
//  AlertBubbleView.m
//  AlertBubbleView
//
//  Created by apple on 2018/9/14.
//  Copyright © 2018年 popor. All rights reserved.
//

#import "AlertBubbleView.h"

#import "AlertBubbleFrame.h"
#import <objc/runtime.h>

@interface AlertBubbleView () <UIGestureRecognizerDelegate>

@end

@implementation AlertBubbleView

- (id)initWithDic:(NSDictionary *)dic {
    if (self = [super init]) {
        [self setEntity:self dic:dic];
        if (!self.borderLineColor) {
            self.borderLineColor = [UIColor clearColor];
        }
        if (!self.bubbleBgColor) {
            self.bubbleBgColor = [UIColor lightGrayColor];
        }
        if (!self.bgColor) {
            self.bgColor = [UIColor clearColor];
        }
    }
    return self;
}

- (void)showCustomView:(UIView *)customeView around:(CGRect)aroundRect close:(AlertBubbleViewBlockPVoid)close {
    {
        [self addSubview:self.bubbleView];
        self.customeView = customeView;
        [self addSubview:customeView];
        self.closeBlock = close;
        self.aroundRect = aroundRect;
        
        self.frame = self.baseView.bounds;
        if (self.bgColor) {
            self.backgroundColor = [UIColor clearColor];
            self.showBgColorAnimationTime = self.showBgColorAnimationTime >0 ? self.showBgColorAnimationTime:0.15;
            [UIView animateWithDuration:self.showBgColorAnimationTime animations:^{
                self.backgroundColor = self.bgColor;
            }];
        }
        
        [self.baseView addSubview:self];
        self.closeTapGR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(closeAction:)];
        self.closeTapGR.delegate = self;
        
        [self addGestureRecognizer:self.closeTapGR];
        
        // 矫正必要数据.
        self.miniGap = self.borderInnerGap + self.customeViewInnerGap;
    }
    
    [self showTargetView];
    [self updateCustomeTriangleLayer];
}

/*
 自定义customeView的中心点, 这个不显示三角符号.
 */
- (void)showCustomView:(UIView *)customeView close:(AlertBubbleViewBlockPVoid)close {
    {
        [self addSubview:self.bubbleView];
        self.customeView = customeView;
        [self addSubview:customeView];
        self.closeBlock = close;
        
        self.frame = self.baseView.bounds;
        if (self.bgColor) {
            self.backgroundColor = self.bgColor;
        }
        
        [self.baseView addSubview:self];
        self.closeTapGR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(closeAction:)];
        self.closeTapGR.delegate = self;
        
        [self addGestureRecognizer:self.closeTapGR];
        
        // 矫正必要数据.
        self.miniGap = self.borderInnerGap + self.customeViewInnerGap;
    }
    
    [self showTargetView];
    [self updateCustomeTankleLayer];
}

// 添加线条
- (void)updateCustomeTriangleLayer {
    [AlertBubbleFrame moveCustomView:self.customeView
                          bubbleView:self.bubbleView
                            baseView:self.baseView
                          arroudRect:self.aroundRect
                     AlertBubbleView:self];
    UIBezierPath * path;
    path = [AlertBubbleBezierPath pathAtClipView:self.bubbleView
                                       direction:self.direction
                                           scale:1.0
                                       triangleX:-(self.trangleX-self.customeViewInnerGap)
                                       triangleY:-(self.trangleY-self.customeViewInnerGap)
                                       triangleW:self.trangleWidth
                                       triangleH:self.trangleHeight
                                    cornerRadius:self.corner];
    [self updateBorderLayer:path];
}

- (void)updateCustomeTankleLayer {
    self.direction = AlertBubbleViewDirectionTop;
    self.bubbleView.frame = self.customeView.frame;
    
    UIBezierPath * path;
    path = [AlertBubbleBezierPath pathAtClipView:self.bubbleView
                                       direction:self.direction
                                           scale:1.0
                                       triangleX:0
                                       triangleY:0
                                       triangleW:0
                                       triangleH:0
                                    cornerRadius:self.corner];
    
    [self updateBorderLayer:path];
}

// 绘制边界
- (void)updateBorderLayer:(UIBezierPath *)path {
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

- (BOOL)gestureRecognizer:(UIGestureRecognizer*)gestureRecognizer shouldReceiveTouch:(UITouch*)touch {
    CGPoint point = [touch locationInView:self];
    if (CGRectContainsPoint(self.customeView.frame, point)) {
        return NO;
    }
    return YES;
}

- (void)closeAction:(UITapGestureRecognizer *)tapGR {
    [self closeEvent];
}

- (void)closeEvent {
    [self removeFromSuperview];
    
    if (self.closeBlock) {
        self.closeBlock();
    }
}

// 测试使用模块
- (void)showTargetView {
    if (self.showAroundRect) {
        UIView * view = [UIView new];
        view.frame = self.aroundRect;
        
        view.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.4];
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


#pragma mark dic 映射数据
- (void)setEntity:(id _Nullable)entity dic:(id _Nullable)dic {
    if (!dic || !entity) {
        return;
    }
    
    unsigned propertyCount;
    
    objc_property_t *properties = class_copyPropertyList([entity class],&propertyCount);
    for(int i=0;i<propertyCount;i++){
        NSString * keySName;                              // key string  名字
        NSString * keySAtt;                               // key string  属性
        objc_property_t keyChar = properties[i];          // key Char 属性
        const char *keyCName = property_getName(keyChar); // key Char 名字
        keySName = [NSString stringWithCString:keyCName encoding:NSASCIIStringEncoding];
        
        @try {
            [dic objectForKey:keySName];
        }@catch (NSException * e) {
            NSLog(@"设置VC属性时候,dic取值错误:%@\n\n\n", keySName);
            continue;
        }
        
        const char * keyCAtt = property_getAttributes(keyChar); // key Char 属性
        keySAtt   = [NSString stringWithCString:keyCAtt encoding:NSASCIIStringEncoding];
        id value = [dic objectForKey:keySName];
        //NSLog(@"%s key:%@, value:%@", __func__, keySName, keySAtt);
        
        if (!value) continue;
        
        // 屏蔽系统参数
        // nsobject 的 hash
        if ([keySAtt hasPrefix:@"TQ,R"]) continue;
        // nsobject 的 superclass
        if ([keySAtt hasPrefix:@"T#,R"]) continue;
        // nsobject 的 describe, debugDescription
        if ([keySAtt hasPrefix:@"T@\"NSString\",R,C"]) continue;
        
        if ([keySAtt hasPrefix:@"Tc"]
            || [keySAtt hasPrefix:@"Ti"]
            || [keySAtt hasPrefix:@"TB"]) {
            [entity setValue:[NSNumber numberWithInt:[value intValue]] forKey:keySName];
            continue;
        }
        if ([keySAtt hasPrefix:@"Tf"]) {
            [entity setValue:[NSNumber numberWithFloat:[value floatValue]] forKey:keySName];
            continue;
        }
        // defalut
        [entity setValue:value forKey:keySName];
    }
    free(properties);
    
    //NSLog(@"\n\n");
}

@end
