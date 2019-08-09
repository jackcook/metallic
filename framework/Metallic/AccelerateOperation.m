//
//  AccelerateOperation.m
//  Metallic
//
//  Created by Jack Cook on 8/9/19.
//  Copyright © 2019 Jack Cook. All rights reserved.
//

#import "AccelerateOperation.h"

@implementation AccelerateOperation

- (float) computeSumWithArray:(MetalArray *)array {
    float result = 0;
    vDSP_sve(array.buffer.contents, (long) 1, &result, (unsigned long) array.length);
    return result;
}

@end
