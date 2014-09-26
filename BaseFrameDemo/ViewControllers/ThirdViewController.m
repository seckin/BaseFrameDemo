//
//  ThirdViewController.m
//  BaseFrameDemo
//
//  Created by apple on 14-8-13.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import "ThirdViewController.h"

@interface ThirdViewController ()

@end

@implementation ThirdViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidAppear:(BOOL)animated{

    [super viewDidAppear:animated];
    [self springAnimaion];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor lightGrayColor];
    
    CGFloat width = CGRectGetMinX(self.view.bounds);
    CGFloat height = CGRectGetMaxY(self.view.bounds);
    
    self.bannerMenuButton = [BannerMenuButton button];
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)springAnimaion{

    POPSpringAnimation *springAnimation = [POPSpringAnimation animation];
    springAnimation.property = [POPAnimatableProperty propertyWithName:kPOPViewCenter];
    springAnimation.toValue = [NSValue valueWithCGPoint:CGPointMake(self.view.bounds.size.width/2, self.view.bounds.size.height/2)];
    springAnimation.velocity = [NSValue valueWithCGPoint:CGPointMake(100, 10)];
    springAnimation.springBounciness = 20;
    springAnimation.springSpeed = 20;
    [_cellImgaeView pop_addAnimation:springAnimation forKey:@"center"];
}

#pragma mark - POPAnimationDelegate

- (void)pop_animationDidApply:(POPDecayAnimation *)anim
{
    BOOL isDragViewOutsideOfSuperView = !CGRectContainsRect(self.view.frame, self.dragView.frame);
    if (isDragViewOutsideOfSuperView) {
        CGPoint currentVelocity = [anim.velocity CGPointValue];
        CGPoint velocity = CGPointMake(currentVelocity.x, -currentVelocity.y);
        POPSpringAnimation *positionAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerPosition];
        positionAnimation.velocity = [NSValue valueWithCGPoint:velocity];
        positionAnimation.toValue = [NSValue valueWithCGPoint:self.view.center];
        [self.dragView.layer pop_addAnimation:positionAnimation forKey:@"layerPositionAnimation"];
    }
}

@end
