//
//  ModelLoader.h
//  OpenGL-Models
//
//  Created by Carson Roscoe on 2017-03-18.
//  Copyright © 2017 Jaegar Sarauer. All rights reserved.
//

#ifndef ModelLoader_h
#define ModelLoader_h

#import "Model.h"

@interface ModelLoader : NSObject {
@public
    NSMutableDictionary *Models;
    int currentModelID;
@protected
    NSMutableArray *rawModelFileContents;
    NSString *objDirectory;
}

-(id)init;
-(void)createModels;
-(NSString*)readDataFromFile:(NSString*)file;
-(Model*)getModel:(int)index;

@end

#endif /* ModelLoader_h */
