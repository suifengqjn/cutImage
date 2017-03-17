//
//  BZImageViewController.m
//  imageCut
//
//  Created by qianjianeng on 16/4/15.
//  Copyright © 2016年 SF. All rights reserved.
//

#import "BZImageViewController.h"

#import "BZImageScrollow.h"
#import "HGCutView.h"


@interface BZImageViewController ()


@property (nonatomic, strong) UIImage *image;
@property (nonatomic, strong) HGCutView *cutView;
@property (nonatomic, strong) BZImageScrollow *imageView;
@property (nonatomic, strong) UIView *toolBar;


@end

@implementation BZImageViewController

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

- (BOOL)prefersStatusBarHidden
{
    return YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationBar.hidden = YES;
    self.imageView = [[BZImageScrollow alloc] initWithImage:_image];
    [self.view addSubview:self.imageView];
    self.cutView = [[HGCutView alloc] init];
    [self.view addSubview:_cutView];
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:YES];
    
    [self buildToolBar];
    
}

- (void)buildToolBar
{
    self.toolBar = [[UIView alloc] init];
    _toolBar.backgroundColor = [UIColor blackColor];
    _toolBar.frame = CGRectMake(0, kScreenHeight - 40, kScreenWidth, 40);
    [self.view addSubview:_toolBar];
    
    UIButton *cancel = [UIButton buttonWithType:UIButtonTypeSystem];
    [cancel addTarget:self action:@selector(cancalClick) forControlEvents:UIControlEventTouchUpInside];
    [cancel setTitle:NSLocalizedString(@"Cancel", nil) forState:UIControlStateNormal];
    [cancel setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [cancel.titleLabel setFont:[UIFont systemFontOfSize:15]];
    cancel.frame = CGRectMake(10, 10, 60, 20);
    [_toolBar addSubview:cancel];
    
    
    UIButton *choose = [UIButton buttonWithType:UIButtonTypeSystem];
    [choose addTarget:self action:@selector(chooseClick) forControlEvents:UIControlEventTouchUpInside];
    [choose setTitle:NSLocalizedString(@"Choose", nil) forState:UIControlStateNormal];
    [choose setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [choose.titleLabel setFont:[UIFont systemFontOfSize:15]];
    choose.frame = CGRectMake(kScreenWidth - 70, 10, 60, 20);
    [_toolBar addSubview:choose];
}

- (void)cancalClick
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)chooseClick
{
    UIImage *screenView = [self imageFromScreen];
    
    UIImage *cutImage = [self imageFromImage:screenView inRect:self.cutView.frame];
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(cutImage:)]) {
        [self.delegate cutImage:cutImage];
    }
    [self.navigationController popViewControllerAnimated:YES];
   // [self dismissViewControllerAnimated:YES completion:nil];
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
