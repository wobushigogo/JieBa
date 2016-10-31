//
//  ScanView.m
//  JieBa
//
//  Created by 汪洋 on 2016/10/31.
//  Copyright © 2016年 zhixin. All rights reserved.
//

#import "ScanView.h"

@interface ScanView()
@property (nonatomic, strong) UIImageView *scanBoxImageView;
@property (nonatomic, strong) UIImageView *scanLineView;
@property (nonatomic, strong) NSTimer *scanTimer;
@property (nonatomic, assign) NSInteger number;
@property (nonatomic, assign) BOOL isUp;
@end

@implementation ScanView

- (NSTimer *)scanTimer{
    if (_scanTimer == nil) {
        _scanTimer = [NSTimer scheduledTimerWithTimeInterval:0.03 target:self selector:@selector(startAnimation) userInfo:nil repeats:YES];
    }
    return _scanTimer;
}

- (void)startAnimation{
    
    if (_isUp == NO) {
        _number ++;
        _scanLineView.frame = CGRectMake(5, _number*2, self.frame.size.width-10, 3);
        if (_number*2 >= self.frame.size.height-10) {
            _isUp = YES;
        }
    }
    else {
        _number --;
        _scanLineView.frame = CGRectMake(5, _number * 2, self.frame.size.width-10, 3);
        if (_number*2 <= 10) {
            _isUp = NO;
        }
    }
}

- (void)setupScanUIView{
    
    if (_scanBoxImageView == nil) {
        _scanBoxImageView = [[UIImageView alloc] initWithFrame:self.bounds];
        [self addSubview:_scanBoxImageView];
        _scanBoxImageView.image = [UIImage imageNamed:@"scan_kuang"];
        _scanBoxImageView.contentMode = UIViewContentModeScaleAspectFit;
    }
    
    if (_scanLineView == nil) {
        _scanLineView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0,WidthXiShu(263), HeightXiShu(2))];
        _scanLineView.image = [UIImage imageNamed:@"scan_line"];
        [_scanBoxImageView addSubview:_scanLineView];
    }
    
    _number = 0;
    _isUp = NO;
    
    
}


- (void)startAnimationInSuperView:(UIView *)view{
    
    [view addSubview:self];
    [self setupScanUIView];
    [self scanTimer];
}


- (void)stopAnimation{
    
    [_scanTimer invalidate];
    _scanTimer = nil;
    
    [_scanBoxImageView removeFromSuperview];
    [_scanLineView removeFromSuperview];
    _scanBoxImageView = nil;
    _scanLineView = nil;
    
    
}
@end
