//
//  Copyright © nthState Ltd 2023. All rights reserved.
//

import SwiftUI

public extension View {

  /// Description
  /// - Parameters:
  ///   - sections: sections description
  ///   - maxShadow: maxShadow description
  ///   - pleatHeight: pleatHeight description
  ///   - lift: lift description
  ///   - offset: offset description
  ///   - enabled: enabled description
  /// - Returns: description
  func accordion(sections: Int,
                 maxShadow: Float,
                 pleatHeight: Float,
                 lift: Float,
                 offset: CGPoint,
                 enabled: Bool = true) -> some View {
    modifier(AccordionShader(view: self,
                             sections: sections,
                             maxShadow: maxShadow,
                             pleatHeight: pleatHeight,
                             lift: lift,
                             offset: offset,
                             enabled: enabled))
  }

}

public struct AccordionShader<V>: ViewModifier where V: View {

  private let view: V
  private let enabled: Bool
  private let library: ShaderLibrary
  private let offset: CGPoint
  private let sections: Int
  @State private var sampleOffset: CGSize = .zero

  private let maxShadow: Float
  private let pleatHeight: Float
  private let lift: Float

  public init(view: V,
              sections: Int,
              maxShadow: Float,
              pleatHeight: Float,
              lift: Float,
              offset: CGPoint,
              enabled: Bool = true) {
    self.view = view
    self.enabled = enabled
    self.offset = offset
    self.sections = sections

    self.maxShadow = maxShadow
    self.pleatHeight = pleatHeight
    self.lift = lift

    library = .bundle(.module)
  }

  private var layerShader: Shader {
    let function = ShaderFunction(library: library, name: "layerShader")
    return Shader(function: function, arguments: [
      .floatArray([Float(sections),
                   Float(offset.x.clamped(to: 0.0...1.0)),
                   Float(offset.y.clamped(to: 0.0...1.0)),
                   maxShadow,
                   pleatHeight,
                   lift
                  ]),
      .boundingRect
    ])
  }

  public func body(content: Content) -> some View {
    ZStack(alignment: .bottomTrailing) {
      view
        .layerEffect(layerShader, maxSampleOffset: self.sampleOffset, isEnabled: enabled)
        .overlay(GeometryReader { geometry in
          Color.clear
            .preference(key: SizePreferenceKey.self, value: geometry.size)
        })
        .onPreferenceChange(SizePreferenceKey.self) { size in
          self.sampleOffset = size
        }
    }
  }

}

struct SizePreferenceKey: PreferenceKey {
  static var defaultValue: CGSize = .zero

  static func reduce(value: inout CGSize, nextValue: () -> CGSize) {
    value = CGSize(width: max(value.width, nextValue().width),
                   height: max(value.height, nextValue().height))
  }
}
