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

- (id)init:(int)mazeWidth mazeHeight:(int)mazeHeight {
    srand((uint)time(NULL));
    mazeMinBounds = GLKVector3Make(-0.5, -0.5, -0.5);
    mazeMaxBounds = GLKVector3Make(mazeWidth + 0.5, 0.5, mazeHeight + 0.5);
    direction = GLKVector3Make(MOVE_PER_UPDATE, 0, MOVE_PER_UPDATE);
    curPos = GLKVector3Make(0, 0, 0);
    minBounds = GLKVector3Make(-0.2, -0.2, -0.2);
    maxBounds = GLKVector3Make(0.2, 0.2, 0.2);
    
    return self;
}

//process movement (animation, call every update)
- (void)move {
    curPos = GLKVector3Add(curPos, direction);
}

- (GLKVector3)getMinBounds {
    return GLKVector3Add(curPos, minBounds);
}

- (GLKVector3)getMaxBounds {
    return GLKVector3Add(curPos, maxBounds);
}

- (void)swapDirection:(SIDE)side {
    switch(side) {
            case (SIDE)LEFT:
                direction.x = fabs(direction.x);
            break;
            case (SIDE)RIGHT:
                direction.x = -fabs(direction.x);
            break;
            case (SIDE)DOWN:
                direction.z = -fabs(direction.z);
            break;
            case (SIDE)UP:
                direction.z = fabs(direction.z);
            break;
            default:
            break;
    }
}

@end
