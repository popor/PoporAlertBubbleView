//
//  PoporAlertBubbleViewViewController.m
//  PoporAlertBubbleView
//
//  Created by popor on 09/18/2018.
//  Copyright (c) 2018 popor. All rights reserved.
//

#import "PoporAlertBubbleViewViewController.h"

#import "AlertBubbleView.h"
#import <PoporFoundation/PrefixColor.h>

@interface PoporAlertBubbleViewViewController ()

@property (nonatomic, strong) UIButton * bt;

@end

@implementation PoporAlertBubbleViewViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    self.bt = ({
        UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame =  CGRectMake(100, 200, 80, 44);
        [button setTitle:@"Tip" forState:UIControlStateNormal];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [button setBackgroundColor:[UIColor brownColor]];
        
        button.layer.cornerRadius = 5;
        button.layer.borderColor = [UIColor lightGrayColor].CGColor;
        button.layer.borderWidth = 1;
        button.clipsToBounds = YES;
        
        [self.view addSubview:button];
        
        [button addTarget:self action:@selector(btAction:) forControlEvents:UIControlEventTouchUpInside];
        
        button;
    });
}

- (void)btAction:(UIButton *)bt {
    //UIColor * ColorBlue1 = RGB16(0X4585F5);
    bt.tag ++;
    AlertBubbleViewDirection direction;
    switch (bt.tag%4) {
        case 0:
            direction = AlertBubbleViewDirectionTop;
            break;
        case 1:
            direction = AlertBubbleViewDirectionBottom;
            break;
        case 2:
            direction = AlertBubbleViewDirectionLeft;
            break;
        case 3:
            direction = AlertBubbleViewDirectionRight;
            break;
        default:
            direction = AlertBubbleViewDirectionTop;
            break;
    }
    //direction = AlertBubbleViewDirectionRight;
    NSString * text = @"0111111110,0222222220,0333333330,0444444440,0555555550,0666666660,0777777770,0888888880,0999999990";
    NSDictionary * dic = @{
                           @"direction":@(direction),
                           @"baseView":self.view,
                           
                           @"borderLineColor":ColorBlue1,
                           @"borderLineWidth":@(1),
                           @"corner":@(5),
                           
                           @"trangleHeight":@(5),
                           @"trangleWidth":@(5),
                           
                           @"borderInnerGap":@(20),
                           @"lableInnerGap":@(5),
                           @"bubbleBgColor":RGB16A(0XF5F8FF, 1),
                           @"bgColor":[UIColor clearColor],
                           
                           // test
                           @"showAroundRect":@(NO),
                           @"showLogInfo":@(YES),
                           };
    
    AlertBubbleView * abView = [[AlertBubbleView alloc] initWithDic:dic];
    
    CGRect rect = [bt.superview convertRect:bt.frame toView:self.view];
    rect = CGRectInset(rect, -5, -5);
    
    UILabel * l = [AlertBubbleLable text:text color:ColorBlue1 font:[UIFont systemFontOfSize:15] width:200];
    [abView showCustomView:l around:rect close:nil];
    
    
}

@end
