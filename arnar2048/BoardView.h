//
//  BoardView.h
//  
//
//  Created by Dennis Kanygin on 2/10/16.
//
//

#import <UIKit/UIKit.h>
@class BoardView;

@protocol BoardViewDelegate

-(void)handleEndOfGame;

@end

@interface BoardView : UIView
@property (nonatomic, weak) id<BoardViewDelegate> delegate;
-(void) startNewGame;
-(void) moveDown;
-(void) moveUp;
-(void) moveRight;
-(void) moveLeft;
@end
