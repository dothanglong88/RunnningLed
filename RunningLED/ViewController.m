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
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _margin = 40.0;
    _space = 40.0;
//    [self drawRowofBalls:3];
    [self drawBallFullWidthAndHeight];
}

-(void) placeGreyBallAtX: (CGFloat) x
                    andY: (CGFloat) y
                 withTag: (int)tag{
    UIImageView* ball = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"orange"]];
    ball.center = CGPointMake(x, y);
//    _diameter = ball.bounds.size.width;
//    NSLog(@"width ball = %3.0f", _diameter);
//    _margin = _diameter + 10.0;
    ball.tag = tag;
    [self.view addSubview:ball];
}

- (void) drawRowofBalls: (int) numberBalls{
    CGFloat space = [self spaceBetweenBallCenterWhenNumberBallIsKnown:numberBalls];
    for (int i = 0; i < numberBalls; i++) {
        [self placeGreyBallAtX:i * space + _margin
                          andY:140
                       withTag:1];
    }
}

- (void) drawBallFullWidthAndHeight{
    int numberBalls = [self allBallOnWidthDevice];
    int numberRows = [self allRowOnHeightDevice];
    for (int j = 0; j < numberRows; j++) {
        for (int i = 0; i < numberBalls; i++) {
            [self placeGreyBallAtX:i * _space + _margin
                              andY:j * _space + _margin
                           withTag:1];
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
