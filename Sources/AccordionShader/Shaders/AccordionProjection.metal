//
//  Copyright © nthState Ltd 2023. All rights reserved.
//

#include <metal_stdlib>
#include <SwiftUI/SwiftUI_Metal.h>
#include "Shared.metal"
using namespace metal;

// MARK: Helpers for View Projection

// Function to generate a projection matrix
float4x4 generateProjectionMatrix(float fov, float aspectRatio, float near, float far) {
  float yScale = 1.0 / tan(fov * 0.5);
  float xScale = yScale / aspectRatio;
  float zRange = near - far;

  float4x4 projectionMatrix;
  projectionMatrix.columns[0] = float4(xScale, 0.0, 0.0, 0.0);
  projectionMatrix.columns[1] = float4(0.0, -yScale, 0.0, 0.0);
  projectionMatrix.columns[2] = float4(0.0, 0.0, (near + far) / zRange, -1.0);
  projectionMatrix.columns[3] = float4(0.0, 0.0, (2.0 * near * far) / zRange, 0.0);

  return projectionMatrix;
}

float4x4 generateViewMatrix(float3 cameraPosition, float3 lookAt) {
  float3 eye = cameraPosition;
  float3 target = lookAt; // Assuming the target is at the origin
  float3 up = float3(0.0, 1.0, 0.0); // Up direction is positive Y-axis

  float3 zAxis = normalize(eye - target);
  float3 xAxis = normalize(cross(up, zAxis));
  float3 yAxis = cross(zAxis, xAxis);

  float4x4 viewMatrix;
  viewMatrix.columns[0] = float4(xAxis.x, yAxis.x, zAxis.x, 0.0);
  viewMatrix.columns[1] = float4(xAxis.y, yAxis.y, zAxis.y, 0.0);
  viewMatrix.columns[2] = float4(xAxis.z, yAxis.z, zAxis.z, 0.0);
  viewMatrix.columns[3] = float4(-dot(xAxis, eye), -dot(yAxis, eye), -dot(zAxis, eye), 1.0);

  return viewMatrix;
}

float4x4 rotateAroundXMatrix(float angle_radians) {
  return float4x4(
      float4(1.0, 0.0, 0.0, 0.0),
      float4(0.0, cos(angle_radians), sin(angle_radians), 0.0),
      float4(0.0, -sin(angle_radians), cos(angle_radians), 0.0),
      float4(0.0, 0.0, 0.0, 1.0)
  );
}

float4x4 translateTo(float4 position) {
    return float4x4(
        float4(1.0, 0.0, 0.0, 0.0),
        float4(0.0, 1.0, 0.0, 0.0),
        float4(0.0, 0.0, 1.0, 0.0),
        float4(-position.x, -position.y, -position.z, position.w)
    );
}

// MARK: Shader


/**

 Helpful links:
 https://stackoverflow.com/questions/724219/how-to-convert-a-3d-point-into-2d-perspective-projection
 */
[[ stitchable ]] float2 accordionProjection(float2 position,
                                            device const float *data,
                                            int count,
                                            float4 viewPort
                                            ) {

  const float maxAngle = 90.0;
  const float sections = data[0];
  const float3 cameraPosition = float3(data[1], data[2], data[3]);
  const float3 lookAt = float3(data[4], data[5], data[6]);
  const float2 offset = float2(data[7], data[8]);
  const float2 inverseOffset = float2(1.0-offset.x, 1.0-offset.y);
  const float2 viewSize = float2(viewPort.z, viewPort.w);
  const float aspectRatio = viewSize.x / viewSize.y;
  float angle_radians = degreesToRadians(maxAngle * offset.y);
  const float fov_radians = degreesToRadians(data[9]);
  const float nearPlane = data[10];
  const float farPlane = data[11];
  const float zPosition = 0;

  float totalHeight = viewPort.w; //getTotalHeight(viewPort, sections, float2(0.0,1.0));
  float sectionHeight = getSectionHeight(totalHeight, sections);
  Section section = getSection(position, viewPort, sectionHeight);

  float dynTotalHeight = getTotalHeight(viewPort, sections, inverseOffset.y);
  float dynSectionHeight = getSectionHeight(dynTotalHeight, sections);
  Section dynSection = getSection(position, viewPort, dynSectionHeight);

  float2 inPos = position - (viewSize * 0.5);
  float4 originalPosition = float4(inPos.xy, zPosition, 1.0);

  // The point at which all points rotate around, ie, the top of the texture
  //float rotateY = (section.direction == 0) ? section.top : section.bottom;
  float4 rotationPoint = float4(position.x, 0, zPosition, 1.0);
  rotationPoint.xy -= (viewSize * 0.5);

  if (section.direction == 0) {
    angle_radians = -angle_radians;
  }

  //float4 move = float4(0, (totalHeight * offset.y), 0, 1);

  // MARK: Matrices

  //const float3 cam = float3(0.0, 0, cameraPosition.z);
  //const float3 lookAt = float3(0.0, 00, 0.0);

  const float4x4 viewMatrix = generateViewMatrix(cameraPosition,
                                                 lookAt);

  const float4x4 projectionMatrix = generateProjectionMatrix(fov_radians,
                                                       aspectRatio,
                                                       nearPlane,
                                                       farPlane);

  // https://chat.openai.com/c/fb490ef2-2e4a-4896-8aa5-59a9dd62569d
  float4 clipSpacePosition = projectionMatrix
                              * viewMatrix
                              //* translateTo(move)
                              //* translateTo(-originalPosition)
                              * translateTo(-rotationPoint)
                              * rotateAroundXMatrix(angle_radians)
                              * translateTo(rotationPoint)
                              //* translateTo(originalPosition)
                              * originalPosition;

  // MARK: Convert to screen coordinates

  float4 ndcPosition = clipSpacePosition / clipSpacePosition.w;
  float2 screenPosition;
  screenPosition.x = (ndcPosition.x + 1.0) * (0.5 * viewSize.x);
  screenPosition.y = (1.0 - ndcPosition.y) * (0.5 * viewSize.y);

  return screenPosition;

}
