//
//  Copyright © nthState Ltd 2023. All rights reserved.
//

import SwiftUI

class DebugModel: ObservableObject {

  @Published var enableLinesShader: Bool = false

  @Published var cameraX: Float = 0
  @Published var cameraY: Float = 0
  @Published var cameraZ: Float = 150
  @Published var fov: Float = 90.0

  @Published var near: Float = 0.01
  @Published var far: Float = 1000.0
}
