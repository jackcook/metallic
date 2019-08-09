//
//  MetalOperation.h
//  Metallic
//
//  Created by Jack Cook on 8/8/19.
//  Copyright © 2019 Apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Metal/Metal.h>

#import "MetalArray.h"

@interface MetalOperation : NSObject

- (instancetype) initWithOperation:(NSString *) opName;
- (MetalArray *) computeWithArrays:(NSArray *)arrays;
- (MetalArray *) computeWithBuffers:(NSArray *)buffers length:(unsigned long) length;


@end
