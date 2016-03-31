//
//  ViewController.m
//  imageCut
//
//  Created by qianjianeng on 16/3/30.
//  Copyright © 2016年 SF. All rights reserved.
//

#import "ViewController.h"
#import "HGImageCutViewController.h"

@interface ViewController ()<HGImageCutViewControllerDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}
- (IBAction)butt:(id)sender {
    
    UIImage *image  = [UIImage imageNamed:@"12"];
    HGImageCutViewController *imageVC = [[HGImageCutViewController alloc] initWithImage:image];
    imageVC.delegate = self;
    [self presentViewController:imageVC animated:YES completion:nil];
}

- (void)cutImage:(UIImage *)image
{
    self.imageView.image = image;
}

@end
