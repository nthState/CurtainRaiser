//
//  Copyright © nthState Ltd 2023. All rights reserved.
//

import SwiftUI

struct AnimatingCircle: View {
  @State private var drawingStroke = false

  private let animation = Animation
    .linear(duration: 3)
    .repeatForever(autoreverses: false)

  var body: some View {
    circle
      .frame(width: 150)
      .animation(animation, value: drawingStroke)
      .onAppear {
        drawingStroke.toggle()
      }
  }

  private var circle: some View {
    Circle()
      .stroke(Color.blue, style: StrokeStyle(lineWidth: 16))
      .overlay {
        Circle()
          .trim(from: 0, to: drawingStroke ? 1 : 0)
          .stroke(Color.red, style: StrokeStyle(lineWidth: 16, lineCap: .round))
      }
      .rotationEffect(.degrees(-90))
  }
}
