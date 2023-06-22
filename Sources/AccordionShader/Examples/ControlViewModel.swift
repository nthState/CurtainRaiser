//
//  Copyright © nthState Ltd 2023. All rights reserved.
//

import SwiftUI

class ControlViewModel: ObservableObject {

    @Published var cameraX: Float = 0
    @Published var cameraY: Float = 0
    @Published var cameraZ: Float = 0
    @Published var fov: Float = 90.0

    @Published var near: Float = 0.01
    @Published var far: Float = 1000.0

    @Published var sections: Double = 10
    @Published var yOffset: CGFloat = 0
    @Published var debug: Bool = true
    @Published var enable: Bool = true
}
