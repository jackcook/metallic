//
//  AccelerateOperation.h
//  Metallic
//
//  Created by Jack Cook on 8/9/19.
//  Copyright © 2019 Jack Cook. All rights reserved.
//

#import <Accelerate/Accelerate.h>

#import "MetalArray.h"

@interface AccelerateOperation : NSObject

- (float) computeSumWithArray:(MetalArray *)array;

@end
