//
//  Copyright © nthState Ltd 2023. All rights reserved.
//

import SwiftUI

private struct ExampleGestureView {
  @State private var control = ControlViewModel()
}

extension ExampleGestureView: View {

  var body: some View {
    VStack {

      ZStack(alignment: .center) {
        backgroundView
        foregroundView
          .gesture(
            DragGesture()
              .onChanged { gesture in
                control.offset = CGPoint(x: (gesture.location.x / 300),
                                         y: 1.0 - (gesture.location.y / 300))
              }
              .onEnded { _ in
                withAnimation(.spring()) {
                  control.offset = CGPoint(x: 0.5, y: 0)
                }
              }
          )
          .curtainRaiser(sections: control.sections,
                     maxShadow: control.maxShadow,
                     pleatHeight: control.pleatHeight,
                     lift: control.lift,
                     offset: control.offset,
                     enabled: control.enable)
      }

      ControlsView(control: $control)
    }
  }

  private var foregroundView: some View {
    ZStack {
      Text("Hello")
        .font(.headline)

      AnimatingCircle()
    }
      // fix this ControlsView(control: $control)
    .frame(width: 300, height: 300)
    .background(
      LinearGradient(gradient: Gradient(colors: [.green, .orange]), startPoint: .top, endPoint: .bottom)
    )
  }

  private var backgroundView: some View {
    Rectangle()
      .fill(Color.purple)
      .frame(width: 300, height: 300)
  }
}

#if DEBUG
#Preview("Example Gesture View") {
  ExampleGestureView()
}
#endif
