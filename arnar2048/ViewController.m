//
//  ViewController.m
//  arnar2048
//
//  Created by Dennis Kanygin on 2/10/16.
//  Copyright (c) 2016 kanygin software. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
    
@end

@implementation ViewController

@synthesize board = _board;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.board = [[BoardView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    [self.view addSubview:self.board];
    self.board.delegate = self;
    
    UISwipeGestureRecognizer *leftSwiper = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeLeft)];
    leftSwiper.direction = UISwipeGestureRecognizerDirectionLeft;
    [self.view addGestureRecognizer:leftSwiper];
    
    UISwipeGestureRecognizer *rightSwiper = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeRight)];
    rightSwiper.direction = UISwipeGestureRecognizerDirectionRight;
    [self.view addGestureRecognizer:rightSwiper];

    UISwipeGestureRecognizer *upSwiper = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeUp)];
    upSwiper.direction = UISwipeGestureRecognizerDirectionUp;
    [self.view addGestureRecognizer:upSwiper];

    UISwipeGestureRecognizer *downSwiper = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeDown)];
    downSwiper.direction = UISwipeGestureRecognizerDirectionDown;
    [self.view addGestureRecognizer:downSwiper];

}
-(void) swipeLeft{
    NSLog(@"left!");
    [self.board moveLeft];
}

-(void) swipeRight{
    NSLog(@"right!");
    [self.board moveRight];
}

-(void) swipeUp{
    NSLog(@"up!");
    [self.board moveUp];
}

-(void) swipeDown{
    NSLog(@"down!");
    [self.board moveDown];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark BoardViewDelegate

-(void)handleEndOfGame{
    UIAlertController * alert=   [UIAlertController
                                  alertControllerWithTitle:@"Game Over..."
                                  message:@"Try again?"
                                  preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* yesButton = [UIAlertAction
                                actionWithTitle:@"Yes, please"
                                style:UIAlertActionStyleDefault
                                handler:^(UIAlertAction * action)
                                {
                                    //Handel your yes please button action here
                                    [self.board startNewGame];
                                    
                                    
                                }];
    UIAlertAction* noButton = [UIAlertAction
                               actionWithTitle:@"No, thanks"
                               style:UIAlertActionStyleDefault
                               handler:^(UIAlertAction * action)
                               {
                                   //Handel no, thanks button
                                   
                               }];
    
    [alert addAction:yesButton];
    [alert addAction:noButton];
    
    [self presentViewController:alert animated:YES completion:nil];
    NSLog(@"Game over");
}

@end
