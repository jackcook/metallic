//
//  MetalArray.h
//  Metallic
//
//  Created by Jack Cook on 8/8/19.
//  Copyright © 2019 Apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Metal/Metal.h>

@interface MetalArray : NSObject

@property id<MTLBuffer> buffer;
@property unsigned long length;

- (instancetype) initWithArray:(NSArray *) array;
- (instancetype) initWithBuffer:(id<MTLBuffer>) buffer length:(unsigned long) length;

- (float) itemAtIndex:(int) index;

@end
