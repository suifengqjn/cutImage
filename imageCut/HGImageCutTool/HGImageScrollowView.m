//
//  HGImageScrollowView.m
//  Pinnacle
//
//  Created by qianjianeng on 16/3/30.
//  Copyright © 2016年 The Third Rock Ltd. All rights reserved.
//

#import "HGImageScrollowView.h"
#import "HGCutView.h"
#define kScreenHeight ([UIScreen mainScreen].bounds.size.height)
#define kScreenWidth ([UIScreen mainScreen].bounds.size.width)
@interface HGImageScrollowView () <UIScrollViewDelegate>
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UIView *cutView;
@end

@implementation HGImageScrollowView

- (instancetype)initWithImage:(UIImage *)image
{
    self = [super initWithFrame:[UIScreen mainScreen].bounds];
    if (self) {
        
        CGFloat width = kScreenWidth;
        CGFloat height = width * image.size.height / image.size.width;
        CGRect imageViewframe ;
        if (height < kScreenHeight - 64) {
            imageViewframe = CGRectMake(0, (self.frame.size.height - height)/2, width, height);
        } else {
            imageViewframe = CGRectMake(0, 0, width, height);
        }
    
        self.imageView = [[UIImageView alloc] initWithFrame:imageViewframe];
        
        self.imageView.image = image;
        self.delegate = self;
        
        self.imageView.center = self.center;
        [self addSubview:_imageView];
        
        self.minimumZoomScale = 1;
        
        //设置最大缩放比例
        self.maximumZoomScale = 3;
        //[self cutImageView];
        
        self.backgroundColor = [UIColor whiteColor];
        
    }
    return self;
}

//设置缩放视图
- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return _imageView;
}



@end
