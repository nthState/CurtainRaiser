//
//  Adapted from https://www.shadertoy.com/user/mrboggieman
//

#include <metal_stdlib>
#include <SwiftUI/SwiftUI_Metal.h>
#include "Shared.metal"
using namespace metal;

[[ stitchable ]] half4 layerShader(float2 position,
                                   SwiftUI::Layer layer,
                                   device const float *data,
                                   int count,
                                   float4 viewPort) {


  // MARK: Convert data in array to properties

  const float sections = data[0];
  const float2 offset = float2(data[1], data[2]);
  const float maxShadow = data[3];
  const float pleatHeight = data[4];
  const float grabAmount = data[5];
  const float2 viewSize = float2(viewPort.z, viewPort.w);
  const float TWO_PI = 2 * M_PI_F;

  // MARK: Conversion

  float2 iMouse = float2(lerp(0, viewSize.x, offset.x),
                         lerp(0, viewSize.y, offset.y));

  float2 grabPos = iMouse / viewSize;

  float xNormalized = (position.x / viewSize.x) * 2.0 - 1.0;
  float yNormalized = 1.0 - (position.y / viewSize.y) * 2.0;

  float normalizedGrabPosX = (iMouse.x / viewSize.x) * 2.0 - 1.0;

  float2 uv = float2(xNormalized, yNormalized);

  // MARK: Main

  uv.y = (uv.y - grabPos.y) / (1.0 - grabPos.y);

  uv.y += abs(uv.x - normalizedGrabPosX) * (1.0 - uv.y) * grabAmount * grabPos.y;

  float pleatZ = (cos(uv.y * TWO_PI * sections) + 1.0) / 2.0;

  uv.x += pleatZ * pleatHeight * grabPos.y / viewSize.x;

  if (uv.x < -1.0 || uv.y < -1.0 || uv.x > 1.0 || uv.y > 1.0) {
    return half4(half3(0.0), 1.0);
  }

  float3 shadow = pleatZ * maxShadow * clamp(grabPos.y * 2.0, 0.0, 1.0);
  shadow = mix(shadow, float3(maxShadow), grabPos.y);

  float xPosition = ((uv.x + 1.0) / 2.0) * viewSize.x;
  float yPosition = ((1.0 - uv.y) / 2.0) * viewSize.y;
  uv = float2(xPosition, yPosition);

  half4 color = layer.sample(uv);
  color -= half4(shadow.x, shadow.y, shadow.z, 0.0);

  return color;
}
