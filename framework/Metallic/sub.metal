//
//  sub.metal
//  Metallic
//
//  Created by Jack Cook on 8/8/19.
//  Copyright © 2019 Apple. All rights reserved.
//

#include <metal_stdlib>
using namespace metal;

kernel void sub_arrays(device const float* inA,
                       device float* inB,
                       device float* result,
                       uint index [[thread_position_in_grid]])
{
    result[index] = inA[index] - inB[index];
}
