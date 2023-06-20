//
//  Copyright © nthState Ltd 2023. All rights reserved.
//

import SwiftUI

struct ExampleGestureView {
    @StateObject var control = ControlViewModel()
}

extension ExampleGestureView: View {

    var body: some View {
        VStack {

            ZStack {
                backgroundView
                foregroundView
            }
            
            ControlsView(control: control)
        }
    }

    private var foregroundView: some View {
        //GeometryReader { proxy in
            VStack {
                Text("Some text")
                    .font(.title)
                Image(systemName: "gear")
            }
            .padding()
            .background(
                    LinearGradient(gradient: Gradient(colors: [.green, .orange]), startPoint: .top, endPoint: .bottom)
                )
//            .gesture(
//                DragGesture()
//                    .onChanged { gesture in
//                        control.yOffset = gesture.translation.height / proxy.size.height
//                    }
//                    .onEnded { gesture in
//                        control.yOffset = 0
//                    }
//            )
            .accordion(sections: UInt(control.sections), offset: .init(x: 0, y: control.yOffset), enabled: control.enable, debug: control.debug, angle: control.angle, fov: control.fov, cameraX: control.cameraX, cameraY: control.cameraY, cameraZ: control.cameraZ)
       // }
    }

    private var backgroundView: some View {
        VStack {

        }
        .frame(width: 300, height: 300)
        .background(Color.purple)
    }
}

#if DEBUG
#Preview("Example Gesture View") {
    ExampleGestureView()
}
#endif
