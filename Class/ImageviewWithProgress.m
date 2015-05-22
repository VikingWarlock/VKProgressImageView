//
//  ImageviewWithProgress.m
//  HaloWheel
//
//  Created by viking warlock on 5/21/15.
//  Copyright (c) 2015 Viking Warlock. All rights reserved.
//

#import "ImageviewWithProgress.h"

#define BackgroundColorAlpha 0.5f

@interface ImageviewWithProgress()
{
    ProgressImageView *progressView;
    UILabel *percentageView;
    UIColor *maincolor;
    UIColor *converseColor;
    

}

@end

@implementation ImageviewWithProgress

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setup];
    }
    return self;
}

-(instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self=[super initWithCoder:aDecoder];
    if (self) {
        [self setup];
    }
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame
{
    self=[super initWithFrame:frame];
    if (self) {
        [self setup];
        progressView.frame=CGRectMake(0, 0, frame.size.width, frame.size.height);
        percentageView.frame=CGRectMake(0, 0, frame.size.width, frame.size.height);
        self.layer.cornerRadius=frame.size.height/2.f;
    }
    return self;
}

-(instancetype)initWithImage:(UIImage *)image
{
    self=[super initWithImage:image];
    if (self) {
        [self setup];
    }
    return self;
}

-(instancetype)initWithImage:(UIImage *)image highlightedImage:(UIImage *)highlightedImage
{
    self=[super initWithImage:image highlightedImage:highlightedImage];
    if (self) {
        [self setup];
    }
    return self;
}

-(void)setupLayout
{
    if (progressView==nil) {
        progressView=[[ProgressImageView alloc]init];
        [self addSubview:progressView];
    }
    if (percentageView==nil) {
        percentageView=[[UILabel alloc]init];
        [self addSubview:percentageView];
    }

}

-(void)setup
{
    self.layer.masksToBounds=YES;
    [self setupLayout];
    percentageView.text=@"0%";
    percentageView.textColor=[UIColor whiteColor];
    percentageView.textAlignment=NSTextAlignmentCenter;
    percentageView.adjustsFontSizeToFitWidth=YES;
    percentageView.minimumScaleFactor=5.f;
    
    if (self.image) {
        [self setupImage:self.image];
    }
    

}

-(void)setFrame:(CGRect)frame
{
    [super setFrame:frame];
    [self setupLayout];
    progressView.frame=CGRectMake(0, 0, frame.size.width, frame.size.height);
    percentageView.frame=CGRectMake(0, 0, frame.size.width, frame.size.height);
    self.layer.cornerRadius=frame.size.height/2.f;

}

-(void)setImage:(UIImage *)image
{
    [super setImage:image];
    NSLog(@"set image here");
    [self setupImage:image];
}

-(void)setupImage:(UIImage*)image
{
//    maincolor=[self maincolor:image];
//    converseColor=[self alphaColor:maincolor andAlpha:0.9];
//    progressView.backcolor=converseColor;
    progressView.backcolor=[UIColor colorWithWhite:0.f alpha:BackgroundColorAlpha];
}

-(void)setProgress:(float)progress
{
    progressView.progress=progress;
    percentageView.text=[NSString stringWithFormat:@"%d%%",(int)(progress*100)];

    if (progress>=1.f) {
        percentageView.hidden=YES;
    }else
    {
        percentageView.hidden=NO;
    }
    
//    if (progress>0.5f) {
//        percentageView.textColor=maincolor;
//    }else
//    {
//        percentageView.textColor=[self converseColor:maincolor andAlpha:1.f];
//    }
    
//    percentageView.textColor=[self converseColor:maincolor andAlpha:1.f];
    percentageView.textColor=[UIColor whiteColor];
}

-(UIColor*)maincolor:(UIImage*)image NS_UNAVAILABLE
{
    UIImage *processImage;
    if (image.images) {
        processImage=image.images[0];
    }else
    {
        NSData *data1=UIImageJPEGRepresentation(image, 1.f);
        NSData *data=UIImagePNGRepresentation(image);
        
        NSLog(@"length is %lu and %lu",(unsigned long)data1.length,(unsigned long)data.length);
        
        processImage=[UIImage imageWithData:data];
    }
    
    CGSize Size=CGSizeMake(80, 80);
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef context = CGBitmapContextCreate(NULL,Size.width,Size.height,8,Size.width*4,colorSpace,kCGBitmapByteOrderDefault | kCGImageAlphaPremultipliedLast);
    CGRect drawRect = CGRectMake(0, 0, Size.width, Size.height);
    CGContextDrawImage(context, drawRect, processImage.CGImage);
    
    CGColorSpaceRelease(colorSpace);
    unsigned char* data = CGBitmapContextGetData (context);
    
//    NSLog(@"data length is %lu",strlen(data));
    
    if (data == NULL) return nil;
    NSMutableArray *cls=[NSMutableArray arrayWithCapacity:Size.width*Size.height*0.36+5];
    
    for (int x=(int)(0.2*Size.width); x<(int)(0.8*Size.width); x++) {
        for (int y=(int)(0.2*Size.height); y<(int)(0.8*Size.height); y++) {
            int offset = 4*y*x;
            int r = data[offset];
            int g = data[offset+1];
            int b = data[offset+2];
//            int a =  data[offset+3];
            NSArray *clr=@[@(r),@(g),@(b),@(1)];
            [cls addObject:clr];
        }
    }
    CGContextRelease(context);
    
    NSCountedSet *cset = [NSCountedSet setWithArray:cls];
    

    
    NSArray *MaxColor=nil;
    NSArray *curColor=nil;
    NSUInteger MaxCount=0;

    NSEnumerator *enumerator=[cset objectEnumerator];
    
    while ( (curColor = [enumerator nextObject]) != nil )
    {
        NSUInteger tmpCount = [cset countForObject:curColor];
        if ( tmpCount < MaxCount ) continue;
        MaxCount=tmpCount;
        MaxColor=curColor;
    }
    
    return [UIColor colorWithRed:([MaxColor[0] intValue]/255.0f) green:([MaxColor[1] intValue]/255.0f) blue:([MaxColor[2] intValue]/255.0f) alpha:1.f];
}

-(UIColor*)converseColor:(UIColor*)color andAlpha:(float)alpha
{
    double r;
    double g;
    double b;
    double a;
    [color getRed:&r green:&g blue:&b alpha:&a];
    r=fabs(r*255-255)/255.f;
    g=fabs(g*255-255)/255.f;
    b=fabs(b*255-255)/255.f;
    return [UIColor colorWithRed:r green:g blue:b alpha:alpha];
}

-(UIColor*)alphaColor:(UIColor*)color andAlpha:(float)alpha
{
    double r;
    double g;
    double b;
    double a;
    [color getRed:&r green:&g blue:&b alpha:&a];
    return [UIColor colorWithRed:r*0.1 green:g*0.1 blue:b*0.1 alpha:alpha];
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
