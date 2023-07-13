//
//  Copyright © nthState Ltd 2023. All rights reserved.
//

#ifndef UTILS_METAL
#define UTILS_METAL

#include <metal_stdlib>
#include <SwiftUI/SwiftUI_Metal.h>
using namespace metal;

inline float lerp(float a, float b, float t) {
    return (1.0 - t) * a + t * b;
}

#endif
