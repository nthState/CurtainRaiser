//
//  Copyright © nthState Ltd 2023. All rights reserved.
//

import AVKit
import SwiftUI

private struct ExampleView {
  @State private var control = ControlViewModel()
}

extension ExampleView: View {

  public var body: some View {
    VStack {

      ZStack {
        backgroundView
        foregroundView
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
#Preview("Example View") {
  ExampleView()
}
#endif
