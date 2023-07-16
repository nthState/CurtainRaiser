import SwiftUI

struct ContentView {}

extension ContentView: View {

  var body: some View {
    ZStack {
      backgroundView
      foregroundView
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
