//
//  RandomOperation.m
//  Metallic
//
//  Created by Jack Cook on 8/9/19.
//  Copyright © 2019 Jack Cook. All rights reserved.
//

#import "MetalOperation.h"
#import "RandomOperation.h"

@implementation RandomOperation {
    id<MTLDevice> _device;
}

- (instancetype)init {
    self = [super init];
    
    if (self) {
        _device = MTLCreateSystemDefaultDevice();
        
        srand(arc4random());
    }
    
    return self;
}

- (MetalArray *) generateRandom:(unsigned long) size {
    unsigned long bufferSize = size * sizeof(float);
    id<MTLBuffer> buffer = [_device newBufferWithLength:bufferSize options:MTLResourceStorageModeShared];
    float *dataPtr = buffer.contents;
    
    for (unsigned long index = 0; index < size; index++) {
        dataPtr[index] = (float) rand() / (float) RAND_MAX;
    }
    
    return [[MetalArray alloc] initWithBuffer:buffer length:size];
}

- (MetalArray *) generateRandomNormal:(unsigned long) size {
    unsigned long bufferSize = size * sizeof(float);
    id<MTLBuffer> uBuffer = [_device newBufferWithLength:bufferSize options:MTLResourceStorageModeShared];
    float *uDataPtr = uBuffer.contents;
    
    id<MTLBuffer> vBuffer = [_device newBufferWithLength:bufferSize options:MTLResourceStorageModeShared];
    float *vDataPtr = vBuffer.contents;
    
    for (unsigned long index = 0; index < size; index++) {
        uDataPtr[index] = (float) rand() / (float) RAND_MAX;
        vDataPtr[index] = (float) rand() / (float) RAND_MAX;
    }
    
    MetalOperation *op = [[MetalOperation alloc] initWithOperation:@"randn_array"];
    NSArray *args = [[NSArray alloc] initWithObjects:uBuffer, vBuffer, nil];
    return [op computeWithBuffers:args length:size];
}

- (MetalArray *) generateRandomIntegers:(int) low high:(int) high size:(unsigned long) size {
    return [self generateRandomIntegers:low high:high size:size replacement:true];
}

- (MetalArray *) generateRandomIntegers:(int)low high:(int)high size:(unsigned long)size replacement:(bool) replacement {
    unsigned long bufferSize = size * sizeof(float);
    id<MTLBuffer> buffer = [_device newBufferWithLength:bufferSize options:MTLResourceStorageModeShared];
    float *dataPtr = buffer.contents;
    
    if (replacement) {
        for (unsigned long index = 0; index < size; index++) {
            dataPtr[index] = (int) (((float) rand() / (float) RAND_MAX) * (float) (high - low)) + low;
        }
        
        return [[MetalArray alloc] initWithBuffer:buffer length:size];
    } else {
        int j = 0;
        NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
        NSNumber *lower;
        
        for (int z = 0; z < size; z++) {
            NSNumber *i = [NSNumber numberWithInt:(int) (((float) rand() / (float) RAND_MAX) * (float) (high - low)) + low];
            lower = [NSNumber numberWithInt:low];
            
            if ([dict objectForKey:i] == nil) {
                [dict setObject:i forKey:i];
            }
            
            NSNumber *x = [dict objectForKey:i];
            
            if ([dict objectForKey:lower] == nil) {
                [dict setObject:lower forKey:lower];
            }
            
            [dict setObject:[dict objectForKey:lower] forKey:i];
            low += 1;
            dataPtr[j++] = [x intValue];
        }
        
        return [[MetalArray alloc] initWithBuffer:buffer length:size];
    }
}

@end
