//
//  HGImageScrollowView.m
//  Pinnacle
//
//  Created by qianjianeng on 16/3/30.
//  Copyright © 2016年 The Third Rock Ltd. All rights reserved.
//

#import "HGImageScrollowView.h"

#import "HGCutView.h"
@interface HGImageScrollowView () <UIScrollViewDelegate>
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UIView *cutView;
@end

@implementation HGImageScrollowView

- (instancetype)initWithImage:(UIImage *)image
{
    self = [super initWithFrame:[UIScreen mainScreen].bounds];
    if (self) {
        
        self.imageView = [[UIImageView alloc] initWithFrame:[UIScreen mainScreen].bounds];
        
        self.imageView.image = image;
        self.delegate = self;
        
        [self addSubview:_imageView];
        
        self.minimumZoomScale = 1;
        
        //设置最大缩放比例
        self.maximumZoomScale = 3;
        //[self cutImageView];
        
    }
    return self;
}

//设置缩放视图
- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return _imageView;
}



//- (void)cutImageView
//{
//    self.cutView = [[UIView alloc] init];
//    self.cutView.frame = CGRectMake(0, (kScreenHeight - 200)/2, kScreenWidth-2, 200);
//    _cutView.layer.borderColor = [UIColor redColor].CGColor;
//    _cutView.layer.borderWidth = 1.0;
//    _cutView.backgroundColor = [UIColor grayColor];
//    _cutView.alpha = 0.2;
//    
//    [self addSubview:_cutView];
//    
//    
//    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panClick:)];
//    [self.cutView addGestureRecognizer:pan];
//    
//}
//
//- (void)panClick:(UIPanGestureRecognizer *)recognizer
//{
//    CGPoint translatedPoint = [recognizer translationInView:self.cutView];
//    NSLog(@"gesture translatedPoint  is %@", NSStringFromCGPoint(translatedPoint));
//    //CGFloat x = recognizer.view.center.x + translatedPoint.x;
//    CGFloat y = recognizer.view.center.y + translatedPoint.y;
//    y = translatedPoint.y;
//    if (y > 0 && y < kScreenHeight - 200) {
//        self.cutView.frame = CGRectMake(0, y, kScreenWidth-2, 200);
//    }
//    
//    
//    //NSLog(@"---%f----%f", x,y);
//}
@end
