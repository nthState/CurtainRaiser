//
//  Copyright © nthState Ltd 2023. All rights reserved.
//

import SwiftUI
import Observation

@Observable
internal class ControlViewModel {
  var offset: CGPoint = CGPoint(x: 0.5, y: 0)
  var sections: Int = 10
  var maxShadow: Float = 0.1
  var pleatHeight: Float = 4.0
  var lift: Float = 0
  var enable: Bool = true

  internal init(offset: CGPoint = CGPoint(x: 0.5, y: 0), sections: Int = 10, maxShadow: Float = 0.1, pleatHeight: Float = 4.0, lift: Float = 0.5, enable: Bool = true) {
    self.offset = offset
    self.sections = sections
    self.maxShadow = maxShadow
    self.pleatHeight = pleatHeight
    self.lift = lift
    self.enable = enable
  }
}
