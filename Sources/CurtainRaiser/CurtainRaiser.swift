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
  func curtainRaiser(sections: Int,
                     maxShadow: Float,
                     pleatHeight: Float,
                     lift: Float,
                     offset: CGPoint,
                     enabled: Bool = true) -> some View {
    modifier(CurtainRaiser(view: self,
                           sections: sections,
                           maxShadow: maxShadow,
                           pleatHeight: pleatHeight,
                           lift: lift,
                           offset: offset,
                           enabled: enabled))
  }

}

public struct CurtainRaiser<V>: ViewModifier, Animatable where V: View {

  private let view: V
  private let enabled: Bool
  private let library: ShaderLibrary
  private var offset: CGPoint
  private let sections: Int
  @State private var sampleOffset: CGSize = .zero

  private let maxShadow: Float
  private let pleatHeight: Float
  private let lift: Float

  public var animatableData: AnimatablePair<CGFloat, CGFloat> {
    get { AnimatablePair(offset.x, offset.y) }
    set { offset = CGPoint(x: newValue.first, y: newValue.second) }
  }

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
