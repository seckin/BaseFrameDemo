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
    
    self.bannerMenuButton.backgroundColor = self.view.tintColor;
    self.bannerMenuButton.layer.cornerRadius = CGRectGetWidth(self.bannerMenuButton.bounds)/2;
   [self.bannerMenuButton setTitleColor:[UIColor whiteColor]
               forState:UIControlStateNormal];
    self.bannerMenuButton.titleLabel.font = [UIFont fontWithName:@"Avenir-Medium"
                                           size:22];
    
    
    UIPopoverBackgroundView
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

@end
