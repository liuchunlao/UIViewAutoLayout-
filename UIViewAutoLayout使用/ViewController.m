//
//  ViewController.m
//  UIViewAutoLayout使用
//
//  Created by liuchunlao on 15/7/28.
//  Copyright (c) 2015年 liuchunlao. All rights reserved.
//

#import "ViewController.h"

#import <UIView-Autolayout/UIView+AutoLayout.h>

#define ARC4RANDOM_MAX 0x100000000

@interface ViewController ()

@property (nonatomic, strong) UIView *redView;

@property (nonatomic, strong) UIView *head;

@property (nonatomic, strong) UIView *body;

@property (nonatomic, strong) UIView *leftEye;

@property (nonatomic, strong) UIView *rightEye;

@property (nonatomic, strong) UIView *rightPupil;

@property (nonatomic, strong) UIView *hair;

@property (nonatomic, strong) UIView *leftArm;

@end

@implementation ViewController

- (NSString *)title {
    return @"AutoLayout";
}


- (void)loadView {
    
    [super loadView];
    
    
    // 1.红色背景
    self.redView = [UIView autoLayoutView];
    self.redView.backgroundColor = [UIColor redColor];
    [self.view addSubview:self.redView];
    
    // 在四个方向距离父控件10
//    [self.redView pinToSuperviewEdges:JRTViewPinAllEdges inset:10.0];
    
    // 会将控制器的状态栏排除在外，不指定控制器的话就直接距离屏幕顶部为10
    [self.redView pinToSuperviewEdges:JRTViewPinAllEdges inset:10 usingLayoutGuidesFrom:self];
    
    // 2.绿色的head
    self.head = [UIView autoLayoutView];
    self.head.backgroundColor = [UIColor greenColor];
    [self.redView addSubview:self.head];
    
    
    // 设定大小为100， 100
    [self.head constrainToSize:CGSizeMake(100, 100)];
    // 设置在某个方向为父控件的中间
    [self.head centerInContainerOnAxis:NSLayoutAttributeCenterX];
    // 设置与父控件的间距
    [self.head pinToSuperviewEdges:JRTViewPinTopEdge inset:10.0];
    
    
    // 3.设置body
    self.body = [UIView autoLayoutView];
    self.body.backgroundColor =[UIColor blueColor];
    [self.redView addSubview:self.body];
    
    // 设置宽度
    [self.body constrainToWidth:200];
    // 设置x方向居中
    [self.body centerInContainerOnAxis:NSLayoutAttributeCenterX];
    // 设置body的顶部距离head的底部为10
    [self.body pinAttribute:NSLayoutAttributeTop toAttribute:NSLayoutAttributeBottom ofItem:self.head withConstant:10];
    // 设置距离父控件底部为10
    [self.body pinToSuperviewEdges:JRTViewPinBottomEdge inset:10];
    
    
    // 4.在垂直方向以固定合适间距布局子控件
    [self evenlySpaceViewsOnBodyWithFixedSpacing];
    
    // 5.左眼
    self.leftEye = [UIView autoLayoutView];
    self.leftEye.backgroundColor = [UIColor orangeColor];
    [self.head addSubview:self.leftEye];
    
    // 设置大小
    [self.leftEye constrainToSize:CGSizeMake(25, 25)];
    // 设置距离父控件的左边 及 顶部 即 设置x，y
    [self.leftEye pinPointAtX:NSLayoutAttributeLeft Y:NSLayoutAttributeTop toPoint:CGPointMake(15, 15)];
    
    
    // 6.设置右眼
    self.rightEye = [UIView autoLayoutView];
    self.rightEye.backgroundColor = [UIColor magentaColor];
    [self.head addSubview:self.rightEye];
    
    // 右眼的左边距离左眼的右边为20
    [self.rightEye pinAttribute:NSLayoutAttributeLeft toAttribute:NSLayoutAttributeRight ofItem:self.leftEye withConstant:20];
    // 设置有眼的宽度
    [self.rightEye constrainToWidth:25];
    // 右眼与左眼的底部对齐
    [self.rightEye pinAttribute:NSLayoutAttributeBottom toSameAttributeOfItem:self.leftEye];
    // 有眼与左眼顶部对齐
//    [self.rightEye pinAttribute:NSLayoutAttributeTop toSameAttributeOfItem:self.leftEye];
    
    // 右眼与左眼距离父控件的顶部距离相等
    [self.rightEye pinEdges:JRTViewPinTopEdge toSameEdgesOfView:self.leftEye];
    
    
    // 7.右侧黑眼珠
    self.rightPupil = [UIView autoLayoutView];
    self.rightPupil.backgroundColor = [UIColor blackColor];
    [self.head addSubview:self.rightPupil];
    
    // 设置尺寸
    [self.rightPupil constrainToSize:CGSizeMake(15, 15)];
    // 设置在有眼的中心
    [self.rightPupil centerInView:self.rightEye];
    
    
    // 8.设置hair
    self.hair = [UIView autoLayoutView];
    self.hair.backgroundColor = [UIColor yellowColor];
    [self.redView addSubview:self.hair];
    
//    [self.hair pinAttribute:NSLayoutAttributeWidth toSameAttributeOfItem:self.head];
//    [self.hair pinAttribute:NSLayoutAttributeLeft toSameAttributeOfItem:self.head];
    
    // hair与head 的左右距离父控件间距相等
    [self.hair pinEdges:JRTViewPinLeftEdge | JRTViewPinRightEdge toSameEdgesOfView:self.head];
    // 设置尺寸
    [self.hair constrainToSize:CGSizeMake(0.0, 4.0)];
    // hair的底部距离head的顶部距离1.0
    [self.hair pinAttribute:NSLayoutAttributeBottom toAttribute:NSLayoutAttributeTop ofItem:self.head withConstant:-1.0];
    
    // 9.加载左边的胳膊
    self.leftArm = [UIView autoLayoutView];
    self.leftArm.backgroundColor = [UIColor grayColor];
    [self.redView addSubview:self.leftArm];
    
    
    // leftArm与body的间距为10
    [self.leftArm pinAttribute:NSLayoutAttributeRight toAttribute:NSLayoutAttributeLeft ofItem:self.body withConstant:-10.0];
    
    // leftArm的顶部与body的顶部差距为10
    [self.leftArm pinAttribute:NSLayoutAttributeTop toSameAttributeOfItem:self.body withConstant:10.0];
    // 设置尺寸
    [self.leftArm constrainToSize:CGSizeMake(20, 0.0)];
    [self.leftArm pinAttribute:NSLayoutAttributeBottom toAttribute:NSLayoutAttributeBottom ofItem:self.body withConstant:-10];
    
    
    // 10.在垂直方向布局子控件
    [self evenlySpaceViewsOnArmWithFixedSize];
}


- (void)evenlySpaceViewsOnBodyWithFixedSpacing {
    

    NSArray *views = @[[self randomGreyscaleView], [self randomGreyscaleView], [self randomGreyscaleView], [self randomGreyscaleView]];
    
    // 让body里面的子控件垂直间距为10 左对齐 自动调整高度。
    [self.body spaceViews:views onAxis:UILayoutConstraintAxisVertical withSpacing:10 alignmentOptions:0];

}


- (UIView *)randomGreyscaleView {
    
    double random = ((double)arc4random() / ARC4RANDOM_MAX);
    UIView *view = [UIView autoLayoutView];
    
    view.backgroundColor = [UIColor colorWithWhite:random alpha:1.0];
    
    [self.body addSubview:view];

    [view constrainToSize:CGSizeMake(150.0, 0.0)]; // 设定宽度
    [view centerInContainerOnAxis:NSLayoutAttributeCenterX]; // 设定在父控件x居中
    
    return view;
}

- (void)evenlySpaceViewsOnArmWithFixedSize {
    
    NSMutableArray *tiles = [NSMutableArray array];
    
    for (int i = 0; i < 5; i++) {
        UIView *panel = [UIView autoLayoutView];
        panel.backgroundColor = [UIColor blackColor];
        [self.leftArm addSubview:panel];
        
        // 设置尺寸
        [panel constrainToSize:CGSizeMake(10, 10 + (i * 2.0))];
        // 在父控件x方向居中
        [panel centerInContainerOnAxis:NSLayoutAttributeCenterX];
        
        [tiles addObject:panel];
    }
    
    // 在垂直方向分布子控件
    [self.leftArm spaceViews:tiles onAxis:UILayoutConstraintAxisVertical];
    
    

}


@end
