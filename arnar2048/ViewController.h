//
//  ViewController.h
//  arnar2048
//
//  Created by Dennis Kanygin on 2/10/16.
//  Copyright (c) 2016 kanygin software. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BoardView.h"

@interface ViewController : UIViewController <BoardViewDelegate>

@property (strong, nonatomic) BoardView* board;

@end

