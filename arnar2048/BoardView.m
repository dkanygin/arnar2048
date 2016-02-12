//
//  BoardView.m
//  
//
//  Created by Dennis Kanygin on 2/10/16.
//
//

#import "BoardView.h"


#define BOARD_SIZE 4

@implementation BoardView
{
    int _board[BOARD_SIZE][BOARD_SIZE];
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(void) initBoard{
    for (int row = 0; row < BOARD_SIZE; row++){
        for (int col = 0; col < BOARD_SIZE; col++){
            _board[row][col] = 0;
        }
    }
    [self addTile:2];
    [self addTile:4];
}

-(NSMutableArray *)getFreeTiles{
    NSMutableArray *freeTiles = [[NSMutableArray alloc] init];
    for (int row=0; row<BOARD_SIZE; row++) {
        for (int col=0; col<BOARD_SIZE; col++) {
            if (_board[row][col] == 0) {
                [freeTiles addObject:[NSValue valueWithCGPoint:CGPointMake(row, col)]];
            }
        }
    }
    NSLog(@"found %d free tiles", (int)[freeTiles count]);
    return freeTiles;
}

-(void)refreshBoard{
    CGFloat width = self.frame.size.width/4;
    CGFloat height = width;
    CGFloat xOffset = 0;
    CGFloat yOffset = 50;
    for (int row = 0; row < BOARD_SIZE; row++){
        for (int col = 0; col < BOARD_SIZE; col++){
            UILabel *tile = [[UILabel alloc] initWithFrame:CGRectMake(xOffset+(col*width), yOffset+(row*height), width, height)];
            if (_board[row][col]!= 0) {
                tile.text = [NSString stringWithFormat:@"%d", _board[row][col]];
            }
            switch (_board[row][col]) {
                case 0:
                    tile.backgroundColor = [UIColor whiteColor];
                    break;
                case 2:
                    tile.backgroundColor = [UIColor purpleColor];
                    break;
                case 4:
                    tile.backgroundColor = [UIColor grayColor];
                    break;
                case 8:
                    tile.backgroundColor = [UIColor greenColor];
                    break;
                case 16:
                    tile.backgroundColor = [UIColor redColor];
                    break;
                case 32:
                    tile.backgroundColor = [UIColor blueColor];
                    break;
                case 64:
                    tile.backgroundColor = [UIColor lightGrayColor];
                    break;
                case 128:
                    tile.backgroundColor = [UIColor orangeColor];
                    break;
                case 256:
                    tile.backgroundColor = [UIColor yellowColor];
                    break;
                case 512:
                    tile.backgroundColor = [UIColor purpleColor];
                    break;
                case 1024:
                    tile.backgroundColor = [UIColor cyanColor];
                    break;
                case 2048:
                    tile.backgroundColor = [UIColor magentaColor];
                    break;
                    
                default:
                    break;
            }
            tile.textAlignment = NSTextAlignmentCenter;
            [self addSubview:tile];
//            NSLog(@"added a tile for x_ofset=%f x_offset=%f",  xOffset+(col*width), yOffset+(row*height));
        }
    }
}

-(void) startNewGame{
    [self initBoard];
    [self refreshBoard];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // init
        [self startNewGame];
        [self refreshBoard];
    }
    return self;
}

-(void)reverseRow:(int)row{
    int temp = _board[row][0];
    _board[row][0] = _board[row][3];
    _board[row][3] = temp;
    
    temp = _board[row][1];
    _board[row][1] = _board[row][2];
    _board[row][2] = temp;
}

-(void)reverseColumn:(int)col{
    int temp = _board[0][col];
    _board[0][col] = _board[3][col];
    _board[3][col] = temp;
    
    temp = _board[1][col];
    _board[1][col] = _board[2][col];
    _board[2][col] = temp;
}

- (BOOL)merge:(int)row doMerge:(BOOL)mergeFlag{
    BOOL merged = NO;
    for (int col=BOARD_SIZE-1; col>0; col--) {
        if (_board[row][col] > 0 && _board[row][col-1] == _board[row][col]){
            if (mergeFlag) {
                _board[row][col] = _board[row][col]*2;
                _board[row][col-1] = 0;
            }
            merged = YES;
        }
    }
    [self shiftRow:row];
    return merged;
}

- (BOOL)mergeColumn:(int)col doMerge:(BOOL)mergeFlag{
    BOOL merged = NO;
    for (int row=BOARD_SIZE-1; row>0; row--) {
        if (_board[row][col]>0 && _board[row-1][col] == _board[row][col]){
            if (mergeFlag) {
                _board[row][col] = _board[row][col]*2;
                _board[row-1][col] = 0;
            }
            merged = YES;
        }
    }
    [self shiftColumn:col];
    return merged;
}

- (BOOL) shiftRow:(int)row{
    BOOL changed = NO;
    int temp_row [] = {0,0,0,0};
    int index = BOARD_SIZE -1;
    BOOL updated = NO;
    for (int col= BOARD_SIZE-1; col >= 0; col--) {
        if (_board[row][col] != 0) {
            updated = YES;
            temp_row[index] = _board[row][col];
            index--;
        }
    }
    
    //check if anything changed
    for (int col= BOARD_SIZE-1; col >= 0; col--) {
        if (_board[row][col] != temp_row[col]) {
            changed = YES;
        }
    }

    if (updated) {
        for (int i=BOARD_SIZE-1; i>=0; i--) {
            _board[row][i] = temp_row[i];
        }
    }
    
    return changed;
}

//can reuse shiftrow here but would have to pass in column converted to row
- (BOOL) shiftColumn:(int)col{
    BOOL changed = NO;
    int temp_row [] = {0,0,0,0};
    int index = BOARD_SIZE -1;
    BOOL updated = NO;
    for (int row=BOARD_SIZE-1; row >= 0; row--) {
        if (_board[row][col] != 0) {
            updated = YES;
            temp_row[index] = _board[row][col];
            index--;
        }
    }
    //check if anything changed
    for (int row= BOARD_SIZE-1; row >= 0; row--) {
        if (_board[row][col] != temp_row[row]) {
            changed = YES;
        }
    }
    
    if (updated) {
        for (int i=BOARD_SIZE-1; i>=0; i--) {
            _board[i][col] = temp_row[i];
        }
    }
    
    return changed;
}

-(BOOL)canMove{

    BOOL moves = NO;
    
    //check if rows can be merged
    BOOL row_merged = [self merge:0 doMerge:YES] || [self merge:1 doMerge:YES] ||
                 [self merge:2 doMerge:YES] || [self merge:3 doMerge:YES];
    
    //check if columns can be merged
    BOOL col_merged = [self mergeColumn:0 doMerge:YES] || [self mergeColumn:1 doMerge:NO] ||
                 [self mergeColumn:2 doMerge:YES] || [self mergeColumn:3 doMerge:YES];
    
    moves = row_merged || col_merged;
    return moves;
}

-(void)checkIfGameDone{
    if ([[self getFreeTiles] count] == 0) {
        /*no free tiles left
         game could be over, check if any moves left */
        if (![self canMove] ) {
            [self.delegate handleEndOfGame];
        }
    }
}

-(void) addTile:(int)tileValue{
    
    // add two random tiles with each move
    NSMutableArray *freeTiles = [self getFreeTiles];
    if ([freeTiles count]>0) {
        int tile_inx = arc4random_uniform((int)[freeTiles count]);
        CGPoint tile_coods = [freeTiles[tile_inx] CGPointValue];
        int row = (int)tile_coods.x;
        int col = (int)tile_coods.y;
        _board[row][col] = tileValue;
    }
}

-(void) moveDown{
    BOOL col0_shifted = [self shiftColumn:0];
    BOOL col1_shifted = [self shiftColumn:1];
    BOOL col2_shifted = [self shiftColumn:2];
    BOOL col3_shifted = [self shiftColumn:3];
    
    BOOL col0_merged = [self mergeColumn:0 doMerge:YES];
    BOOL col1_merged = [self mergeColumn:1 doMerge:YES];
    BOOL col2_merged = [self mergeColumn:2 doMerge:YES];
    BOOL col3_merged = [self mergeColumn:3 doMerge:YES];
    
    if (col0_shifted || col0_merged || col1_shifted || col1_merged || col2_shifted || col2_merged || col3_shifted || col3_merged) {
        [self addTile:2];
        [self refreshBoard];
    }
    [self checkIfGameDone];
}

-(void) moveUp{
    [self reverseColumn:0];
    BOOL col0_shifted = [self shiftColumn:0];
    BOOL col0_merged = [self mergeColumn:0 doMerge:YES];
    [self reverseColumn:0];
    
    [self reverseColumn:1];
    BOOL col1_shifted = [self shiftColumn:1];
    BOOL col1_merged = [self mergeColumn:1 doMerge:YES];
    [self reverseColumn:1];

    [self reverseColumn:2];
    BOOL col2_shifted = [self shiftColumn:2];
    BOOL col2_merged = [self mergeColumn:2 doMerge:YES];
    [self reverseColumn:2];

    [self reverseColumn:3];
    BOOL col3_shifted = [self shiftColumn:3];
    BOOL col3_merged = [self mergeColumn:3 doMerge:YES];
    [self reverseColumn:3];
    
    if (col0_shifted || col0_merged || col1_shifted || col1_merged || col2_shifted || col2_merged || col3_shifted || col3_merged) {
        [self addTile:2];
        [self refreshBoard];
    }
    [self checkIfGameDone];
    
}

-(void) moveRight{
    BOOL row0_shifted = [self shiftRow:0];
    BOOL row0_merged = [self merge:0 doMerge:YES];
    BOOL row1_shifted = [self shiftRow:1];
    BOOL row1_merged = [self merge:1 doMerge:YES];
    BOOL row2_shifted = [self shiftRow:2];
    BOOL row2_merged = [self merge:2 doMerge:YES];
    BOOL row3_shifted = [self shiftRow:3];
    BOOL row3_merged = [self merge:3 doMerge:YES];
    if (row0_shifted || row0_merged || row1_shifted || row1_merged || row2_shifted || row2_merged || row3_shifted || row3_merged) {
        [self addTile:2];
        [self refreshBoard];
    }
    [self checkIfGameDone];
}


-(void) moveLeft{
    [self reverseRow:0];
    BOOL row0_shifted = [self shiftRow:0];
    BOOL row0_merged = [self merge:0 doMerge:YES];
    [self reverseRow:0];

    [self reverseRow:1];
    BOOL row1_shifted = [self shiftRow:1];
    BOOL row1_merged = [self merge:1 doMerge:YES];
    [self reverseRow:1];

    [self reverseRow:2];
    BOOL row2_shifted = [self shiftRow:2];
    BOOL row2_merged = [self merge:2 doMerge:YES];
    [self reverseRow:2];

    [self reverseRow:3];
    BOOL row3_shifted = [self shiftRow:3];
    BOOL row3_merged = [self merge:3 doMerge:YES];
    [self reverseRow:3];
    
    if (row0_shifted || row0_merged || row1_shifted || row1_merged || row2_shifted || row2_merged || row3_shifted || row3_merged) {
        [self addTile:2];
        [self refreshBoard];
    }
    [self checkIfGameDone];
}

@end
