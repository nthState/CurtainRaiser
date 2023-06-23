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
  ///   - showDebugButton: debug description
  /// - Returns: description
  func accordion(sections: UInt,
                 offset: CGPoint,
                 enabled: Bool = true,
                 showDebugButton: Bool = false) -> some View {
    modifier(AccordionShader(view: self,
                             sections: sections,
                             offset: offset,
                             enabled: enabled,
                             showDebugButton: showDebugButton))
  }

}

public struct AccordionShader<V>: ViewModifier where V: View {

  private let view: V
  private let enabled: Bool
  private let showDebugButton: Bool
  private let library: ShaderLibrary
  private let offset: CGPoint
  private let sections: UInt

  @StateObject var debugModel = DebugModel()
  @State var showDebugInspector: Bool = false

  @State var cameraZ: Float = 150

  public init(view: V,
              sections: UInt,
              offset: CGPoint,
              enabled: Bool = true,
              showDebugButton: Bool = false) {
    self.view = view
    self.enabled = enabled
    self.showDebugButton = showDebugButton
    self.offset = offset
    self.sections = sections

    library = .bundle(.module)
  }

  private var distortionShader: Shader {
    let distortionShaderFunction = ShaderFunction(library: library, name: "accordionProjection")
    return Shader(function: distortionShaderFunction, arguments: [
      .floatArray([Float(sections),
                   debugModel.cameraX,
                   debugModel.cameraY,
                   cameraZ,
                   Float(offset.x),
                   Float(offset.y.clamped(to: 0.0...1.0)),
                   debugModel.fov,
                   debugModel.near,
                   debugModel.far]),
      .boundingRect
    ])
  }

  private var colorShader: Shader {
    let colorShaderFunction = ShaderFunction(library: library, name: "debug")
    return Shader(function: colorShaderFunction, arguments: [
      .floatArray([Float(sections),
                   debugModel.cameraX,
                   debugModel.cameraY,
                   cameraZ,
                   Float(offset.x),
                   Float(offset.y),
                   debugModel.fov,
                   debugModel.near,
                   debugModel.far]),
      .boundingRect
    ])
  }

  public func body(content: Content) -> some View {
    ZStack(alignment: .bottomTrailing) {
      view
        .colorEffect(colorShader, isEnabled: debugModel.enableLinesShader)
        .distortionEffect(distortionShader, maxSampleOffset: .zero, isEnabled: enabled)
        .inspector(isPresented: $showDebugInspector) {
          inspectorView
            .presentationBackground(.thinMaterial)
        }

      if showDebugButton {
        debugButtonView
      }
    }
    .border(Color.black, width: 1)
  }

  private var debugButtonView: some View {
    Button(action: {
      showDebugInspector.toggle()
    }, label: {
      Text("show.debug", bundle: .module)
        .font(.subheadline.monospaced())
    })
    .padding()
  }

  private var inspectorView: some View {
    DebugView()
      .environmentObject(debugModel)
  }

}
