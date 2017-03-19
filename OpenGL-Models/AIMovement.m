//
//  AIMovement.m
//  OpenGL-Models
//
//  Created by Jaegar Sarauer on 2017-03-19.
//  Copyright © 2017 Jaegar Sarauer. All rights reserved.
//

#import "AIMovement.h"
#include <stdlib.h>

@implementation AIMovement

- (id)init:(MazeManager *)m {
    srand((uint)time(NULL));
    maze = m;
    xSolidPos = 0;
    ySolidPos = 0;
    xPos = 0;
    yPos = 0;
    currentSquare = [maze getMazePosition:xPos y:yPos];
    
    return self;
}

//process movement (animation, call every update)
//return true if it has calculated a new spot to move to
- (bool)move {
    bool onX = false;
    if (xPos > xSolidPos + MOVE_PER_UPDATE) {
        xPos -= MOVE_PER_UPDATE;
    } else if (xPos < xSolidPos - MOVE_PER_UPDATE) {
        xPos += MOVE_PER_UPDATE;
    } else {
        onX = true;
    }
    
    if (yPos > ySolidPos + MOVE_PER_UPDATE) {
        yPos -= MOVE_PER_UPDATE;
    } else if (yPos < ySolidPos - MOVE_PER_UPDATE) {
        yPos += MOVE_PER_UPDATE;
    } else if (onX) {//find a new spot to move to, if on both x and y
        [self moveToSquare];
        return true;
    }
    return false;
}

//move to the next square passed in
- (void)moveToSquare {
    int sides = 0;
    
    if (!currentSquare->left)
        sides++;
    if (!currentSquare->right)
        sides++;
    if (!currentSquare->up)
        sides++;
    if (!currentSquare->down)
        sides++;
    
    int ran = rand() % sides;
    sides = 0;
    
    
    
    if (!currentSquare->left) {
        if (ran == sides) {
            if ([maze isInBounds:xSolidPos - 1 y:ySolidPos]) {
                xSolidPos -= 1;
                currentSquare = [maze getMazePosition:xSolidPos y:ySolidPos];
                return;
            }
        } else {
            sides++;
        }
    }
    if (!currentSquare->right) {
        if (ran == sides) {
            if ([maze isInBounds:xSolidPos + 1 y:ySolidPos]) {
                xSolidPos += 1;
                currentSquare = [maze getMazePosition:xSolidPos y:ySolidPos];
                return;
            }
        } else {
            sides++;
        }
    }
    if (!currentSquare->up) {
        if (ran == sides) {
            if ([maze isInBounds:xSolidPos y:ySolidPos + 1]) {
                ySolidPos += 1;
                currentSquare = [maze getMazePosition:xSolidPos y:ySolidPos];
                return;
            }
        } else {
            sides++;
        }
    }
    if (!currentSquare->down) {
        if (ran == sides) {
            if ([maze isInBounds:xSolidPos y:ySolidPos - 1]) {
                ySolidPos -= 1;
                currentSquare = [maze getMazePosition:xSolidPos y:ySolidPos];
                return;
            }
        }
    }
}

@end
