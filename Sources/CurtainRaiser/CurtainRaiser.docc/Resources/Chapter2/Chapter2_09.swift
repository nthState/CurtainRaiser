import CurtainRaiser
import SwiftUI

struct ContentView {
  @State var touchOffset: CGPoint = .zero
}

extension ContentView: View {

  var body: some View {

    let drag = DragGesture()
      .onChanged { gesture in
        touchOffset = CGPoint(x: (gesture.location.x / UIScreen.main.bounds.width),
                         y: 1.0 - (gesture.location.y / UIScreen.main.bounds.height))
      }
      .onEnded { _ in

      }

    ZStack {
      backgroundView
      foregroundView
        .curtainRaiser(
          sections: 5,
          offset: touchOffset
        )
        .gesture(drag)
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
