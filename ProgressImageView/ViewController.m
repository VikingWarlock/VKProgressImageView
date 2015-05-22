//
//  ViewController.m
//  ProgressImageView
//
//  Created by viking warlock on 5/22/15.
//  Copyright (c) 2015 VikingWarlock. All rights reserved.
//

#import "ViewController.h"
#import "ImageviewWithProgress.h"

@interface ViewController ()
{

    ImageviewWithProgress *codeImage;
    ImageviewWithProgress *codeimage2;
    ImageviewWithProgress *codeimage3;

}
@property(nonatomic,weak)IBOutlet ImageviewWithProgress *small;
@property(nonatomic,weak)IBOutlet ImageviewWithProgress *mid;
@property(nonatomic,weak)IBOutlet ImageviewWithProgress *large;
@property(nonatomic,weak)IBOutlet UISlider *progressSlider;
@property(nonatomic,weak)IBOutlet UIButton *inverseButton;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    codeImage=[[ImageviewWithProgress alloc]initWithImage:[UIImage imageNamed:@"demo.jpg"]];
    [self.view addSubview:codeImage];
    codeImage.contentMode=UIViewContentModeScaleAspectFill;
    codeImage.frame=CGRectMake(40.f, 110.f, 80.f, 80.f);

    codeimage2=[[ImageviewWithProgress alloc]initWithFrame:CGRectMake(140.f, 110.f, 80.f, 80.f)];
    codeimage2.image=[UIImage imageNamed:@"demo.jpg"];
    [self.view addSubview:codeimage2];
    codeimage2.contentMode=UIViewContentModeScaleAspectFill;

    codeimage3=[[ImageviewWithProgress alloc]init];
    codeimage3.image=[UIImage imageNamed:@"demo.jpg"];
    [self.view addSubview:codeimage3];
    codeimage3.contentMode=UIViewContentModeScaleAspectFill;
    codeimage3.frame=CGRectMake(40.f, 200.f, 80.f, 80.f);

    
    // Do any additional setup after loading the view, typically from a nib.
}

-(IBAction)changeValue:(UISlider*)sender
{
    [self.small setProgress:sender.value];
    [self.mid setProgress:sender.value];
    [self.large setProgress:sender.value];
    [codeImage setProgress:sender.value];
    [codeimage2 setProgress:sender.value];
    [codeimage3 setProgress:sender.value];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
