//
//  Copyright © nthState Ltd 2023. All rights reserved.
//

#ifndef UTILS_METAL
#define UTILS_METAL

#include <metal_stdlib>
#include <SwiftUI/SwiftUI_Metal.h>
using namespace metal;

struct Section {
  float index;     // Section identifier
  float top;
  float bottom;
  int direction; // Are we rotating in or out?
};

inline float degreesToRadians(float degrees) {
  return degrees * (M_PI_F / 180.0);
}

inline float getTotalHeight(float4 viewPort, float sections, float2 offset) {
  return floor(viewPort.w * offset.y);
}

inline float getSectionHeight(float height, float sections) {
  return floor(height / sections);
}

inline Section getSection(float2 position, float4 viewPort, float sectionHeight) {
    float sectionIndex = floor(position.y / sectionHeight);

    float base = floor(sectionIndex * sectionHeight);

    Section section;
    section.index = sectionIndex;
    section.top = base;
    section.bottom = base + sectionHeight;
    section.direction = int(sectionIndex) % 2;

    return section;
}

#endif
