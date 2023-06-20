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

float4x4 generateViewMatrix(float3 cameraPosition) {
  float3 eye = cameraPosition;
  float3 target = float3(0.0, 0.0, 0.0); // Assuming the target is at the origin
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

// MARK: Shader


[[ stitchable ]] float2 accordion(float2 position,
                                  device const float *data,
                                  int count,
                                  float4 viewPort
                                  ) {

  const float sections = data[0];
  const float3 cameraPosition = float3(data[1], data[2], data[3]);
  const float2 offset = float2(data[4], data[5]);
  const float2 viewSize = float2(viewPort.z, viewPort.w);
  const float aspectRatio = viewSize.x / viewSize.y;
   float angle_radians = degreesToRadians(data[6]);
  const float fov_radians = degreesToRadians(data[7]);



  float totalHeight = getTotalHeight(viewPort, sections, offset);
  float sectionHeight = getSectionHeight(totalHeight, sections);

  //    float sectionHeight = getSectionHeight(viewPort, sections);
  Section section = getSection(position, viewPort, sectionHeight);

  // Convert to center based co-ordinates
  //float2 centerCoordinates = position - (viewSize * 0.5);

  // Convert position to 3d space
  float3 position3D = float3(position, 0.0);

  // The point at which all points rotate around, ie, the top of the texture
  //float3 rotateAround = float3(position3D.x, 0.0, 0.0);
  float rotatePos = (section.direction == 0) ? section.top : section.bottom;
  float3 rotateAround = float3(position3D.x, rotatePos, 0.0);

  // Translation from center
  float3 translatedPosition = position3D - rotateAround;

  if (section.direction == 0) {
    angle_radians = -angle_radians;
  }

  // Rotation matrix
  float3x3 rotationMatrix = float3x3(
                                     1.0, 0.0, 0.0,
                                     0.0, cos(angle_radians), -sin(angle_radians),
                                     0.0, sin(angle_radians), cos(angle_radians)
                                     );

  // Apply rotation
  float3 rotatedPosition = rotationMatrix * translatedPosition;

  // Translate back to original position
  float3 finalPosition = rotatedPosition + rotateAround;

  // Center coordinates
  finalPosition = finalPosition - (float3(viewSize, 1.0) * 0.5);

  float4x4 viewMatrix = generateViewMatrix(cameraPosition);

  float nearPlane = 0.01;
  float farPlane = 10.0;

  float4x4 projectionMatrix = generateProjectionMatrix(fov_radians,
                                                       aspectRatio,
                                                       nearPlane,
                                                       farPlane);

  float4 clipSpacePosition = projectionMatrix * viewMatrix * float4(finalPosition, 1.0);

  float4 ndcPosition = clipSpacePosition / clipSpacePosition.w;

  float2 screenPosition;
  screenPosition.x = (ndcPosition.x + 1.0) * 0.5 * viewSize.x;
  screenPosition.y = (1.0 - ndcPosition.y) * 0.5 * viewSize.y;

  return screenPosition;

}
