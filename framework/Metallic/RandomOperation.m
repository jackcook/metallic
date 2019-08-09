//
//  RandomOperation.m
//  Metallic
//
//  Created by Jack Cook on 8/9/19.
//  Copyright © 2019 Jack Cook. All rights reserved.
//

#import "RandomOperation.h"

@implementation RandomOperation

- (MetalArray *) generateRandom:(unsigned long) size {
    id<MTLDevice> device = MTLCreateSystemDefaultDevice();
    
    unsigned long bufferSize = size * sizeof(float);
    id<MTLBuffer> buffer = [device newBufferWithLength:bufferSize options:MTLResourceStorageModeShared];
    float *dataPtr = buffer.contents;
    
    for (unsigned long index = 0; index < size; index++) {
        dataPtr[index] = (float) rand() / (float) RAND_MAX;
    }
    
    return [[MetalArray alloc] initWithBuffer:buffer length:size];
}

@end
