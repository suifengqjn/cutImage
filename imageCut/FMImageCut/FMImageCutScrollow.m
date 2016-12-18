//
//  FMImageCutScrollow.m
//  Pinnacle
//
//  Created by qianjn on 2016/12/5.
//  Copyright © 2016年 5milesapp.com. All rights reserved.
//

#import "FMImageCutScrollow.h"

#define kScreenHeight ([UIScreen mainScreen].bounds.size.height)
#define kScreenWidth ([UIScreen mainScreen].bounds.size.width)

//导航栏高度
#define kNavHeight 64

@interface FMImageCutScrollow ()<UIScrollViewDelegate>

@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UIView *cutView;
@property (nonatomic, assign) CGRect originRect;


@end

@implementation FMImageCutScrollow

- (instancetype)initWithImage:(UIImage *)image
{
    self = [super initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - kNavHeight)];
    if (self) {
        
        self.backgroundColor = [UIColor blackColor];
        CGFloat imageWidth = image.size.width;
        CGFloat imageHeight = image.size.height;
        
        CGFloat newImageWidth = 0;
        CGFloat newImageHeight = 0;
        
        if (imageWidth > imageHeight) { // 宽图
            newImageWidth = imageWidth * kScreenWidth / imageHeight;
            newImageHeight = kScreenWidth;
        } else if (imageWidth < imageHeight){ //长图
            newImageWidth = kScreenWidth;
            newImageHeight = kScreenWidth * imageHeight / imageWidth;
            
        } else {
            newImageWidth = kScreenWidth;
            newImageHeight = kScreenWidth;
        }

        
        CGRect imageViewframe = CGRectMake(0, 0, newImageWidth, newImageHeight);
        _originRect = imageViewframe;
        self.imageView = [[UIImageView alloc] initWithFrame:imageViewframe];
        self.imageView.backgroundColor = [UIColor blackColor];
        self.imageView.image = image;
        self.delegate = self;
        
        [self addSubview:_imageView];
        
        self.minimumZoomScale = 1;
        
        //设置最大缩放比例
        self.maximumZoomScale = 3;
    
        self.contentSize = CGSizeMake(newImageWidth, newImageHeight);
        
        CGFloat span = (kScreenHeight - kNavHeight - kScreenWidth)/2;
        
        self.contentInset = UIEdgeInsetsMake(span, 0, span, 0);

        
        if (imageHeight > imageWidth) {
            self.contentOffset = CGPointMake(0, (newImageHeight - self.bounds.size.height)/2);
        } else if (imageHeight < imageWidth) {
            self.contentOffset = CGPointMake((newImageWidth - kScreenWidth)/2, self.contentOffset.y);
        }
        
        
    }
    return self;
}



//设置缩放视图
- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return _imageView;
    
}




@end
