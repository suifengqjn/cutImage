//
//  XCImageCutController.m
//  imageCut
//
//  Created by qianjn on 2017/2/24.
//  Copyright © 2017年 SF. All rights reserved.
//

#import "XCImageCutController.h"
#import "XCImageCutScrollow.h"
#import "UIColor+Hex.h"
@interface XCImageCutController ()

@property (nonatomic, strong) XCImageCutScrollow *imageView;



@property (nonatomic, strong) UIView *topCover;
@property (nonatomic, strong) UIView *bottomCover;
@property (nonatomic, assign) NSInteger currentIndex;

@end

@implementation XCImageCutController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.imageView = [[XCImageCutScrollow alloc] initWithImage:_currentImage];
    
    [self.view addSubview:self.imageView];
    
    [self buildCover];
    
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"save" style:UIBarButtonItemStyleDone target:self action:@selector(ButtonClick)];
    
}

- (void)ButtonClick
{
    UIImage *image = [self cutImage];
    NSLog(@"%@", image);
}


#pragma mark - image deal
- (BOOL)hasAlpha:(UIImage *)image
{
    CGImageAlphaInfo alphaInfo = CGImageGetAlphaInfo([image CGImage]);
    return (alphaInfo == kCGImageAlphaFirst || alphaInfo == kCGImageAlphaLast ||
            alphaInfo == kCGImageAlphaPremultipliedFirst || alphaInfo == kCGImageAlphaPremultipliedLast);
}

- (UIImage *)croppedImage:(UIImage *)image WithFrame:(CGRect)frame
{
    CGImageRef sourceImageRef = [image CGImage];
    CGImageRef newImageRef = CGImageCreateWithImageInRect(sourceImageRef, frame);
    return  [UIImage imageWithCGImage:newImageRef];
    
}


- (UIImage *)cutImage
{
    return [self croppedImage:self.imageView.imageView.image WithFrame:[self cutFrame]];
    
}


- (CGRect)cutFrame
{
    CGSize imageSize = self.imageView.imageView.image.size;
    CGSize contentSize = self.imageView.contentSize;
    CGRect cropBoxFrame = CGRectMake(0, (kScreenHeight - kNavHeight)/2, kScreenWidth, kScreenWidth);
    CGPoint contentOffset = self.imageView.contentOffset;
    UIEdgeInsets edgeInsets = self.imageView.contentInset;
    
    CGRect frame = CGRectZero;
    frame.origin.x = floorf((contentOffset.x + edgeInsets.left) * (imageSize.width / contentSize.width));
    frame.origin.x = MAX(0, frame.origin.x);
    
    frame.origin.y = floorf((contentOffset.y + edgeInsets.top) * (imageSize.height / contentSize.height));
    frame.origin.y = MAX(0, frame.origin.y);
    
    frame.size.width = ceilf(cropBoxFrame.size.width * (imageSize.width / contentSize.width));
    frame.size.width = MIN(imageSize.width, frame.size.width);
    
    frame.size.height = ceilf(cropBoxFrame.size.height * (imageSize.height / contentSize.height));
    frame.size.height = MIN(imageSize.height, frame.size.height);
    
    return frame;
}

- (void)buildCover
{
    CGFloat span = (kScreenHeight - kNavHeight - kScreenWidth)/2;
    self.topCover = [[UIView alloc] init];
    self.topCover.backgroundColor = [UIColor colorWithRGB:0x000000 alpha:0.4];
    self.topCover.frame = CGRectMake(0, 0, kScreenWidth, span);
    [self.view addSubview:self.topCover];
    
    UIView *leftLine = [[UIView alloc] init];
    leftLine.backgroundColor = [UIColor colorWithRGB:0xffffff alpha:0.4];
    leftLine.frame = CGRectMake(0, span, 1, kScreenWidth);
    [self.view addSubview:leftLine];
    
    UIView *topline = [[UIView alloc] init];
    topline.backgroundColor = [UIColor colorWithRGB:0xffffff alpha:0.4];
    topline.frame = CGRectMake(0, span, kScreenWidth, 1);
    [self.view addSubview:topline];
    
    UIView *rightLine = [[UIView alloc] init];
    rightLine.backgroundColor = [UIColor colorWithRGB:0xffffff alpha:0.4];
    rightLine.frame = CGRectMake(kScreenWidth - 1, span, 1, kScreenWidth);
    [self.view addSubview:rightLine];
    
    UIView *bottomLine = [[UIView alloc] init];
    bottomLine.backgroundColor = [UIColor colorWithRGB:0xffffff alpha:0.4];
    bottomLine.frame = CGRectMake(0, span+kScreenWidth, kScreenWidth, 1);
    [self.view addSubview:bottomLine];
    
    self.bottomCover = [[UIView alloc] init];
    self.bottomCover.backgroundColor = [UIColor colorWithRGB:0x000000 alpha:0.4];
    self.bottomCover.frame = CGRectMake(0, self.imageView.frame.size.height - span, kScreenWidth, span);
    [self.view addSubview:self.bottomCover];
}

@end
