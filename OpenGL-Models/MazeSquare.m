//
//  MazeSquare.m
//  OpenGL-Assign2
//
//  Created by Jaegar Sarauer on 2017-03-03.
//  Copyright © 2017 Jaegar Sarauer. All rights reserved.
//
#import "MazeSquare.h"


@implementation MazeSquare

- (id)init:(bool)r left:(bool)l up:(bool)u down:(bool)d x:(int)x z:(int)z
{
    self = [super init];
    self->left = l;
    self->up = u;
    self->right = r;
    self->down = d;
    self->floor = true;
    
    upTex = (TEXTURE_TYPE)NO_SIDES;
    downTex = (TEXTURE_TYPE)NO_SIDES;
    rightTex = (TEXTURE_TYPE)NO_SIDES;
    leftTex = (TEXTURE_TYPE)NO_SIDES;
    
    floorTex = (TEXTURE_TYPE)FLOOR_SIDE;
    
    if (l) {
        upTex++;
        downTex += 2;
    }
    if (r) {
        upTex += 2;
        downTex++;
    }
    if (u) {
        leftTex += 2;
        rightTex ++;
    }
    if (d) {
        leftTex ++;
        rightTex += 2;
    }
    
    collisionMin = collisionMax = GLKVector3Make(x, 0, z);
    
    
    return self;
}

- (bool)checkCollision:(SIDE)side minBox:(GLKVector3)minBox maxBox:(GLKVector3)maxBox {
    //GLKVector3 force = GLKVector3Make(0.0, 0.0, 0.0);
    GLKVector3 newMin = collisionMin;
    GLKVector3 newMax = collisionMax;
    
    switch(side) {
        case (SIDE)RIGHT:
            if (!right)
                return false;
            newMin = GLKVector3Make(newMin.x + 0.4, newMin.y - 0.5, newMin.z - 0.5);
            newMax = GLKVector3Make(newMax.x + 0.5, newMax.y + 0.5, newMax.z + 0.5);
            break;
        case (SIDE)DOWN:
            if (!down)
                return false;
            newMin = GLKVector3Make(newMin.x - 0.5, newMin.y - 0.5, newMin.z + 0.4);
            newMax = GLKVector3Make(newMax.x + 0.5, newMax.y + 0.5, newMax.z + 0.5);
            break;
        case (SIDE)LEFT:
            if (!left)
                return false;
            newMin = GLKVector3Make(newMin.x - 0.5, newMax.y - 0.5, newMin.z - 0.5);
            newMax = GLKVector3Make(newMax.x - 0.4, newMax.y + 0.5, newMax.z + 0.5);
            break;
        case (SIDE)UP:
            if (!up)
                return false;
            newMin = GLKVector3Make(newMin.x - 0.5, newMin.y - 0.5, newMin.z - 0.5);
            newMax = GLKVector3Make(newMax.x + 0.5, newMax.y + 0.5, newMax.z - 0.4);
            break;
        default:
            return false;
    }
    
    return [self inBounds:side objMin:newMin objMax:newMax otherMin:minBox otherMax:maxBox];
}

- (bool)inBounds:(SIDE)side objMin:(GLKVector3)objMin objMax:(GLKVector3)objMax otherMin:(GLKVector3)otherMin otherMax:(GLKVector3)otherMax {
    //not in
    bool res = !(otherMax.x < objMin.x || otherMin.x > objMax.x || otherMax.z < objMin.z || otherMin.z > objMax.z);
    return res;
    /*switch(side) {
        case (SIDE)RIGHT:
            if (!right)
                return false;
            return otherMax.x >= objMin.x;
            break;
        case (SIDE)UP:
            if (!up)
                return false;
            return otherMax.z >= objMin.z;
            break;
        case (SIDE)LEFT:
            if (!left)
                return false;
            return otherMin.x <= objMax.x;
            break;
        case (SIDE)DOWN:
            if (!down)
                return false;
            return otherMin.z <= objMax.z;
            break;
        default:
            return false;
    }*/
}

/*- (GLKMatrix4)getVerteciesOfSide:(enum SIDE)side {
    switch(side) {
        case LEFT:
        case RIGHT:
        case UP:
        case DOWN:
            if (down)
                return downVertecies;
            else return ;
    }
}*/

@end
