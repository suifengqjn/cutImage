//
//  HGImageCutViewController.m
//  Pinnacle
//
//  Created by qianjianeng on 16/3/30.
//  Copyright © 2016年 The Third Rock Ltd. All rights reserved.
//

#import "HGImageCutViewController.h"
#import "HGImageScrollowView.h"
#import "HGCutView.h"
@interface HGImageCutViewController ()

@property (nonatomic, strong) UIImage *image;
@property (nonatomic, strong) HGCutView *cutView;
@property (nonatomic, strong) HGImageScrollowView *imageView;

@end

@implementation HGImageCutViewController

-(instancetype)initWithImage:(UIImage *)image
{
    self = [super init];
    if (self) {
        _image = image;

    }
    return self;
}


- (instancetype)initWithALAsset:(ALAsset *)alasset
{
    NSData *imageData = [self imageDataWithAsset:alasset];
    UIImage *image = [UIImage imageWithData:imageData];
    return [self initWithImage:image];
    
}



- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.imageView = [[HGImageScrollowView alloc] initWithImage:_image];
    
    [self.view addSubview:self.imageView];
    self.cutView = [[HGCutView alloc] init];
    
    [self.view addSubview:_cutView];
    
    
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    button.frame = CGRectMake(kScreenWidth - 100, 40, 100, 50);
    [button setTitle:@"保存" forState:UIControlStateNormal];
    button.titleLabel.textColor = [UIColor redColor];
    [button addTarget:self action:@selector(ButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
}

- (void)ButtonClick
{
    UIImage *screenView = [self imageFromScreen];
    
    UIImage *cutImage = [self imageFromImage:screenView inRect:self.cutView.frame];
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(cutImage:)]) {
        [self.delegate cutImage:cutImage];
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}

//从image上面截图
- (UIImage *)imageFromImage:(UIImage *)image inRect:(CGRect)rect {
    CGImageRef sourceImageRef = [image CGImage];
    CGImageRef newImageRef = CGImageCreateWithImageInRect(sourceImageRef, rect);
    UIImage *newImage = [UIImage imageWithCGImage:newImageRef];
    return newImage;

}


//屏幕截图
- (UIImage *)imageFromScreen
{
    UIWindow *screenWindow = [[UIApplication sharedApplication] keyWindow];
    UIGraphicsBeginImageContext(screenWindow.frame.size);
    [screenWindow.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *viewImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return  viewImage;
    
}


- (NSData *)imageDataWithAsset:(ALAsset *)asset
{
    ALAssetRepresentation *representation = [asset defaultRepresentation];
    long long size = representation.size;
    uint8_t *buffer = malloc((size_t)size);
    NSUInteger length = [representation getBytes:buffer fromOffset:0 length:(NSUInteger)size error:NULL];
    
    if (length == 0) {
        free(buffer);
        return nil;
    }
    
    NSData *data = [NSData dataWithBytes:buffer length:length];
    free(buffer);
    return data;
}

@end
