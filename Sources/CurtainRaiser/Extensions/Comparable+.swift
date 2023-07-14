//
//  Copyright © nthState Ltd 2023. All rights reserved.
//

import Foundation

internal extension Comparable {
  func clamped(to limits: ClosedRange<Self>) -> Self {
    return min(max(self, limits.lowerBound), limits.upperBound)
  }
}
