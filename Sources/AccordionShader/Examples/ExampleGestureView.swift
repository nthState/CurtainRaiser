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

      ZStack(alignment: .center) {
        backgroundView
        GeometryReader { proxy in
          foregroundView
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .gesture(
              DragGesture()
                .onChanged { gesture in
                  control.yOffset = -(gesture.translation.height / proxy.size.height)
                }
                .onEnded { _ in
                  withAnimation(.spring()) {
                    control.yOffset = 0
                  }
                }
            )
            .accordion(sections: UInt(control.sections),
                       offset: .init(x: 0, y: control.yOffset),
                       enabled: control.enable,
                       showDebugButton: control.showDebugButton
                       )
        }
      }

      ControlsView(control: control)
    }
  }

  private var foregroundView: some View {
    ZStack {
      Text("Hello")
        .font(.headline)
    }
    .frame(width: 300, height: 300)
    .background(
      LinearGradient(gradient: Gradient(colors: [.green, .orange]), startPoint: .top, endPoint: .bottom)
    )
  }

  private var backgroundView: some View {
    VStack {
      EmptyView()
    }
    .frame(width: 300, height: 300)
    .background(Color.purple)
  }
}

#if DEBUG
#Preview("Example Gesture View") {
  ExampleGestureView() as! any View
}
#endif
