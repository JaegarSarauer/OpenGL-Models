//
//  AIMovement.h
//  OpenGL-Models
//
//  Created by Jaegar Sarauer on 2017-03-19.
//  Copyright © 2017 Jaegar Sarauer. All rights reserved.
//

#ifndef AIMovement_h
#define AIMovement_h

#import "MazeSquare.h"
#import "MazeManager.h"

static const float MOVE_PER_UPDATE = 0.01f;

@interface AIMovement : NSObject {
@public
    //direction vector, where to move on each step
    GLKVector3 direction;
    
    //actual position of the object using the ai, for moving smoothly
    GLKVector3 curPos;
    
    //maze min and max bounds, so the model doesnt leave the world.
    GLKVector3 mazeMinBounds;
    GLKVector3 mazeMaxBounds;
    
@private
    //collision box of this model
    GLKVector3 minBounds;
    GLKVector3 maxBounds;
}

//constructor
- (id)init:(int)mazeWidth mazeHeight:(int)mazeHeight;

//process movement (animation, call every update)
- (void)move;

- (GLKVector3)getMinBounds;

- (GLKVector3)getMaxBounds;

//moves the opposite way after a collision
- (void)swapDirection:(SIDE)side;

-(void)setScaleFactor:(float)factor;

@end


#endif /* AIMovement_h */
