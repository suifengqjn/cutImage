//
//  BZImageScrollow.m
//  imageCut
//
//  Created by qianjianeng on 16/4/15.
//  Copyright © 2016年 SF. All rights reserved.
//

#import "BZImageScrollow.h"



#define kScreenHeight ([UIScreen mainScreen].bounds.size.height)
#define kScreenWidth ([UIScreen mainScreen].bounds.size.width)
@interface BZImageScrollow () <UIScrollViewDelegate>
@property (nonatomic, strong) UIImageView *imageView;

@property (nonatomic, assign) CGFloat blackImageHeight;
@property (nonatomic, assign) CGFloat scale;
@property (nonatomic, assign) CGSize originSize;
@property (nonatomic, assign) CGSize originSize2;
@end

@implementation BZImageScrollow

- (instancetype)initWithImage:(UIImage *)image
{
    self = [super initWithFrame:CGRectMake(0, 20, kScreenWidth, kScreenHeight- 20)];
    if (self) {
        
        
        CGFloat width = kScreenWidth;
        CGFloat height = width * image.size.height / image.size.width;
        CGRect imageViewframe = CGRectMake(0, 0, width, height);
        
        self.imageView = [[UIImageView alloc] initWithFrame:imageViewframe];
        
        _imageView.center = self.center;
        
        self.imageView.image = image;
        
        _originSize = _imageView.frame.size;
        
        UIImage *newImage = [self imageFromScreenView:_imageView];
        
        CGFloat cutWidth = newImage.size.width;
        CGFloat cutHeight = (kScreenHeight - kScreenWidth/3)/2;
        
        _blackImageHeight = cutHeight;
        
        UIImage *blackImage = [self createBlackImageWithWidth:cutWidth Height:cutHeight];
        
        UIImage *image1 = [self addImage:blackImage toImage:newImage];
        UIImage *image2 = [self addImage:image1 toImage:blackImage];
        
        
        self.imageView.frame = CGRectMake(0, 0, width, height+ cutHeight* 2);
        self.imageView.image = image2;
        
        
        
        
        
        self.delegate = self;
        
        [self addSubview:_imageView];
        
        self.minimumZoomScale = 1;
        
        //设置最大缩放比例
        self.maximumZoomScale = 3;
        
        
        self.contentSize = CGSizeMake(width, image2.size.height);
        
        _originSize2 = _imageView.frame.size;
    }
    return self;
}


-(UIImage *)addImage:(UIImage *)image1 toImage:(UIImage *)image2
{
    
    UIGraphicsBeginImageContext(CGSizeMake(image1.size.width, image1.size.height+image2.size.height));
    
    //Draw image1
    [image1 drawInRect:CGRectMake(0, 0, image1.size.width, image1.size.height)];
    
    //Draw image2
    [image2 drawInRect:CGRectMake(0, image1.size.height, image2.size.width, image2.size.height)];
    
    UIImage *resultImage=UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return resultImage;
}

- (UIImage *)createBlackImageWithWidth:(CGFloat)width Height:(CGFloat)height
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, width, height)];
    view.backgroundColor = [UIColor blackColor];
    
    return [self imageFromScreenView:view];
    
}


- (UIImage *)imageFromScreenView:(UIView *)theView
{
    
    UIGraphicsBeginImageContext(theView.frame.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    [theView.layer renderInContext:context];
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return theImage;
}


//设置缩放视图
- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return _imageView;
}


- (void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(UIView *)view atScale:(CGFloat)scale
{
    _scale = scale;
    CGFloat gap = (kScreenHeight - kScreenWidth / 3) / 2;
    
    scrollView.contentInset = UIEdgeInsetsMake(-gap * (_scale - 1), 0, -gap * (_scale - 1), 0);
}


@end
