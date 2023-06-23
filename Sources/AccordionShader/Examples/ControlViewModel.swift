//
//  Copyright © nthState Ltd 2023. All rights reserved.
//

import SwiftUI

class ControlViewModel: ObservableObject {
  @Published var sections: Double = 10
  @Published var yOffset: CGFloat = 0
  @Published var enable: Bool = true
  @Published var showDebugButton: Bool = true
}
