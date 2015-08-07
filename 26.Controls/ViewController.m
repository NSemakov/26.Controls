//
//  ViewController.m
//  26.Controls
//
//  Created by Admin on 05.08.15.
//  Copyright (c) 2015 Admin. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.testView.image=[UIImage imageWithContentsOfFile:@"/Users/admin/Desktop/XCodeProjects/26.Controls/26.Controls/images/tennis.png"];
    self.currentAngle=0;
    self.durationOfAnimation=2.f;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) rotationMethodOn:(CGFloat) fromValueAngle{
    
    CABasicAnimation *anim;
    anim = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    anim.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    anim.duration = self.durationOfAnimation;
    anim.repeatCount = INFINITY;
    anim.cumulative=YES;
    //anim.additive=YES;
    anim.fromValue=[NSNumber numberWithFloat:fromValueAngle];
    anim.byValue = [NSNumber numberWithFloat:3.14f+fromValueAngle];
    
    [self.testView.layer addAnimation:anim forKey:@"rotateByZ"];
}
- (void) rotationMethodOff{
    float currentAngle = [(NSNumber *)[self.testView.layer.presentationLayer valueForKeyPath:@"transform.rotation.z"] floatValue];
    //NSLog(@"current angle: %f",currentAngle*180/3.14);
    self.currentAngle=currentAngle;
    [self.testView.layer removeAnimationForKey:@"rotateByZ"];
    
    self.testView.transform=CGAffineTransformRotate(self.testView.transform, self.currentAngle);
    [UIView animateWithDuration:.3f delay:0 options:0 animations:^{
        self.testView.transform=CGAffineTransformRotate(self.testView.transform, -self.currentAngle);
        self.currentAngle=0;
       // NSLog(@"current angle: %f",self.currentAngle*180/3.14);
    } completion:nil];

}


- (void) scalingMethodOn {
    CAKeyframeAnimation *scaleAnimation=[[CAKeyframeAnimation alloc]init];
    scaleAnimation.keyPath=@"transform.scale";
    scaleAnimation.keyTimes=@[@0,@0.5,@1];//same as default
    scaleAnimation.values=  @[@1, @2, @1];
    scaleAnimation.duration=self.durationOfAnimation;
    
    scaleAnimation.timingFunction=[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    scaleAnimation.repeatCount = HUGE_VALF;
    
    [self.testView.layer addAnimation:scaleAnimation forKey:@"scaling"];
}
- (void) scalingMethodOff {
    CGFloat currentScale = [(NSNumber *)[self.testView.layer.presentationLayer valueForKeyPath:@"transform.scale"] floatValue];
    [self.testView.layer removeAnimationForKey:@"scaling"];
    self.testView.transform=CGAffineTransformScale(self.testView.transform, currentScale, currentScale);
    [UIView animateWithDuration:.3f delay:0 options:0 animations:^{
        float currentScale = [(NSNumber *)[self.testView.layer.presentationLayer valueForKeyPath:@"transform.scale.z"] floatValue];
        self.testView.transform=CGAffineTransformScale(self.testView.transform, 1/currentScale, 1/currentScale);
        
    } completion:nil];
}
- (void) translationMethodOn {
    CAKeyframeAnimation *anim;
    anim = [CAKeyframeAnimation animationWithKeyPath:@"transform.translation.x"];
    anim.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    anim.duration = self.durationOfAnimation;
    anim.repeatCount = INFINITY;
    anim.values=@[@0,@100,@0,@(-100),@0];
   
    [self.testView.layer addAnimation:anim forKey:@"translateByX"];
}

- (void) translationMethodOff {
    CGFloat currentPosition = [(NSNumber *)[self.testView.layer.presentationLayer   valueForKeyPath:@"transform.translation.x"] floatValue];
    [self.testView.layer removeAnimationForKey:@"translateByX"];
    self.testView.transform=CGAffineTransformTranslate(self.testView.transform, currentPosition, 0);
    [UIView animateWithDuration:.3f delay:0 options:0 animations:^{
        
        self.testView.transform=CGAffineTransformTranslate(self.testView.transform, -currentPosition, 0);
    } completion:nil];

}

-(void)pauseLayer:(CALayer*)layer
{
    CFTimeInterval pausedTime = [layer convertTime:CACurrentMediaTime() fromLayer:nil];
    layer.speed = 0.0;
    layer.timeOffset = pausedTime;
}

-(void)resumeLayer:(CALayer*)layer speed:(CGFloat)speed
{
    CFTimeInterval pausedTime = [layer timeOffset];
    layer.speed = 1;//roundf(speed*10)/10;
    layer.timeOffset = 0.0;
    layer.beginTime = 0.0;
    CFTimeInterval timeSincePause = [layer convertTime:CACurrentMediaTime() fromLayer:nil] - pausedTime;
    layer.beginTime = timeSincePause;
}

- (IBAction)actionSwitchRotation:(UISwitch *)sender {
    
    if (sender.isOn) {
        [self rotationMethodOn:self.currentAngle];
    } else {
        [self rotationMethodOff];
    }
}

- (IBAction)actionSwitchScale:(UISwitch *)sender {
    
    if (sender.isOn) {
        [self scalingMethodOn];
    } else {
        [self scalingMethodOff];
    }
}

- (IBAction)actionSwitchTranslation:(UISwitch *)sender {
    
    if (sender.isOn) {
        [self translationMethodOn];
    } else {
        [self translationMethodOff];
    }
}

- (IBAction)actionSliderSpeed:(UISlider *)sender {
    
    CGFloat value=roundf(sender.value*10)/10;
    
    //start of code for changing speed of animation without jerk
    self.testView.layer.timeOffset = [ self.testView.layer convertTime:CACurrentMediaTime() fromLayer:nil];
    self.testView.layer.beginTime = CACurrentMediaTime();
    self.testView.layer.speed=value;
    //end of code for changing speed of animation without jerk
    
    self.labelSpeed.text=[NSString stringWithFormat:@"Speed: %.1fx",value];
}

- (IBAction)actionChangeImage:(UISegmentedControl *)sender {
    switch (sender.selectedSegmentIndex) {
        case BallTypeTennis:
            self.testView.image=[UIImage imageWithContentsOfFile:@"/Users/admin/Desktop/XCodeProjects/26.Controls/26.Controls/images/tennis.png"];
            break;
        case BallTypeFootball:
            self.testView.image=[UIImage imageWithContentsOfFile:@"/Users/admin/Desktop/XCodeProjects/26.Controls/26.Controls/images/football.jpg"];
            break;

        case BallTypeBasketball:
            self.testView.image=[UIImage imageWithContentsOfFile:@"/Users/admin/Desktop/XCodeProjects/26.Controls/26.Controls/images/basket.png"];
            break;
        default:
            break;
    }
}
@end
