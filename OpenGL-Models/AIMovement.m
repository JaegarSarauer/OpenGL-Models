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
    mazeMaxBounds = GLKVector3Make(mazeWidth - 0.5, -0.5, mazeHeight - 0.5);
    direction = GLKVector3Make(MOVE_PER_UPDATE, 0, MOVE_PER_UPDATE);
    curPos = GLKVector3Make(0, 0, 0);
    [self setScaleFactor:1.0f];
    return self;
}

//process movement (animation, call every update)
- (void)move {
    if (curPos.x <= mazeMinBounds.x)
        [self swapDirection:LEFT];
    if (curPos.x >= mazeMaxBounds.x)
        [self swapDirection:RIGHT];
    if (curPos.z <= mazeMinBounds.z)
        [self swapDirection:UP];
    if (curPos.z >= mazeMaxBounds.z)
        [self swapDirection:DOWN];
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

-(void)setScaleFactor:(float)factor {
    minBounds = GLKVector3Make(-0.2f * factor, -0.2f * factor, -0.2f * factor);
    maxBounds = GLKVector3Make(0.2f * factor, 0.2f * factor, 0.2f * factor);
}

@end
