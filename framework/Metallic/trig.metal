//
//  trig.metal
//  Metallic
//
//  Created by Jack Cook on 8/8/19.
//  Copyright © 2019 Jack Cook. All rights reserved.
//

#include <metal_stdlib>
using namespace metal;

#define M_E 2.71828182845904523536
#define M_PI 3.14159265358979323846

kernel void sin_array(device const float* inA,
                      device float* result,
                      uint index [[thread_position_in_grid]])
{
    result[index] = sin(inA[index]);
}

kernel void cos_array(device const float* inA,
                      device float* result,
                      uint index [[thread_position_in_grid]])
{
    result[index] = cos(inA[index]);
}

kernel void tan_array(device const float* inA,
                      device float* result,
                      uint index [[thread_position_in_grid]])
{
    result[index] = tan(inA[index]);
}

kernel void arcsin_array(device const float* inA,
                         device float* result,
                         uint index [[thread_position_in_grid]])
{
    result[index] = asin(inA[index]);
}

kernel void arccos_array(device const float* inA,
                         device float* result,
                         uint index [[thread_position_in_grid]])
{
    result[index] = acos(inA[index]);
}

kernel void arctan_array(device const float* inA,
                         device float* result,
                         uint index [[thread_position_in_grid]])
{
    result[index] = atan(inA[index]);
}

kernel void hypot_arrays(device const float* inA,
                         device const float* inB,
                         device float* result,
                         uint index [[thread_position_in_grid]])
{
    result[index] = sqrt(inA[index] * inA[index] + inB[index] * inB[index]);
}

kernel void arctan2_arrays(device const float* inA,
                           device const float* inB,
                           device float* result,
                           uint index [[thread_position_in_grid]])
{
    result[index] = atan2(inA[index], inB[index]);
}

kernel void degrees_array(device const float* inA,
                          device float* result,
                          uint index [[thread_position_in_grid]])
{
    result[index] = inA[index] * 180 / M_PI;
}

kernel void radians_array(device const float* inA,
                          device float* result,
                          uint index [[thread_position_in_grid]])
{
    result[index] = inA[index] * M_PI / 180;
}
