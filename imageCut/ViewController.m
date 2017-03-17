//
//  ViewController.m
//  imageCut
//
//  Created by qianjianeng on 16/3/30.
//  Copyright © 2016年 SF. All rights reserved.
//

#import "ViewController.h"
#import "HGImageCutViewController.h"
#import "BZImageViewController.h"
#import "FMImageCutController.h"
#import "XCImageCutController.h"
@interface ViewController ()<HGImageCutViewControllerDelegate,BZImageCutViewControllerDelegate,XCImageCutControllerDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}
- (IBAction)butt:(id)sender {
    
    UIImage *image  = [UIImage imageNamed:@"23"];
    BZImageViewController *imageVC = [[BZImageViewController alloc] initWithImage:image];
    imageVC.delegate = self;
    [self.navigationController pushViewController:imageVC animated:YES];
    
    
    
}

- (IBAction)btn2:(id)sender {
    UIImage *image  = [UIImage imageNamed:@"23"];
    HGImageCutViewController *imageVC = [[HGImageCutViewController alloc] initWithImage:image];
    imageVC.delegate = self;
    [self.navigationController pushViewController:imageVC animated:YES];
}

- (IBAction)btn3:(id)sender {
    UIImage *image  = [UIImage imageNamed:@"23"];
    FMImageCutController *imageVC = [[FMImageCutController alloc] initWithImage:image];
    //imageVC.delegate = self;
    [self.navigationController pushViewController:imageVC animated:YES];
    
}


- (IBAction)btn4:(id)sender {
    
    XCImageCutController *iamgeVC = [[XCImageCutController alloc] init];
    iamgeVC.currentImage = [UIImage imageNamed:@"23"];
    iamgeVC.delegate = self;
    [self.navigationController pushViewController:iamgeVC animated:YES];
}

- (void)cutImage:(UIImage *)image
{
    self.imageView.image = image;
}

@end
