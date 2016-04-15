//
//  BZCutView.m
//  imageCut
//
//  Created by qianjianeng on 16/4/15.
//  Copyright © 2016年 SF. All rights reserved.
//

#import "BZCutView.h"

@interface BZCutView ()
{
    CGPoint beginPoint;
}


@end

@implementation BZCutView

-(instancetype)init
{
    self = [super initWithFrame:CGRectMake(0, (kScreenHeight - kScreenWidth/3)/2, kScreenWidth-2, kScreenWidth/3)];
    if (self)
    {
        self.layer.borderColor = [self colorWithHex:0xffffff alpha:1].CGColor;
        self.layer.borderWidth = 1.0;
        self.backgroundColor = [self colorWithHex:0xffffff alpha:0.24];
        self.alpha = 0.2;
        self.userInteractionEnabled = NO;
        
    }
    return self;
}
- (UIColor*)colorWithHex:(NSInteger)hexValue alpha:(CGFloat)alphaValue
{
    return  [UIColor colorWithRed:((float)((hexValue & 0xFF0000) >> 16))/255.0
                            green:((float)((hexValue & 0xFF00) >> 8))/255.0
                             blue:((float)(hexValue & 0xFF))/255.0
                            alpha:alphaValue];
    
}
@end
