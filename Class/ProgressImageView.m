//
//  ProgressImageView.m
//  HaloWheel
//
//  Created by viking warlock on 5/20/15.
//  Copyright (c) 2015 Viking Warlock. All rights reserved.
//

#import "ProgressImageView.h"
#import <QuartzCore/QuartzCore.h>


#define PI 3.14159265358979323846

@interface ProgressImageView()
{
    float _progress;
    UIColor* backC;
}
@end

@implementation ProgressImageView

-(instancetype)initWithFrame:(CGRect)frame
{
    self=[super initWithFrame:frame];
    if (self) {
        _progress=0.f;
        self.backgroundColor=[UIColor clearColor];
        self.backcolor=[UIColor colorWithWhite:0 alpha:0.1f];

    }
    return self;
}


-(void)setProgress:(float)progress
{
    if (progress==_progress) {
        return;
    }else
    {
        if (progress!=0.f) {
            self.backgroundColor=[UIColor clearColor];
        }
        if (progress==1.f) {
            self.backgroundColor=[UIColor clearColor];
        }
        _progress=progress;
        [self setNeedsDisplay];
    }
}

-(void)setBackcolor:(UIColor*)backcolor
{
    self.backgroundColor=backcolor;
    backC=backcolor;
}

-(void)drawRect:(CGRect)rect
{
    if (_progress==0 || _progress==1) {
        
    }
    float r=360*_progress*PI/180.f;
    float start=-90.f*PI/180.f;
    if (_progress==0.f || _progress==1.f) {
        r=start;
    }
    
    float radius=MIN(CGRectGetHeight(rect), CGRectGetWidth(rect)) * 0.5;
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGContextClearRect(ctx, rect);
    float angle_start = start;
    float angle_end = r+start;
    
    if (_progress==0.f || _progress==1.f) {
        angle_end=angle_start;
    }

    CGFloat centerX = CGRectGetWidth(rect) * 0.5;
    CGFloat centerY = CGRectGetHeight(rect) * 0.5;
    CGContextMoveToPoint(ctx, centerX, centerY);
    CGContextSetFillColorWithColor(ctx, backC.CGColor);
    CGContextAddArc(ctx, centerX, centerY, radius,  angle_end, angle_start, 0);
    CGContextClosePath(ctx);
    CGContextFillPath(ctx);

}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
