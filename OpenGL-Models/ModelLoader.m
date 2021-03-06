//
//  ModelLoader.m
//  OpenGL-Models
//
//  Created by Carson Roscoe on 2017-03-18.
//  Copyright © 2017 Jaegar Sarauer. All rights reserved.
//

#import <Foundation/Foundation.h>
#include "ModelLoader.h"

@implementation ModelLoader : NSObject 
    NSMutableDictionary *Models;
    int currentModelID;
    NSMutableArray *rawModelFileContents;
    NSString *objDirectory;

-(id)init {
    Models = [[NSMutableDictionary alloc] init];
    currentModelID = 1;
    rawModelFileContents = [[NSMutableArray alloc] init];
    objDirectory =  [NSString stringWithFormat:@"%@/%@", [[NSBundle mainBundle] bundlePath], @"/Models"];
    // Set the first model to be empty
    Model* newModel = [[Model alloc] initWithIdentifier:@"0"];
    [Models setObject:newModel forKey:@"0"];
    [self createModels];
    return self;
}

-(void)createModels {
    NSString* filePath = [[NSBundle mainBundle] pathForResource:@"numberedCube3" ofType:@"obj"];
    if (filePath != nil) {
        [rawModelFileContents addObject:[NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:NULL]];
    }
    int j = 1;
    for (NSString *rawModel in rawModelFileContents) {
        Model* newModel = [[Model alloc] initWithIdentifier:[NSString stringWithFormat:@"%d", currentModelID++]];
        for (NSString *line in [rawModel componentsSeparatedByString:@"\n"]) {
            // Get Vertices
            if ([line hasPrefix:@"v "]) {
                // Cut the 'v' out of the line of vertex data
                NSString *sanitizedLine = [line substringFromIndex:2];
                
                // Then break the vertex data up into three (or four) strings of floating point numbers (XYZ[W])
                NSArray<NSString*> *vertexComponentData = [sanitizedLine componentsSeparatedByString:@" "];
                
                NSMutableArray *vertex = [[NSMutableArray alloc] init];
                for (NSString* vertexComponent in vertexComponentData) {
                    [vertex addObject: [[NSNumber alloc] initWithFloat:[vertexComponent floatValue]]];
                }
                [newModel addVertex:vertex];
            }
            // Get Texture Coordinates
            if ([line hasPrefix:@"vt "]) {
                // Cut the 'vt ' out of the line of vertex data
                NSString *sanitizedLine = [line substringFromIndex:3];
                
                // Then break the vertex data up into three (or four) strings of floating point numbers (XYZ[W])
                NSArray<NSString*> *vertexTextureComponentData = [sanitizedLine componentsSeparatedByString:@" "];
                
                NSMutableArray *vertex = [[NSMutableArray alloc] init];
                for (NSString* vertexComponent in vertexTextureComponentData) {
                    [vertex addObject: [[NSNumber alloc] initWithFloat:[vertexComponent floatValue]]];
                }
                [newModel addTextureVertex:vertex];
            }
            // Get Vertex Normals
            if ([line hasPrefix:@"vn "])
            {
                // Cut the 'vn' out of the line of vertex data
                NSString *sanitizedLine = [line substringFromIndex:3];
                // Then break the vertex data up into three (or four) strings of floating point numbers (XYZ[W])
                NSArray<NSString*> *vertexNormalComponentData = [sanitizedLine componentsSeparatedByString:@" "];
                
                NSMutableArray *normal = [[NSMutableArray alloc] init];
                
                for (NSString* vertexNormalComponent in vertexNormalComponentData) {
                    [normal addObject: [[NSNumber alloc] initWithFloat:[vertexNormalComponent floatValue]]];
                }
                [newModel addVertexNormal:normal];
            }
            // Get Faces
            if ([line hasPrefix:@"f "]) //f 2/3/1 5/2/1 3/2/1
            {
                unsigned int vertexIndex[3], uvIndex[3], normalIndex[3];
                NSString *sanitizedLine = [line substringFromIndex:2]; //2/3/1 5/2/1 3/2/1
                sscanf([sanitizedLine UTF8String], "%d/%d/%d %d/%d/%d %d/%d/%d\n", &vertexIndex[0], &uvIndex[0], &normalIndex[0], &vertexIndex[1], &uvIndex[1], &normalIndex[1], &vertexIndex[2], &uvIndex[2], &normalIndex[2] );
                [newModel addVertexIndice:vertexIndex[0]];
                [newModel addVertexIndice:vertexIndex[1]];
                [newModel addVertexIndice:vertexIndex[2]];
                [newModel addTextureIndice:uvIndex[0]];
                [newModel addTextureIndice:uvIndex[1]];
                [newModel addTextureIndice:uvIndex[2]];
                [newModel addVertexNormalIndice:normalIndex[0]];
                [newModel addVertexNormalIndice:normalIndex[1]];
                [newModel addVertexNormalIndice:normalIndex[2]];
                
                /*NSString *sanitizedLine = [line substringFromIndex:2]; //2/3/1 5/2/1 3/2/1
                // Break the line into referenced points so each line looks like this '5/4/3' (vertex, texture vertex, vertex normal)
                // or like this "5//4" (vertex, vertex normal)
                NSArray<NSString*> *facePointTypes = [sanitizedLine componentsSeparatedByString:@" "]; //"2/3/1","5/2/1","3/2/1"
                NSMutableArray *face = [[NSMutableArray alloc] init];
                
                
                for (NSString* facePointType in facePointTypes) { //"2/3/1" in "2/3/1","5/2/1","3/2/1"
                    NSArray<NSString*> *facePoints = [facePointType componentsSeparatedByString:@"/"];//2,3,1
                    for (NSString* facePoint in facePoints) {
                        if ([facePoint  isEqual: @""]) {
                            continue;
                        }
                        
                        //NSMutableArray *facePointData = [[NSMutableArray alloc] init];
                        //NSArray<NSString*> *facePointVertices = [facePoint componentsSeparatedByString:@"/"];
                        
                        //for (NSString *facePointVertex in facePointVertices) {
                        //    [facePointData addObject:[[NSNumber alloc] initWithInt:[facePointVertex intValue]]];
                        //}
                        //[face addObject:facePointData];
                        [face addObject:[[NSNumber alloc] initWithInt:[facePoint intValue]]];
                    }
                    
                }*/
                //NSLog(@"Face: %d", j++);
                //[newModel addFaces:face];
            }
        }
        [Models setValue:newModel forKey:newModel->Identifier];
    }
}

-(Model*)getModel:(int)index {
    NSString* indexString = [NSString stringWithFormat:@"%d", index];
    Model* model = [Models objectForKey:indexString];
    return model;
}

@end
