//
//  FMImageCutController.m
//  Pinnacle
//
//  Created by qianjn on 2016/12/5.
//  Copyright © 2016年 5milesapp.com. All rights reserved.
//

#import "FMImageCutController.h"
#import "FMImageCutScrollow.h"

#define kScreenHeight ([UIScreen mainScreen].bounds.size.height)
#define kScreenWidth ([UIScreen mainScreen].bounds.size.width)

//导航栏高度
#define kNavheight 64

@interface FMImageCutController ()<UIGestureRecognizerDelegate>

@property (nonatomic, strong) FMImageCutScrollow *imageView;

@property (nonatomic, strong) UIView *topCover;
@property (nonatomic, strong) UIView *bottomCover;
@property (nonatomic, assign) NSInteger currentIndex;

@property (nonatomic, strong) UIImage *image;

@property (nonatomic, strong) NSString *from;


@end

@implementation FMImageCutController

-(instancetype)initWithImage:(UIImage *)image
{
    self = [super init];
    if (self) {
        _image = image;
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.view.backgroundColor = [UIColor blackColor];
    self.edgesForExtendedLayout = UIRectEdgeNone;

}

- (void)forbidNav
{
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.imageView = [[FMImageCutScrollow alloc] initWithImage:_image];
    
    [self.view addSubview:self.imageView];

    [self buildCover];
    

}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}




- (UIImage *)cutImage
{
    for (UIView *subView in self.view.subviews) {
        if (![subView isMemberOfClass:[FMImageCutScrollow class]]) {
            subView.hidden = YES;
        }
    }
    UIGraphicsBeginImageContext(self.view.frame.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    [self.view.layer renderInContext:context];
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    CGImageRef sourceImageRef = [theImage CGImage];
    CGImageRef newImageRef = CGImageCreateWithImageInRect(sourceImageRef, CGRectMake(0, (self.imageView.bounds.size.height - self.imageView.bounds.size.width)/2, kScreenWidth, kScreenWidth));
    UIImage *newImage = [UIImage imageWithCGImage:newImageRef];
    return newImage;
    
}




- (void)buildCover
{
    CGFloat span = (kScreenHeight - kNavheight - kScreenWidth)/2;
    self.topCover = [[UIView alloc] init];
    self.topCover.backgroundColor = [UIColor colorWithWhite:0.5 alpha:0.5];
    self.topCover.frame = CGRectMake(0, 0, kScreenWidth, span);
    [self.view addSubview:self.topCover];

    UIView *leftLine = [[UIView alloc] init];
    leftLine.backgroundColor = [UIColor colorWithWhite:0.5 alpha:0.5];
    leftLine.frame = CGRectMake(0, span, 1, kScreenWidth);
    [self.view addSubview:leftLine];
    
    UIView *topline = [[UIView alloc] init];
    topline.backgroundColor = [UIColor colorWithWhite:0.5 alpha:0.5];
    topline.frame = CGRectMake(0, span, kScreenWidth, 1);
    [self.view addSubview:topline];
    
    UIView *rightLine = [[UIView alloc] init];
    rightLine.backgroundColor = [UIColor colorWithWhite:0.5 alpha:0.5];
    rightLine.frame = CGRectMake(kScreenWidth - 1, span, 1, kScreenWidth);
    [self.view addSubview:rightLine];
    
    UIView *bottomLine = [[UIView alloc] init];
    bottomLine.backgroundColor = [UIColor colorWithWhite:0.5 alpha:0.5];
    bottomLine.frame = CGRectMake(0, span+kScreenWidth, kScreenWidth, 1);
    [self.view addSubview:bottomLine];
    
    self.bottomCover = [[UIView alloc] init];
    self.bottomCover.backgroundColor = [UIColor colorWithWhite:0.5 alpha:0.5];
    self.bottomCover.frame = CGRectMake(0, self.imageView.bounds.size.height - span, kScreenWidth, span);
    [self.view addSubview:self.bottomCover];
}
- (void)dealloc
{
    
}
@end
