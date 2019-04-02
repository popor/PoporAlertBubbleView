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
#import <PoporUI/UIDeviceScreen.h>

@interface PoporAlertBubbleViewViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) AlertBubbleView * alertBubbleView;
@property (nonatomic, strong) UITableView     * alertBubbleTV;
@property (nonatomic, strong) UIColor         * alertBubbleTVColor;

@end

@implementation PoporAlertBubbleViewViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"警告框";
    self.alertBubbleTVColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    
    NSArray * btTitleArray = @[@"左上", @"中间", @"右下"];
    for (int i = 0; i<btTitleArray.count; i++) {
        UIButton * oneBT = ({
            UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
            button.frame =  CGRectMake(100, 100, 80, 44);
            [button setTitle:btTitleArray[i] forState:UIControlStateNormal];
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
        switch (i) {
            case 0: {
                CGRect StatusRect = [[UIApplication sharedApplication] statusBarFrame];//标题栏
                CGRect NavRect    = self.navigationController.navigationBar.frame;//然后将高度相加，便可以动态计算顶部高度。
                CGFloat height    = StatusRect.size.height + NavRect.size.height;
                
                oneBT.frame = CGRectMake(20, height + 20, 80, 44);
                break;
            }
            case 1: {
                oneBT.frame = CGRectMake(100, 100, 80, 44);
                oneBT.center = CGPointMake(self.view.frame.size.width/2, self.view.frame.size.height/2);
                break;
            }
            case 2: {
                oneBT.frame = CGRectMake(self.view.frame.size.width - 100, self.view.frame.size.height - 64 -[UIDeviceScreen safeBottomMargin], 80, 44);
                break;
            }
            default:
                break;
        }
    }
    
    {
        UIBarButtonItem *item1 = [[UIBarButtonItem alloc] initWithTitle:@"显示" style:UIBarButtonItemStylePlain target:self action:@selector(showTVAlertAction:event:)];
        self.navigationItem.rightBarButtonItems = @[item1];
    }
    {
        UIBarButtonItem *item1 = [[UIBarButtonItem alloc] initWithTitle:@"自定义位置" style:UIBarButtonItemStylePlain target:self action:@selector(showTVAlertActionCustom:event:)];
        self.navigationItem.leftBarButtonItems = @[item1];
    }
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
                           @"baseView":self.navigationController.view,
                           
                           @"borderLineColor":ColorBlue1,
                           @"borderLineWidth":@(1),
                           @"corner":@(5),
                           
                           @"trangleHeight":@(5),
                           @"trangleWidth":@(5),
                           
                           @"borderInnerGap":@(10),
                           @"customeViewInnerGap":@(5),
                           
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

- (void)showTVAlertAction {
    
}

- (void)showTVAlertActionCustom:(UIBarButtonItem *)sender event:(UIEvent *)event {
    //CGRect fromRect = [[event.allTouches anyObject] view].frame;
    UITouch * touch = [event.allTouches anyObject];
    //UIWindow * window = [[UIApplication sharedApplication] keyWindow];
    
    //CGPoint point = [touch locationInView:window];
    //fromRect.origin = point;
    
    CGRect fromRect = [touch.view.superview convertRect:touch.view.frame toView:self.navigationController.view];
    fromRect.origin.y -= 8;
    
    NSDictionary * dic = @{
                           @"direction":@(AlertBubbleViewDirectionTop),
                           @"baseView":self.navigationController.view,
                           @"borderLineColor":self.alertBubbleTVColor,
                           @"borderLineWidth":@(1),
                           @"corner":@(5),
                           @"trangleHeight":@(8),
                           @"trangleWidth":@(8),
                           
                           @"borderInnerGap":@(10),
                           @"customeViewInnerGap":@(0),
                           
                           @"bubbleBgColor":self.alertBubbleTVColor,
                           @"bgColor":[UIColor clearColor],
                           @"showAroundRect":@(NO),
                           @"showLogInfo":@(NO),
                           };
    
    AlertBubbleView * abView = [[AlertBubbleView alloc] initWithDic:dic];
    
    UITableView * tv = [self alertBubbleTV];
    tv.center = self.navigationController.view.center;
    
    [abView showCustomView:tv close:nil];
    
    self.alertBubbleView = abView;
}

- (void)showTVAlertAction:(UIBarButtonItem *)sender event:(UIEvent *)event {
    //CGRect fromRect = [[event.allTouches anyObject] view].frame;
    UITouch * touch = [event.allTouches anyObject];
    //UIWindow * window = [[UIApplication sharedApplication] keyWindow];
    
    //CGPoint point = [touch locationInView:window];
    //fromRect.origin = point;
    
    CGRect fromRect = [touch.view.superview convertRect:touch.view.frame toView:self.navigationController.view];
    fromRect.origin.y -= 8;
    
    NSDictionary * dic = @{
                           @"direction":@(AlertBubbleViewDirectionTop),
                           @"baseView":self.navigationController.view,
                           @"borderLineColor":self.alertBubbleTVColor,
                           @"borderLineWidth":@(1),
                           @"corner":@(5),
                           @"trangleHeight":@(8),
                           @"trangleWidth":@(8),
                           
                           @"borderInnerGap":@(10),
                           @"customeViewInnerGap":@(0),
                           
                           @"bubbleBgColor":self.alertBubbleTVColor,
                           @"bgColor":[UIColor clearColor],
                           @"showAroundRect":@(NO),
                           @"showLogInfo":@(NO),
                           };
    
    AlertBubbleView * abView = [[AlertBubbleView alloc] initWithDic:dic];
    
    [abView showCustomView:self.alertBubbleTV around:fromRect close:nil];
    
    self.alertBubbleView = abView;
}

#pragma mark - UITableView
- (UITableView *)alertBubbleTV {
    UITableView * oneTV = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 120, 88) style:UITableViewStylePlain];
    
    oneTV.delegate   = self;
    oneTV.dataSource = self;
    
    oneTV.allowsMultipleSelectionDuringEditing = YES;
    oneTV.directionalLockEnabled = YES;
    
    oneTV.estimatedRowHeight           = 0;
    oneTV.estimatedSectionHeaderHeight = 0;
    oneTV.estimatedSectionFooterHeight = 0;
    
    oneTV.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
    
    oneTV.backgroundColor = [UIColor clearColor];
    
    oneTV.layer.cornerRadius = 4;
    oneTV.clipsToBounds      = YES;
    oneTV.scrollEnabled      = NO;
    
    return oneTV;
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString * CellID = @"CellID";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:CellID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellID];
        cell.selectionStyle = UITableViewCellSelectionStyleDefault;
        
        //cell.backgroundColor = self.alertBubbleTVColor;
        cell.backgroundColor = [UIColor clearColor];
        cell.textLabel.font = [UIFont systemFontOfSize:15];
        cell.textLabel.textColor = [UIColor whiteColor];
    }
    
    cell.textLabel.text = [NSString stringWithFormat:@"%li", indexPath.row];
    
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self.alertBubbleView closeEvent];
}

@end
