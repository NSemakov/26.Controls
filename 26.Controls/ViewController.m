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
    self.testView.backgroundColor=[UIColor redColor];
    self.currentAngle=0;
    self.durationOfAnimation=2.f;


}
- (void) viewDidAppear:(BOOL)animated {
    [super viewDidAppear:YES];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) rotationMethod:(CGFloat) fromValueAngle{
    
    CABasicAnimation *anim;
    anim = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    anim.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    anim.duration = self.durationOfAnimation;
    anim.repeatCount = INFINITY;

    anim.fromValue=[NSNumber numberWithFloat:fromValueAngle];
    anim.byValue = [NSNumber numberWithFloat:3.14f+fromValueAngle];
    
    [self.testView.layer addAnimation:anim forKey:@"rotateByZ"];
}

- (void) scalingMethod {
    CAKeyframeAnimation *scaleAnimation=[[CAKeyframeAnimation alloc]init];
    scaleAnimation.keyPath=@"transform.scale";
    scaleAnimation.keyTimes=@[@0,@0.5,@1];//same as default
    scaleAnimation.values=  @[@1, @3, @1];
    scaleAnimation.duration=self.durationOfAnimation;
    
    scaleAnimation.timingFunction=[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    scaleAnimation.repeatCount = HUGE_VALF;
    
    [self.testView.layer addAnimation:scaleAnimation forKey:@"scaling"];
}
- (void) translationMethod {
    CAKeyframeAnimation *anim;
    anim = [CAKeyframeAnimation animationWithKeyPath:@"transform.translation.x"];
    anim.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    anim.duration = self.durationOfAnimation;
    
    anim.repeatCount = INFINITY;
    CGFloat initialX=CGRectGetMinX(self.testView.frame);
    NSLog(@"initial x: %f",initialX);
    anim.values=@[@0,@100,@0,@(-100),@0];
   
    [self.testView.layer addAnimation:anim forKey:@"translateByX"];
}

- (IBAction)actionSwitchRotation:(UISwitch *)sender {
    
    if (sender.isOn) {
        [self rotationMethod:self.currentAngle];
    } else {
        float currentAngle = [(NSNumber *)[self.testView.layer.presentationLayer valueForKeyPath:@"transform.rotation.z"] floatValue];
        //NSLog(@"current angle: %f",currentAngle*180/3.14);
        self.currentAngle=currentAngle;
        [self.testView.layer removeAnimationForKey:@"rotateByZ"];

        self.testView.transform=CGAffineTransformRotate(self.testView.transform, self.currentAngle);
        [UIView animateWithDuration:.3f delay:0 options:0 animations:^{
            self.testView.transform=CGAffineTransformRotate(self.testView.transform, -self.currentAngle);
            self.currentAngle=currentAngle;
        } completion:nil];
    }
}

- (IBAction)actionSwitchScale:(UISwitch *)sender {
    
    if (sender.isOn) {
        [self scalingMethod];
    } else {
        CGFloat currentScale = [(NSNumber *)[self.testView.layer.presentationLayer valueForKeyPath:@"transform.scale"] floatValue];
        [self.testView.layer removeAnimationForKey:@"scaling"];
        self.testView.transform=CGAffineTransformScale(self.testView.transform, currentScale, currentScale);
        [UIView animateWithDuration:.3f delay:0 options:0 animations:^{
            float currentScale = [(NSNumber *)[self.testView.layer.presentationLayer valueForKeyPath:@"transform.scale.z"] floatValue];
            self.testView.transform=CGAffineTransformScale(self.testView.transform, 1/currentScale, 1/currentScale);
            
        } completion:nil];
    }
}

- (IBAction)actionSwitchTranslation:(UISwitch *)sender {
    if (sender.isOn) {
        [self translationMethod];
        
    } else {
        CGFloat currentPosition = [(NSNumber *)[self.testView.layer.presentationLayer   valueForKeyPath:@"transform.translation.x"] floatValue];
        [self.testView.layer removeAnimationForKey:@"translateByX"];
        self.testView.transform=CGAffineTransformTranslate(self.testView.transform, currentPosition, 0);
        [UIView animateWithDuration:.3f delay:0 options:0 animations:^{
            
            self.testView.transform=CGAffineTransformTranslate(self.testView.transform, -currentPosition, 0);
        } completion:nil];
    }
}

- (IBAction)actionSliderSpeed:(UISlider *)sender {
    self.testView.layer.speed=roundf(sender.value*10)/10;
    //roundf(val * 100) / 100
    NSLog(@"speed %f rounded to: %f",sender.value,roundf(sender.value*10)/10);
}
@end
