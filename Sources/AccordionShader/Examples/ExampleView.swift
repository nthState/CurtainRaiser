//
//  Copyright © nthState Ltd 2023. All rights reserved.
//

import AVKit
import SwiftUI

struct ExampleView {
  @State private var control = ControlViewModel()
}

extension ExampleView: View {

  public var body: some View {
    VStack {

      ZStack {
        backgroundView
        foregroundView
          .accordion(sections: control.sections,
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
#Preview("Example View, iPhone 14") {
  ExampleView()
    .previewDevice("iPhone 14")
}

#Preview("iPad Pro (11-inch) (4th generation)") {
  ExampleView()
    .previewDevice("iPad Pro (11-inch) (4th generation)")
}

#Preview("iPad Pro (11-inch) (4th generation) Landscape") {
  ExampleView()
    .previewDevice("iPad Pro (11-inch) (4th generation)")
    .previewInterfaceOrientation(.landscapeLeft)
}
#endif
