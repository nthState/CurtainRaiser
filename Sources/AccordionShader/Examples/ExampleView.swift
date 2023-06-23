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
          .accordion(sections: UInt(control.sections),
                     offset: control.offset,
                     enabled: control.enable,
                     showDebugButton: control.showDebugButton)
      }

      ControlsView(control: control)
    }
  }

  private var foregroundView: some View {
    ZStack {
      Text("Hello")
        .font(.headline)

      Checkerboard(rows: 4, columns: 4)
        .fill(.gray)
        .frame(width: 300, height: 300)
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
#Preview("Example view") {
  ExampleView() as! any View
//    .previewDevice("iPhone 14")
//    .previewDisplayName("iPhone 14")
//
//  ExampleView()
//    .previewDevice("iPad Pro (11-inch) (4th generation)")
//    .previewInterfaceOrientation(.portrait)
//    .previewDisplayName("iPad Portrait")
//
//  ExampleView()
//    .previewDevice("iPad Pro (11-inch) (4th generation)")
//    .previewInterfaceOrientation(.landscapeLeft)
//    .previewDisplayName("iPad Portrait")
}
#endif
