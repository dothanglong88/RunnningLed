//
//  ViewController.m
//  RunningLED
//
//  Created by Xmob - Longdt on 4/28/16.
//  Copyright © 2016 Xmob - Longdt. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController
{
    CGFloat _margin;
    int _numberofBall;
    CGFloat _space;
    CGFloat _diameter;
    NSTimer* _timer;
    int _lastOnLED;
    int _ledBetween;
    int _ledLeft;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _margin = 40.0;
    _space = 40.0;
    _numberofBall = 9;
    _lastOnLED = -1;
    _ledLeft = -1;
    _ledBetween = _numberofBall/2;
    
//    [self drawRowofBalls:_numberofBall];
    
    //  ----------------------- SHOW LED FULL SCREEN
    
//  // Truyền số lượng đèn Led
        [self drawBallFullWidthAndHeight:_numberofBall];
    
    
//  // Full IconLed theo kích cỡ màn hình
    //    [self drawBallFullWidthAndHeight];
    
   
    
    
    //  ----------------------- RUNNING LED
    
    //  ---- 1 dong
    
//    //trai sang phai
//    _timer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(runningLEDLeftToRight) userInfo:nil repeats:true];
    
    
//    //phai sang trai
//    _lastOnLED = _numberofBall;
//    _timer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(runningLEDRightToLeft) userInfo:nil repeats:true];
    
    
//    //giua ra
//    NSLog(@"led between: %d" , _ledBetween);
//    _lastOnLED = _ledBetween;
//    _timer = [NSTimer scheduledTimerWithTimeInterval:0.7 target:self selector:@selector(runningLEDBetween) userInfo:nil repeats:true];
    
    
    
    //  ---- Nhieu dong
    
//    //trai sang phai
    _timer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(runningLEDLeftToRight) userInfo:nil repeats:true];

}

-(void) runningLEDLeftToRightFull{
    if (_lastOnLED != -1){
        [self turnOFFLed:_lastOnLED];
    }
    
    if (_lastOnLED != _numberofBall -1){
        _lastOnLED ++;
    }else{
        _lastOnLED = 0;
    }
    [self turnONLed:_lastOnLED];
}

- (void) runningLEDBetween{
    if (_ledLeft != -1){
        _ledLeft = _ledBetween - (_lastOnLED - _ledBetween);
        [self turnOFFLed:_lastOnLED];
        [self turnOFFLed:_ledLeft];
    }
    
    if ((_lastOnLED != _numberofBall - 1) && (_ledLeft != -1)){
        _lastOnLED ++;
    }else{
        _lastOnLED = _ledBetween;
    }
    _ledLeft = _ledBetween - (_lastOnLED - _ledBetween);
    [self turnONLed:_lastOnLED];
    if (_lastOnLED != _ledBetween){
        [self turnONLed:_ledLeft];
    }
}

-(void) runningLEDRightToLeft{
    if (_lastOnLED != _numberofBall){
        [self turnOFFLed:_lastOnLED];
    }
    
    if (_lastOnLED != 0){
        _lastOnLED --;
    }else{
        _lastOnLED = _numberofBall - 1;
    }
    [self turnONLed:_lastOnLED];
}

-(void) runningLEDLeftToRight{
    if (_lastOnLED != -1){
        [self turnOFFLed:_lastOnLED];
    }
    
    if (_lastOnLED != _numberofBall -1){
        _lastOnLED ++;
    }else{
        _lastOnLED = 0;
    }
    [self turnONLed:_lastOnLED];
}

- (void) turnONLed: (int)index {
    UIView* view = [self.view viewWithTag:index + 100];
    if (view && [view isMemberOfClass:[UIImageView class]]){
        UIImageView* ball = (UIImageView*) view;
        ball.image = [UIImage imageNamed:@"green"];
    }
}

- (void) turnOFFLed: (int)index{
    UIView* view = [self.view viewWithTag:index + 100];
    if (view && [view isMemberOfClass:[UIImageView class]]){
        UIImageView* ball = (UIImageView*) view;
        ball.image = [UIImage imageNamed:@"orange"];
    }
}

-(void) placeGreyBallAtX: (CGFloat) x
                    andY: (CGFloat) y
                 withTag: (int)tag{
    UIImageView* ball = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"orange"]];
    ball.center = CGPointMake(x, y);
    ball.tag = tag;
    [self.view addSubview:ball];
}

- (void) drawRowofBalls: (int) numberBalls{
    CGFloat space = [self spaceBetweenBallCenterWhenNumberBallIsKnown:numberBalls];
    for (int i = 0; i < numberBalls; i++) {
        [self placeGreyBallAtX:i * space + _margin
                          andY:140
                       withTag:i + 100];
    }
}

- (void) drawBallFullWidthAndHeight{
    int numberBalls = [self allBallOnWidthDevice];
    int numberRows = [self allRowOnHeightDevice];
    for (int j = 0; j < numberRows; j++) {
        for (int i = 0; i < numberBalls; i++) {
            [self placeGreyBallAtX:i * _space + _margin
                              andY:j * _space + _margin
                           withTag:i + 100 + j*_numberofBall ];
        }
    }
    
}

- (void) drawBallFullWidthAndHeight: (int) numberBalls{
    CGFloat space = [self spaceBetweenBallCenterWhenNumberBallIsKnown:numberBalls];
    int numberRows = [self allRowOnHeightDevice];
    for (int j = 0; j < numberRows; j++) {
        for (int i = 0; i < numberBalls; i++) {
            [self placeGreyBallAtX:i * space + _margin
                              andY:j * space + _margin
                           withTag:i + 100 + j*_numberofBall ];
        }
    }
    
}


-(int) allBallOnWidthDevice{
    return (self.view.bounds.size.width -2 * _margin) / _space + 1;
}

-(int) allRowOnHeightDevice{
    return (self.view.bounds.size.height -2 * _margin) / _space + 1;
}

-(CGFloat) spaceBetweenBallCenterWhenNumberBallIsKnown: (int) n{
    return (self.view.bounds.size.width -2 * _margin) / (n -1);
}

-(void) checkSizeofApp{
    CGSize size = self.view.bounds.size;
    NSLog(@"width = %3.0f, height = %3.0f", size.width, size.height);
}

@end
