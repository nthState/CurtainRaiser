//
//  Copyright © nthState Ltd 2023. All rights reserved.
//

import SwiftUI

struct ExampleView {
    @StateObject var control = ControlViewModel()
}

extension ExampleView: View {

    public var body: some View {
        VStack {

            ZStack {
                backgroundView
                foregroundView
                    .accordion(sections: UInt(control.sections), offset: .init(x: 0, y: control.yOffset), enabled: control.enable, debug: control.debug, angle: control.angle, fov: control.fov, cameraX: control.cameraX, cameraY: control.cameraY, cameraZ: control.cameraZ)
            }

            ControlsView(control: control)
        }
    }

    private var foregroundView: some View {
        VStack {
            Text("Hello")
            Text("World")
        }
        .frame(width: 300, height: 300)
        .background(
            LinearGradient(gradient: Gradient(colors: [.green, .orange]), startPoint: .top, endPoint: .bottom)
        )
    }

    private var backgroundView: some View {
        VStack {

        }
        .frame(width: 300, height: 300)
        .background(Color.purple)
    }

}

#if DEBUG
#Preview("Example view") {
    ExampleView()
}
#endif
