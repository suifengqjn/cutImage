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
@interface ViewController ()<HGImageCutViewControllerDelegate,BZImageCutViewControllerDelegate>

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

- (void)cutImage:(UIImage *)image
{
    self.imageView.image = image;
}

@end
