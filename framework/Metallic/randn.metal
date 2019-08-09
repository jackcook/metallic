//
//  randn.metal
//  Metallic
//
//  Created by Jack Cook on 8/9/19.
//  Copyright © 2019 Jack Cook. All rights reserved.
//

#include <metal_stdlib>
using namespace metal;

#define M_PI 3.14159265358979323846

kernel void randn_array(device const float* inA,
                        device float* inB,
                        device float* result,
                        uint index [[thread_position_in_grid]])
{
    result[index] = sqrt(-2 * log(inA[index])) * cos(2 * M_PI * inB[index]);
}
