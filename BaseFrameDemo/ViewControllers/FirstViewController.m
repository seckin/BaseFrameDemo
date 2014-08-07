//
//  FirstViewController.m
//  BaseFrameDemo
//
//  Created by apple on 14-5-28.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import "FirstViewController.h"

@interface FirstViewController ()



@end

@implementation FirstViewController


@synthesize arrowImgV1;
@synthesize arrowImgV2;

@synthesize rocker;


#pragma mark - View Llfe Cycle

//- (void)loadView{
//
//    //NSLog(@"loadView");
//}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        //NSLog(@"initWithNibName");

    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    //NSLog(@"viewDidLoad");
//    self.view.layer.backgroundColor =[UIColor orangeColor].CGColor;
//    self.view.layer.cornerRadius =20.0;
//    self.view.layer.frame = CGRectInset(self.view.layer.frame, 20, 20);
//    
//    CALayer *sublayer =[CALayer layer];
//    sublayer.backgroundColor =[UIColor blueColor].CGColor;
//    sublayer.shadowOffset = CGSizeMake(0, 3);
//    sublayer.shadowRadius =5.0;
//    sublayer.shadowColor =[UIColor blackColor].CGColor;
//    sublayer.shadowOpacity =0.8;
//    sublayer.frame = CGRectMake(30, 30, 128, 192);
//    sublayer.borderColor =[UIColor blackColor].CGColor;
//    sublayer.borderWidth =2.0;
//    sublayer.cornerRadius =10.0;
//    [self.view.layer addSublayer:sublayer];
//    
//    CALayer *imageLayer =[CALayer layer];
//    imageLayer.frame = sublayer.bounds;
//    imageLayer.cornerRadius =10.0;
//    imageLayer.contents =(id)[UIImage imageNamed:@"Default-568h.png"].CGImage;
//    imageLayer.masksToBounds =YES;
//    [sublayer addSublayer:imageLayer];
    
    arrowImgV1 = [[UIImageView alloc] init];
    UIImage *arrowImg = [UIImage imageNamed:@"arrow_blue.png"];
    arrowImgV1.frame = CGRectMake(10, 100, arrowImg.size.width, arrowImg.size.height);
    arrowImgV1.image = arrowImg;
    [self.view addSubview:arrowImgV1];
    
    arrowImgV2 = [[UIImageView alloc] init];
    //UIImage *arrowImg = [UIImage imageNamed:@"arrow_blue.png"];
    arrowImgV2.frame = CGRectMake(10, 150, arrowImg.size.width, arrowImg.size.height);
    arrowImgV2.image = arrowImg;
    [self.view addSubview:arrowImgV2];
    
    rocker = [[UIImageView alloc] init];
    UIImage *rockerImg = [UIImage imageNamed:@"tfbgi.png"];
    rocker.frame = CGRectMake(10, 200, rockerImg.size.width, rockerImg.size.height);
    rocker.image = rockerImg;
    [self.view addSubview:rocker];

     NSArray *sublayers = self.view.layer.sublayers;
     NSLog(@" sublayers %@",sublayers);
    
    NSLog(@" presentationLayer %@",self.view.layer.presentationLayer);
    NSLog(@"modelLayer %@",self.view.layer.modelLayer);
    

    [super viewDidLoad];
    
    UIView *aView = [[UIView alloc] initWithFrame:CGRectMake(100, 50, 100, 100)];
    aView.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:aView];
    
    UIDynamicAnimator* animator = [[UIDynamicAnimator alloc] initWithReferenceView:self.view];
    UIGravityBehavior* gravityBeahvior = [[UIGravityBehavior alloc] initWithItems:@[aView]];
    [animator addBehavior:gravityBeahvior];
    self.animator = animator;
}

- (void)lanch1ToRight{

    CABasicAnimation *animation = [CABasicAnimation animation];
    animation.keyPath = @"position.x";
    animation.fromValue = @10;
    animation.toValue = @300;
    animation.duration = 1;
    animation.timingFunction = [CAMediaTimingFunction functionWithControlPoints:0.5:0:0.9:0.7];
    [arrowImgV1.layer addAnimation:animation forKey:@"basic"];
    
    arrowImgV1.layer.position = CGPointMake(300, 100);
}

- (void)lanch2ToRight{
    
    CABasicAnimation *animation = [CABasicAnimation animation];
    animation.keyPath = @"position.x";
    animation.fromValue = @10;
    animation.toValue = @300;
    animation.duration = 1;
    
    [arrowImgV1.layer addAnimation:animation forKey:@"basic"];
    arrowImgV1.layer.position = CGPointMake(300, 100);
    
    animation.beginTime = CACurrentMediaTime() + 0.5;
    
    [arrowImgV2.layer addAnimation:animation forKey:@"basic"];
    arrowImgV2.layer.position = CGPointMake(300, 150);
}

- (void)shake{
    
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animation];
    animation.keyPath = @"position.x";
    animation.values = @[ @0, @10, @-10, @10, @0 ];
    animation.keyTimes = @[ @0, @(1 / 6.0), @(3 / 6.0), @(5 / 6.0), @1 ];
    animation.duration = 0.4;
    
    animation.additive = YES;
    
    [rocker.layer addAnimation:animation forKey:@"shake"];
}

- (void)viewWillAppear:(BOOL)animated{

    [super viewWillAppear:animated];
    //NSLog(@"viewWillAppear");
}

- (void)viewDidAppear:(BOOL)animated{

    [super viewDidAppear:animated];
    //NSLog(@"viewDidAppear");
}

- (void)viewWillDisappear:(BOOL)animated{

    [super viewWillDisappear:animated];
    //NSLog(@"viewWillDisappear");
}

- (void)viewDidDisappear:(BOOL)animated{

    [super viewDidDisappear:animated];
    //NSLog(@"viewDidLoad");
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    //NSLog(@"didReceiveMemoryWarning");
    // Dispose of any resources that can be recreated.
}

#pragma mark - Touch Events

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    
    //NSLog(@"touchesBegan");
}
- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    
    //NSLog(@"touchesMoved");
}
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    
    UITouch *touch = [touches anyObject];
	NSUInteger tapCount = touch.tapCount;
	switch (tapCount) {
		case 1:
			[self handleSingleTap:touch];
			break;
		case 2:
			[self handleDoubleTap:touch];
			break;
		case 3:
			[self handleTripleTap:touch];
			break;
		default:
			break;
	}
	[[self nextResponder] touchesEnded:touches withEvent:event];
    
    //NSLog(@"touchesEnded");
}
- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event{
    
    //NSLog(@"touchesCancelled");
}

- (void)handleSingleTap:(UITouch *)touch {
	
    //NSLog(@"handleSingleTap");
    [self lanch1ToRight];
}

- (void)handleDoubleTap:(UITouch *)touch {
	
    //NSLog(@"handleDoubleTap");
    [self lanch2ToRight];
}

- (void)handleTripleTap:(UITouch *)touch {
	
    //NSLog(@"handleTripleTap");
    [self shake];
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
