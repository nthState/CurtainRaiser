//
//  Copyright © nthState Ltd 2023. All rights reserved.
//

#include <metal_stdlib>
#include <SwiftUI/SwiftUI_Metal.h>
#include "Shared.metal"
using namespace metal;

//constant half4 DEBUG_TOP        = half4(0.0, 1.0, 0.0, 1.0);
//constant half4 DEBUG_BOTTOM     = half4(1.0, 0.0, 0.0, 1.0);
//constant half4 DEBUG_BASELINE   = half4(1.0, 1.0, 0.0, 1.0);
constant half4 DEBUG_OFFSET     = half4(0.0, 0.0, 1.0, 1.0);

[[ stitchable ]] half4 debug(float2 position,
                             half4 color,
                             device const float *data,
                             int count,
                             float4 viewPort) {
  
  //[Float(sections), cameraX, cameraY, cameraZ, Float(offset.x), Float(offset.y), angle, fov])
  const float sections = data[0];
  const float2 offset = float2(data[4], data[5]);
  
  //Section section = getSection(position, viewPort, sections, offset);
  float totalHeight = getTotalHeight(viewPort, sections, offset);
  float sectionHeight = getSectionHeight(totalHeight, sections);
  
  // Set the default output colour to the same as the input
  half4 out = color;
  
  // Bottom rows
  //    int value = int(floor(section.bottom));
  //    bool valid = int(floor(position.y)) == value;
  //    if (valid) {
  //        out = DEBUG_BOTTOM;
  //    }
  //
  //    // Random X column
  //    if (int(floor(position.x)) == 90) {
  //        out = DEBUG_TOP;
  //    }
  //
  //    // Baselines of sections
  //    float baselineY = baselineOffset(section, offset);
  //    if (int(floor(position.y)) == int(floor(baselineY))) {
  //        out = DEBUG_BASELINE;
  //    }
  
  // Collapsing
  //    float collapsingHeight = floor(viewPort.w * offset.y);
  //    float newSectionHeight = floor(collapsingHeight / sections);
  if ((int(position.y) % int(sectionHeight) == 0) &&
      int(position.y) < int(totalHeight)) {
    out = DEBUG_OFFSET;
  }
  
  return out;
}
