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

- (instancetype) init;
- (MetalArray *) generateRandom:(unsigned long) size;
- (MetalArray *) generateRandomNormal:(unsigned long) size;
- (MetalArray *) generateRandomIntegers:(int) low high:(int) high size:(unsigned long) size;
- (MetalArray *) generateRandomIntegers:(int)low high:(int)high size:(unsigned long)size replacement:(bool) replacement;

@end
