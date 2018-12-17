//
//  OptimizeCameraViewController.m
//  YYProject
//
//  Created by 于优 on 2018/12/14.
//  Copyright © 2018 SuperYu. All rights reserved.
//

#import "OptimizeCameraViewController.h"
#import "GPUImageView.h"
#import "GPUImageVideoCamera.h"
#import "GPUImageSepiaFilter.h"

@interface OptimizeCameraViewController ()

@property (nonatomic , strong) GPUImageView *mGPUImageView;
@property (nonatomic , strong) GPUImageVideoCamera *mGPUVideoCamera;

@end

@implementation OptimizeCameraViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.mGPUVideoCamera = [[GPUImageVideoCamera alloc] initWithSessionPreset:AVCaptureSessionPreset640x480 cameraPosition:AVCaptureDevicePositionBack];
    self.mGPUImageView.fillMode = kGPUImageFillModeStretch;//kGPUImageFillModePreserveAspectRatioAndFill;
    
    GPUImageSepiaFilter* filter = [[GPUImageSepiaFilter alloc] init];
    [self.mGPUVideoCamera addTarget:filter];
    [filter addTarget:self.mGPUImageView];
    
    //[self.mGPUVideoCamera addTarget:self.mGPUImageView];
    
    [self.mGPUVideoCamera startCameraCapture];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(deviceOrientationDidChange:) name:UIDeviceOrientationDidChangeNotification object:nil];
}

- (void)deviceOrientationDidChange:(NSNotification *)notification {
    UIInterfaceOrientation orientation = (UIInterfaceOrientation)[UIDevice currentDevice].orientation;
    self.mGPUVideoCamera.outputImageOrientation = orientation;
}

@end
