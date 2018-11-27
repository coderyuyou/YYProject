//
//  YYAlignmentButton.m
//  YYProject
//
//  Created by 于优 on 2018/11/27.
//  Copyright © 2018 SuperYu. All rights reserved.
//

#import "YYAlignmentButton.h"

@implementation YYAlignmentButton

- (void)layoutSubviews {
    [super layoutSubviews];
    
    switch (self.imgAlignment) {
            
        case UIImgAlignmentLeft: {
            if (self.imageView.frame.size.width + self.titleLabel.frame.size.width + self.interval > self.frame.size.width) {
                return;
            }
            //设置图片位置
            CGRect imgFrame = self.imageView.frame;
            imgFrame.origin.x = self.imageView.frame.origin.x - self.interval * 0.5;
            self.imageView.frame = imgFrame;
            
            //设置文字位置
            CGRect labFrame = self.titleLabel.frame;
            labFrame.origin.x = self.titleLabel.frame.origin.x + self.interval * 0.5;
            self.titleLabel.frame = labFrame;
        }
            break;
            
        case UIImgAlignmentRight: {
            if (self.imageView.frame.size.width + self.titleLabel.frame.size.width + self.interval > self.frame.size.width) {
                return;
            }
            //设置文字位置
            CGRect labFrame = self.titleLabel.frame;
            labFrame.origin.x = self.imageView.frame.origin.x - self.interval * 0.5;
            //如果发生二次布局 则退出
            if (labFrame.origin.x > self.frame.size.width * 0.5) {
                return;
            }
            self.titleLabel.frame = labFrame;
            //设置图片位置
            CGRect imgFrame = self.imageView.frame;
            imgFrame.origin.x = self.titleLabel.frame.size.width + self.titleLabel.frame.origin.x + self.interval;
            self.imageView.frame = imgFrame;
        }
            break;
            
        case UIImgAlignmentTop: {
            CGFloat imgHeight = self.imageView.frame.size.height;
            CGFloat labHeight = self.titleLabel.frame.size.height;
            if (labHeight <= 0 && self.titleLabel.text.length) {
                labHeight = self.titleLabel.font.pointSize + 2;
            }
            if (imgHeight + labHeight + self.interval > self.frame.size.height) {
                return;
            }
            //把图片居中
            CGPoint imgCenter = CGPointMake(0, 0);
            imgCenter.x = (self.frame.size.width - self.imageView.frame.size.width) * 0.5;
            imgCenter.y = (self.frame.size.height - imgHeight - labHeight - self.interval) * 0.5;

            self.imageView.frame = CGRectMake(imgCenter.x, imgCenter.y, self.imageView.frame.size.width, self.imageView.frame.size.height);
            //把文字居中
            CGPoint labCenter = CGPointMake(0, 0);
            labCenter.x = (self.frame.size.width - self.titleLabel.frame.size.width) * 0.5;
            labCenter.y = imgCenter.y + imgHeight + self.interval;
            self.titleLabel.frame = CGRectMake(labCenter.x, labCenter.y, self.titleLabel.frame.size.width, self.titleLabel.frame.size.height);
        }
            break;
            
        case UIImgAlignmentBottom: {
            
            CGFloat imgHeight = self.imageView.frame.size.height;
            CGFloat labHeight = self.titleLabel.frame.size.height;
            if (labHeight <= 0 && self.titleLabel.text.length) {
                labHeight = self.titleLabel.font.pointSize + 2;
            }
            if (imgHeight + labHeight + self.interval > self.frame.size.height) {
                return;
            }
            //把文字居中
            CGPoint labCenter = CGPointMake(0, 0);
            labCenter.x = (self.frame.size.width - self.titleLabel.frame.size.width) * 0.5;
            labCenter.y = (self.frame.size.height - imgHeight - labHeight - self.interval) * 0.5;
            
            self.titleLabel.frame = CGRectMake(labCenter.x, labCenter.y, self.titleLabel.frame.size.width, self.titleLabel.frame.size.height);
            //把图片居中
            CGPoint imgCenter = CGPointMake(0, 0);
            imgCenter.x = (self.frame.size.width - self.imageView.frame.size.width) * 0.5;
            imgCenter.y = labCenter.y + labHeight + self.interval;
            self.imageView.frame = CGRectMake(imgCenter.x, imgCenter.y, self.imageView.frame.size.width, self.imageView.frame.size.height);
        }
            break;
    }
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
}

@end
