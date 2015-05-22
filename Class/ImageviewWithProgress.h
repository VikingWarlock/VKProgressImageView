//
//  ImageviewWithProgress.h
//  HaloWheel
//
//  Created by viking warlock on 5/21/15.
//  Copyright (c) 2015 Viking Warlock. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProgressImageView.h"

@interface ImageviewWithProgress : UIImageView

-(void)setInverseEnable:(BOOL)enable NS_UNAVAILABLE;

-(void)setProgress:(float)progress;

@end
