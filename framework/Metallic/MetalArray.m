//
//  MetalArray.m
//  Metallic
//
//  Created by Jack Cook on 8/8/19.
//  Copyright © 2019 Apple. All rights reserved.
//

#import "MetalArray.h"

@implementation MetalArray {
    NSArray *_array;
    unsigned long _bufferSize;
}

- (instancetype) initWithArray:(NSArray *) array {
    self = [super init];
    
    _array = array;
    self.length = array.count;
    _bufferSize = self.length * sizeof(float);
    
    id<MTLDevice> device = MTLCreateSystemDefaultDevice();
    
    self.buffer = [device newBufferWithLength:_bufferSize options:MTLResourceStorageModeShared];
    
    float *ptr = self.buffer.contents;
    
    for (unsigned long index = 0; index < self.length; index++) {
        ptr[index] = [array[index] floatValue];
    }
    
    return self;
}

- (instancetype) initWithBuffer:(id<MTLBuffer>) buffer length:(unsigned long) length {
    self = [super init];
    
    self.buffer = buffer;
    self.length = length;
    
    return self;
}

- (float)itemAtIndex:(int)index {
    float *ptr = self.buffer.contents;
    return ptr[index];
}

@end
