//
//  Copyright © nthState Ltd 2023. All rights reserved.
//

import SwiftUI

class ControlViewModel: ObservableObject {
  @Published var sections: Double = 3
  @Published var offset: CGPoint = .zero
  @Published var enable: Bool = true
  @Published var showDebugButton: Bool = true
  @Published var checkerBoardSize: Double = 4
}
