//
//  Copyright © nthState Ltd 2023. All rights reserved.
//

import SwiftUI

public extension View {
    
    /// Description
    /// - Parameters:
    ///   - sections: sections description
    ///   - offset: offset description
    ///   - enabled: enabled description
    ///   - debug: debug description
    ///   - fov: fov description
    ///   - cameraX: cameraX description
    ///   - cameraY: cameraY description
    ///   - cameraZ: cameraZ description
    ///   - near: near
    ///   - far: far
    /// - Returns: description
  func accordion(sections: UInt,
                 offset: CGPoint,
                 enabled: Bool = true,
                 debug: Bool = false,
                 fov: Float = 90,
                 cameraX: Float = 0,
                 cameraY: Float = 0,
                 cameraZ: Float = 0,
                 near: Float = 0,
                 far: Float = 0) -> some View {
    modifier(AccordionShader(view: self,
                             sections: sections,
                             offset: offset,
                             enabled: enabled,
                             debug: debug,
                             fov: fov,
                             cameraX: cameraX,
                             cameraY: cameraY,
                             cameraZ: cameraZ,
                             near: near,
                             far: far))
  }
  
}

public struct AccordionShader<V>: ViewModifier where V: View {
  
  private let view: V
  private let enabled: Bool
  private let debug: Bool
  private let distortionShader: Shader
  private let colorShader: Shader
  
  public init(view: V,
              sections: UInt,
              offset: CGPoint,
              enabled: Bool = true,
              debug: Bool,
              fov: Float,
              cameraX: Float,
              cameraY: Float,
              cameraZ: Float,
              near: Float,
              far: Float) {
    self.view = view
    self.enabled = enabled
    self.debug = debug
    
    let library: ShaderLibrary = .bundle(.module)

    let distortionShaderFunction = ShaderFunction(library: library, name: "accordionProjection")
    self.distortionShader = Shader(function: distortionShaderFunction, arguments: [
        .floatArray([Float(sections),
                     cameraX,
                     cameraY,
                     cameraZ,
                     Float(offset.x),
                     Float(offset.y.clamped(to: 0.0...1.0)),
                     fov,
                     near,
                     far]),
      .boundingRect,
    ])

      //print(self.distortionShader)

    let colorShaderFunction = ShaderFunction(library: library, name: "debug")
    self.colorShader = Shader(function: colorShaderFunction, arguments: [
      .floatArray([Float(sections),
                   cameraX,
                   cameraY,
                   cameraZ,
                   Float(offset.x),
                   Float(offset.y),
                   fov,
                   near,
                   far]),
      .boundingRect,
    ])
  }
  
  public func body(content: Content) -> some View {
    view
      .colorEffect(self.colorShader,isEnabled: debug)
      .distortionEffect(self.distortionShader, maxSampleOffset: .zero, isEnabled: enabled)
  }
  
}
