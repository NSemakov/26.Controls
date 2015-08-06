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
    
        
        //CGAffineTransform rot = CGAffineTransformMakeRotation(360*M_PI/180);
        //self.testView.transform = rot;

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
    anim.duration = 10;
    anim.repeatCount = INFINITY;
    //anim.cumulative=YES;
    //anim.fillMode = kCAFillModeForwards;
    anim.fromValue=[NSNumber numberWithFloat:fromValueAngle];
    anim.byValue = [NSNumber numberWithFloat:3.14f+fromValueAngle];
    anim.delegate=self;
    //get current layer angle during animation in flight
    //CALayer *currentLayer = (CALayer *)[self.testView.layer presentationLayer];
    float currentAngle = [(NSNumber *)[self.testView.layer.presentationLayer valueForKeyPath:@"transform.rotation.z"] floatValue];
    currentAngle = (currentAngle+fromValueAngle)*180/3.14;//roundf();
    
    //NSLog(@"current angle: %f",currentAngle);
    
    //anim.toValue = [NSNumber numberWithFloat:(360*M_PI/180 + beginValue)];
    [self.testView.layer addAnimation:anim forKey:@"rotate"];
}
- (IBAction)actionSwitchRotation:(UISwitch *)sender {
    
    if (sender.isOn) {
        [self rotationMethod:self.currentAngle];
    } else {
        float currentAngle = [(NSNumber *)[self.testView.layer.presentationLayer valueForKeyPath:@"transform.rotation.z"] floatValue];
        //NSLog(@"current angle: %f",currentAngle);
        self.currentAngle=currentAngle;
        [self.testView.layer removeAnimationForKey:@"rotate"];
        self.testView.transform=CGAffineTransformMakeRotation(self.currentAngle);
    }
   
}
    


- (IBAction)actionSwitchScale:(UISwitch *)sender {
    
    
    if (sender.isOn) {
        [UIView animateWithDuration:2 delay:0 options:UIViewAnimationOptionBeginFromCurrentState|UIViewAnimationOptionRepeat|UIViewAnimationOptionAutoreverse animations:^{
            CGAffineTransform transformation=CGAffineTransformMakeScale(1.5, 1.5);
            self.testView.transform=CGAffineTransformConcat(self.testView.transform, transformation);
            //self.testView.transform=transformation;
            
        } completion:nil];
        
    } else if (!self.switchRotation.isOn && !self.switchTranslation.isOn){
        [self.testView.layer removeAllAnimations];
    }
     
}

- (IBAction)actionSwitchTranslation:(UISwitch *)sender {
    if (sender.isOn) {
        [UIView animateWithDuration:2 delay:0 options:UIViewAnimationOptionBeginFromCurrentState|UIViewAnimationOptionRepeat|UIViewAnimationOptionAutoreverse animations:^{
            CGAffineTransform transformation=CGAffineTransformMakeTranslation(100, 0);
            //self.testView.transform=transformation;
            self.testView.transform=CGAffineTransformConcat(self.testView.transform, transformation);
        } completion:nil];
        
    } else if (!self.switchRotation.isOn && !self.switchScale.isOn){
        [self.testView.layer removeAllAnimations];
    }
}

- (IBAction)actionSliderSpeed:(UISlider *)sender {
    
}
@end
