//
//  ViewController.h
//  26.Controls
//
//  Created by Admin on 05.08.15.
//  Copyright (c) 2015 Admin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (weak, nonatomic) IBOutlet UISlider *sliderValue;
@property (weak, nonatomic) IBOutlet UIImageView *testView;
@property (assign,nonatomic) CGFloat currentAngle;
@property (assign,nonatomic) CGFloat durationOfAnimation;

- (IBAction)actionSwitchRotation:(UISwitch *)sender;
- (IBAction)actionSwitchScale:(UISwitch *)sender;
- (IBAction)actionSwitchTranslation:(UISwitch *)sender;
- (IBAction)actionSliderSpeed:(UISlider *)sender;


@end

