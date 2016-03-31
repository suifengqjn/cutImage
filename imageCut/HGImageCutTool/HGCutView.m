//
//  HGCutView.m
//  imageCut
//
//  Created by qianjianeng on 16/3/31.
//  Copyright © 2016年 SF. All rights reserved.
//

#import "HGCutView.h"

@interface HGCutView ()
{
    CGPoint beginPoint;
}

@end
@implementation HGCutView


-(instancetype)init
{
    self = [super initWithFrame:CGRectMake(0, (kScreenHeight - 200)/2, kScreenWidth-2, 200)];
    if (self)
    {
        self.layer.borderColor = [UIColor redColor].CGColor;
        self.layer.borderWidth = 1.0;
        self.backgroundColor = [UIColor grayColor];
        self.alpha = 0.2;
        
    }
    return self;
}
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    
    UITouch *touch = [touches anyObject];
    
    beginPoint = [touch locationInView:self];
    
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    
    UITouch *touch = [touches anyObject];
    
    CGPoint nowPoint = [touch locationInView:self];
    
    //float offsetX = nowPoint.x - beginPoint.x;
    
    float offsetY = nowPoint.y - beginPoint.y;
    
    if (self.center.y + offsetY > 100 && self.center.y + offsetY < kScreenHeight - 100) {
        self.center = CGPointMake(self.center.x, self.center.y + offsetY);
    }
    
}
@end
