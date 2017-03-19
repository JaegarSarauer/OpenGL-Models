//
//  Model.h
//  OpenGL-Models
//
//  Created by Carson Roscoe on 2017-03-18.
//  Copyright © 2017 Jaegar Sarauer. All rights reserved.
//

#ifndef Model_h
#define Model_h

@interface Model : NSObject {
@public
    NSString *Identifier;
    NSMutableArray *vertices;
    NSMutableArray *vertexNormals;
    NSMutableArray *faces;
}
-(id)initWithIdentifier:(NSString*)identifier;
-(void)addVertices:(NSMutableArray*) verticesToAdd;
-(void)addVertex:(NSMutableArray*) vertex;
-(void)addVertexNormals:(NSMutableArray*) normals;
-(void)addVertexNormal:(NSMutableArray*) normal;
-(void)addFaces:(NSMutableArray*) face;
@end

#endif /* Model_h */
