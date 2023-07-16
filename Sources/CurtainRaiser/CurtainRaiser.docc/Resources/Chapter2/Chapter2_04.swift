import CurtainRaiser
import SwiftUI

struct ContentView {}

extension ContentView: View {

  var body: some View {

    let drag = DragGesture()
      .onChanged { _ in

      }
      .onEnded { _ in

      }

    ZStack {
      backgroundView
      foregroundView
        .curtainRaiser(offset: CGPoint(x: 0, y: 0.2))
    }
  }

  private var backgroundView: some View {
    Color.red
      .edgesIgnoringSafeArea(.all)
  }

  private var foregroundView: some View {
    Color.blue
      .edgesIgnoringSafeArea(.all)
  }

}
