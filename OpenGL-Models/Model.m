//
//  Model.m
//  OpenGL-Models
//
//  Created by Carson Roscoe on 2017-03-18.
//  Copyright © 2017 Jaegar Sarauer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Model.h"

@implementation Model : NSObject
-(id)initWithIdentifier:(NSString*)identifier {
    Identifier = identifier;
    vertices = [[NSMutableArray alloc] init];
    vertexNormals = [[NSMutableArray alloc] init];
    faces = [[NSMutableArray alloc] init];
    verticeIndices = [[NSMutableArray alloc] init];
    textureIndices = [[NSMutableArray alloc] init];
    vertexNormalIndices = [[NSMutableArray alloc] init];
    vertexTextures = [[NSMutableArray alloc] init];
    return self;
}

-(void)addVertices:(NSMutableArray*) verticesToAdd {
    for(id vertex in verticesToAdd) {
        if ([vertex isKindOfClass:[NSMutableArray class]]) {
            [self addVertex:vertex];
        } else {
            NSLog(@"Model->addVertices: Trying to add non-NSMutableArray");
        }
    }
}

-(void)addVertex:(NSMutableArray*) vertex {
    [vertices addObject:vertex];
}

-(void)addVertexNormals:(NSMutableArray*) normals {
    for(id normal in normals) {
        if ([normal isKindOfClass:[NSMutableArray class]]) {
            [self addVertexNormal:normal];
        } else {
            NSLog(@"Model->addVertexNormals: Trying to add non-NSMutableArray");
        }
    }
}

-(void)addVertexNormal:(NSMutableArray*) normal {
    [vertexNormals addObject:normal];
}

-(void)addFaces:(NSMutableArray*) face {
    [self->faces addObject:face];
}

-(void)addTextureVertex:(NSMutableArray*) vertex {
    [vertexTextures addObject:vertex];
}

-(void)addVertexIndice:(int) indice {
    NSNumber* index = [[NSNumber alloc] initWithInt:indice];
    [verticeIndices addObject:index];
}

-(void)addVertexNormalIndice:(int) indice {
    NSNumber* index = [[NSNumber alloc] initWithInt:indice];
    [vertexNormalIndices addObject:index];
}

-(void)addTextureIndice:(int) indice {
    NSNumber* index = [[NSNumber alloc] initWithInt:indice];
    [textureIndices addObject:index];
}

@end
