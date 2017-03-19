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

static const float MOVE_PER_UPDATE = 0.05f;

@interface AIMovement : NSObject {
@public
    //refernce to current maze.
    MazeManager* maze;

    //current square we are at/moving to
    MazeSquare *currentSquare;

    //the rounded numbers of where the current (or moving to) maze square is
    float xSolidPos;
    float ySolidPos;

    //actual position of the object using the ai, for moving smoothly
    float xPos;
    float yPos;
}

//constructor
- (id)init:(MazeManager *)m;

//process movement (animation, call every update)
- (bool)move;

//move to the next square passed in
- (void)moveToSquare;

@end


#endif /* AIMovement_h */
