//
//  ViewController.m
//  GPUImageTest
//
//  Created by app-01 on 2020/10/30.
//  Copyright © 2020 app-01 org. All rights reserved.
//

#import "ViewController.h"
#import <GPUImage.h>

@interface ViewController ()
@property (nonatomic,weak) IBOutlet UIImageView *imgView;
@property (weak, nonatomic) IBOutlet UISlider *brightSlider;
@property (weak, nonatomic) IBOutlet UILabel *brightLable;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.imgView.image = [self processImage:[UIImage imageNamed:@"IMG_5465.HEIC"]];
}

- (UIImage *)processImage:(UIImage *)img {
    GPUImagePicture *gpupicture = [[GPUImagePicture alloc] initWithImage:img];
    //卡通滤镜
    GPUImageToonFilter *toonFilter = [GPUImageToonFilter new];
    toonFilter.threshold = 0.1;
    //拉升变形滤镜
    GPUImageStretchDistortionFilter *strechDistortionFilter = [GPUImageStretchDistortionFilter new];
    strechDistortionFilter.center = CGPointMake(0.5, 0.5);
    GPUImageSepiaFilter *sepiaFilter = [[GPUImageSepiaFilter alloc] init];
    GPUImageBrightnessFilter *brightnessFilter = [[GPUImageBrightnessFilter alloc] init];
    brightnessFilter.brightness = _brightSlider.value;
    NSArray *filters = @[brightnessFilter];
    GPUImageView *gpuimageView = [[GPUImageView alloc] initWithFrame:self.imgView.frame];
    //pipelline 将输入源 输出 滤镜 三方绑定
    GPUImageFilterPipeline *pipLine = [[GPUImageFilterPipeline alloc] initWithOrderedFilters:filters input:gpupicture output:gpuimageView];
    [gpupicture processImage];
    [brightnessFilter useNextFrameForImageCapture];
    return [pipLine currentFilteredFrame];
}

- (IBAction)sliderChange:(id)sender {
    self.imgView.image = [self processImage:[UIImage imageNamed:@"IMG_5465.HEIC"]];
}

@end
