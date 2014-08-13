//
//  BannerMenuButton.m
//  BaseFrameDemo
//
//  Created by jiajingios on 13/8/14.
//  Copyright (c) 2014年 jiajingios. All rights reserved.
//

#import "BannerMenuButton.h"

@interface BannerMenuButton ()

@property(nonatomic) CALayer *leftLayer;
@property(nonatomic) CALayer *rightLayer;
@property(nonatomic) BOOL showMenu;

- (void)touchUpInsideHandler:(BannerMenuButton *)sender;
- (void)animationToMenu;
- (void)animationToClose;
- (void)setup;
- (void)removeAllAnimations;

@end

@implementation BannerMenuButton


+ (instancetype)button{

    return [self buttonWithOrigin:CGPointZero];
}
+ (instancetype)buttonWithOrigin:(CGPoint)origin{

    return [[self alloc] initWithFrame:CGRectMake(origin.x, origin.y, 24, 17)];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)animationToMenu{

    [self removeAllAnimations];
    
    CGFloat height = CGRectGetHeight(self.leftLayer.bounds);
    
    POPBasicAnimation *positionLeftAnimation = [POPBasicAnimation animationWithPropertyNamed:kPOPLayerPosition];
    positionLeftAnimation.duration = 0.3;
    positionLeftAnimation.toValue = [NSValue valueWithCGPoint:CGPointMake(CGRectGetMidX(self.bounds),
                                                                         roundf(CGRectGetMinY(self.bounds)+(height/2)))];
    
    POPBasicAnimation *positionRightAnimation = [POPBasicAnimation animationWithPropertyNamed:kPOPLayerPosition];
    positionRightAnimation.duration = 0.3;
    positionRightAnimation.toValue = [NSValue valueWithCGPoint:CGPointMake(CGRectGetMidX(self.bounds),
                                                                            roundf(CGRectGetMaxY(self.bounds)-(height/2)))];
    
    POPSpringAnimation *transformLeftAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerRotation];
    transformLeftAnimation.toValue = @(0);
    transformLeftAnimation.springBounciness = 20.f;
    transformLeftAnimation.springSpeed = 20;
    transformLeftAnimation.dynamicsTension = 1000;
    
    POPSpringAnimation *transformRightAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerRotation];
    transformRightAnimation.toValue = @(0);
    transformRightAnimation.springBounciness = 20.0f;
    transformRightAnimation.springSpeed = 20;
    transformRightAnimation.dynamicsTension = 1000;
    
    [self.leftLayer pop_addAnimation:positionLeftAnimation forKey:@"positionLeftAnimation"];
    [self.leftLayer pop_addAnimation:transformLeftAnimation forKey:@"transformLeftAnimation"];
    [self.rightLayer pop_addAnimation:positionRightAnimation forKey:@"positionRightAnimation"];
    [self.rightLayer pop_addAnimation:transformRightAnimation forKey:@"transformRightAnimation"];
}

- (void)animationToClose{

    [self removeAllAnimations];
    
    CGPoint center = CGPointMake(CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds));
    
    POPBasicAnimation *positionLeftAnimation = [POPBasicAnimation animationWithPropertyNamed:kPOPLayerPosition];
    positionLeftAnimation.toValue = [NSValue valueWithCGPoint:center];
    positionLeftAnimation.duration = 0.3;
    
    POPBasicAnimation *positionRightAnimation = [POPBasicAnimation animationWithPropertyNamed:kPOPLayerPosition];
    positionRightAnimation.toValue = [NSValue valueWithCGPoint:center];
    positionRightAnimation.duration = 0.3;
    
    POPSpringAnimation *transformLeftAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerRotation];
    transformLeftAnimation.toValue = @(M_PI_4);
    transformLeftAnimation.springBounciness = 20.f;
    transformLeftAnimation.springSpeed = 20;
    transformLeftAnimation.dynamicsTension = 1000;
    
    POPSpringAnimation *transformRightAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerRotation];
    transformRightAnimation.toValue = @(-M_PI_4);
    transformRightAnimation.springBounciness = 20.0f;
    transformRightAnimation.springSpeed = 20;
    transformRightAnimation.dynamicsTension = 1000;
    
    [self.leftLayer pop_addAnimation:positionLeftAnimation forKey:@"positionLeftAnimation"];
    [self.leftLayer pop_addAnimation:transformLeftAnimation forKey:@"transformLeftAnimation"];
    [self.rightLayer pop_addAnimation:positionRightAnimation forKey:@"positionRightAnimation"];
    [self.rightLayer pop_addAnimation:transformRightAnimation forKey:@"transformRightAnimation"];

}

- (void)touchUpInsideHandler:(BannerMenuButton *)sender{

    if (self.showMenu) {
        [self animationToMenu];
    }else{
        [self animationToClose];
    }
    self.showMenu = !self.showMenu;
}

- (void)setup{
    
//    self.layer.cornerRadius = CGRectGetWidth(self.bounds)/2;
//    self.alpha = 0.6f;
//    self.layer.backgroundColor = [[UIColor blackColor] CGColor];

    CGFloat height = 2.f;
    CGFloat width = CGRectGetWidth(self.bounds);
    CGFloat cornerRadius = 1.f;
    CGColorRef color = [[UIColor blackColor] CGColor];
    
    self.leftLayer = [CALayer layer];
    self.leftLayer.frame = CGRectMake(0, CGRectGetMinY(self.bounds)-(height/2), width, height);
    self.leftLayer.cornerRadius = cornerRadius;
    self.leftLayer.backgroundColor = color;
    
    self.rightLayer = [CALayer layer];
    self.rightLayer.frame = CGRectMake(CGRectGetMinX(self.bounds)-(width/2), 0, width, height);
    self.rightLayer.cornerRadius = cornerRadius;
    self.rightLayer.backgroundColor = color;
    
    [self.layer addSublayer:self.leftLayer];
    [self.layer addSublayer:self.rightLayer];
    
    [self addTarget:self action:@selector(touchUpInsideHandler:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)removeAllAnimations{

    [self.leftLayer pop_removeAllAnimations];
    [self.rightLayer pop_removeAllAnimations];
}

@end
