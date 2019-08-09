//
//  RandomOperation.h
//  Metallic
//
//  Created by Jack Cook on 8/9/19.
//  Copyright © 2019 Jack Cook. All rights reserved.
//

#import <Metal/Metal.h>

#import "MetalArray.h"

@interface RandomOperation : NSObject

- (MetalArray *) generateRandom:(unsigned long) size;

@end
