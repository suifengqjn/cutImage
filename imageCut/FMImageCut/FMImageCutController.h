//
//  FMImageCutController.h
//  Pinnacle
//
//  Created by qianjn on 2016/12/5.
//  Copyright © 2016年 5milesapp.com. All rights reserved.
//

#import <UIKit/UIKit.h>


//这个剪切实际是在屏幕上截图，剪切的图片都与屏等宽
@interface FMImageCutController : UIViewController

-(instancetype)initWithImage:(UIImage *)image;
@end
