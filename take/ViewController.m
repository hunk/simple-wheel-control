//
//  ViewController.m
//  take
//
//  Created by hunk on 12/11/13.
//  Copyright (c) 2013 mx.blend. All rights reserved.
//

#import "ViewController.h"
#import <QuartzCore/QuartzCore.h>

#define PI 3.14159265


@interface ViewController (){
	
	CGPoint centerCircle;
	
	CGAffineTransform startTransform;
	
}

@end

@implementation ViewController

static NSInteger const kBallSize = 40;
static float deltaAngle;


- (float) calculateDistanceFromCenter:(CGPoint)point {
    
	float dx = point.x - centerCircle.x;
	float dy = point.y - centerCircle.y;
	return sqrt(dx*dx + dy*dy);
    
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
	UITouch *touch = (UITouch *)[[touches allObjects] objectAtIndex:0];
	CGPoint touchPoint = [touch locationInView:self.view];
	
    float dist = [self calculateDistanceFromCenter:touchPoint];
    if ( dist > 100)
    {
        // forcing a tap to be on the ferrule
        NSLog(@"ignoring tap (%f,%f)", touchPoint.x, touchPoint.y);
        return;
    }
	
//	NSLog(@"%s",__func__);
	
    
//    CGPoint touchLocation = CGPointMake(currentPosition.x, currentPosition.y);
//	NSLog(@"--- %@",NSStringFromCGPoint(touchLocation));
	
	startTransform = self.batman.transform;
	
	float dx = touchPoint.x - centerCircle.x;
	float dy = touchPoint.y - centerCircle.y;
	deltaAngle = atan2(dy,dx);
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
	
	UITouch *touch = (UITouch *)[[touches allObjects] objectAtIndex:0];
    CGPoint pt = [touch locationInView:self.view];
	
    float dist = [self calculateDistanceFromCenter:pt];
    if ( dist > 100)
    {
        // forcing a tap to be on the ferrule
        NSLog(@"ignoring tap (%f,%f)", pt.x, pt.y);
        return;
    }
	
	
	float dx = pt.x  - centerCircle.x;
	float dy = pt.y  - centerCircle.y;
	float ang = atan2(dy,dx);
    
    float angleDifference = deltaAngle - ang;
    
    self.batman.transform = CGAffineTransformRotate(startTransform, -angleDifference);
	
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{

	CGFloat radians = atan2f(self.batman.transform.b, self.batman.transform.a);
	
	NSLog(@"en radianes %f",radians);
	
	double resultGrados = radians * 180 / PI;
	NSLog(@"---- %f",resultGrados);
	
	//si es mayor a 1.61
	if (radians > .785) {
		[UIView beginAnimations:nil context:NULL];
		[UIView setAnimationDuration:0.2];
		CGAffineTransform t = CGAffineTransformRotate(CGAffineTransformIdentity, 1.57);
		self.batman.transform = t;
		[UIView commitAnimations];
	}
	
	if (radians < -.785) {
		[UIView beginAnimations:nil context:NULL];
		[UIView setAnimationDuration:0.2];
		CGAffineTransform t = CGAffineTransformRotate(CGAffineTransformIdentity, -1.57);
		self.batman.transform = t;
		[UIView commitAnimations];
	}
	
	//si es menor a .785
	if (radians >= -.785 && radians <= .785) {
		[UIView beginAnimations:nil context:NULL];
		[UIView setAnimationDuration:0.2];
		CGAffineTransform t = CGAffineTransformRotate(CGAffineTransformIdentity, 0);
		self.batman.transform = t;
		[UIView commitAnimations];
	}
	
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated{
	[super viewDidAppear:animated];
	
	
	centerCircle = self.viewCircle.center;
	NSLog(@"centro. %@",NSStringFromCGPoint(centerCircle));
	
	UIView *centro = [[UIView alloc] initWithFrame:CGRectMake(centerCircle.x-2, centerCircle.y-2, 4, 4)];
	centro.backgroundColor = [UIColor redColor];
	[self.view addSubview:centro];

	
}

@end
