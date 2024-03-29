//
//  MetalOperation.m
//  Metallic
//
//  Created by Jack Cook on 8/8/19.
//  Copyright © 2019 Apple. All rights reserved.
//

#import <Accelerate/Accelerate.h>
#import "MetalOperation.h"

@implementation MetalOperation {
    id<MTLDevice> _mDevice;
    
    // The compute pipeline generated from the compute kernel in the .metal shader file.
    id<MTLComputePipelineState> _mAddFunctionPSO;
    
    // The command queue used to pass commands to the device.
    id<MTLCommandQueue> _mCommandQueue;
    
    // Buffers to hold data.
    NSArray<id<MTLBuffer>> *_inputBuffers;
    id<MTLBuffer> _mBufferResult;
    
    unsigned long _arrayLength;
}

- (instancetype) initWithOperation:(NSString *) opName {
    self = [super init];
    
    if (self) {
        _mDevice = MTLCreateSystemDefaultDevice();
        
        if (_mDevice == NULL) {
            _mDevice = [MTLCopyAllDevices() objectAtIndex:0];
        }
        
        NSError* error = nil;
        
        // Load the shader files with a .metal file extension in the project
        NSURL *url = [[NSBundle bundleWithIdentifier:@"com.jackcook.Metallic"] URLForResource:@"default" withExtension:@"metallib"];
        id<MTLLibrary> defaultLibrary = [_mDevice newLibraryWithURL:url error:&error];
        
        if (defaultLibrary == nil) {
            NSLog(@"Failed to find the default library.");
            return nil;
        }
        
        id<MTLFunction> function = [defaultLibrary newFunctionWithName:opName];
        if (function == nil) {
            NSLog(@"Failed to find the %@ function.", opName);
            return nil;
        }
        
        // Create a compute pipeline state object.
        _mAddFunctionPSO = [_mDevice newComputePipelineStateWithFunction:function error:&error];
        if (_mAddFunctionPSO == nil) {
            //  If the Metal API validation is enabled, you can find out more information about what
            //  went wrong.  (Metal API validation is enabled by default when a debug build is run
            //  from Xcode)
            NSLog(@"Failed to created pipeline state object, error %@.", error);
            return nil;
        }
        
        _mCommandQueue = [_mDevice newCommandQueue];
        if (_mCommandQueue == nil) {
            NSLog(@"Failed to find the command queue.");
            return nil;
        }
    }
    
    return self;
}

- (MetalArray *) computeWithArrays:(NSArray *)arrays {
    id<MTLBuffer> metalArrayBuffers[arrays.count];
    
    for (int i = 0; i < arrays.count; i++) {
        metalArrayBuffers[i] = ((MetalArray *) arrays[i]).buffer;
    }
    
    NSArray *arr = [NSArray arrayWithObjects:metalArrayBuffers count:arrays.count];
    return [self computeWithBuffers:arr length:((MetalArray *) arrays[0]).length];
}

- (MetalArray *) computeWithBuffers:(NSArray *)buffers length:(unsigned long) length {
    _arrayLength = length;
    _inputBuffers = buffers;
    
    unsigned long bufferSize = _arrayLength * sizeof(float);
    _mBufferResult = [_mDevice newBufferWithLength:bufferSize options:MTLResourceStorageModeShared];
    
    // Create a command buffer to hold commands.
    id<MTLCommandBuffer> commandBuffer = [_mCommandQueue commandBuffer];
    assert(commandBuffer != nil);
    
    // Start a compute pass.
    id<MTLComputeCommandEncoder> computeEncoder = [commandBuffer computeCommandEncoder];
    assert(computeEncoder != nil);
    
    [self encodeAddCommand:computeEncoder];
    
    // End the compute pass.
    [computeEncoder endEncoding];
    
    // Execute the command.
    [commandBuffer commit];
    
    // Normally, you want to do other work in your app while the GPU is running,
    // but in this example, the code simply blocks until the calculation is complete.
    [commandBuffer waitUntilCompleted];
    
    return [[MetalArray alloc] initWithBuffer:_mBufferResult length:_arrayLength];
}

- (void)encodeAddCommand:(id<MTLComputeCommandEncoder>)computeEncoder {
    // Encode the pipeline state object and its parameters.
    [computeEncoder setComputePipelineState:_mAddFunctionPSO];
    
    for (int i = 0; i < _inputBuffers.count; i++) {
        [computeEncoder setBuffer:_inputBuffers[i] offset:0 atIndex:i];
    }
    
    [computeEncoder setBuffer:_mBufferResult offset:0 atIndex:_inputBuffers.count];
    
    MTLSize gridSize = MTLSizeMake(_arrayLength, 1, 1);
    
    // Calculate a threadgroup size.
    NSUInteger threadGroupSize = _mAddFunctionPSO.maxTotalThreadsPerThreadgroup;
    if (threadGroupSize > _arrayLength) {
        threadGroupSize = _arrayLength;
    }
    
    MTLSize threadgroupSize = MTLSizeMake(threadGroupSize, 1, 1);
    
    // Encode the compute command.
    [computeEncoder dispatchThreads:gridSize
              threadsPerThreadgroup:threadgroupSize];
}

@end
