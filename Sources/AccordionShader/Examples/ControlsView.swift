//
//  Copyright © nthState Ltd 2023. All rights reserved.
//

import SwiftUI

struct ControlsView {
  @StateObject var control: ControlViewModel
}

extension ControlsView: View {

  var body: some View {
    content
  }

  private var content: some View {
    VStack {
      Group {
        sectionCount
        offsetSlider
        angleView
      }
      Group {
        enableButton
        debugButton
      }
    }
    .font(.subheadline.monospaced())
    .padding()
  }

  private var offsetSlider: some View {
    HStack {
      Text("Y Offset: \(control.yOffset, specifier: "%0.3f")")
      Slider(value: $control.yOffset, in: 0...1)
    }
  }

  private var sectionCount: some View {
    HStack {
      Text("Sections: \(control.sections, specifier: "%0.3f")")
      Slider(value: $control.sections, in: 0...15, step: 1.0)
    }
  }

  private var angleView: some View {
    HStack {
      Text("angle: \(90.0 * control.yOffset, specifier: "%0.3f")")
    }
  }

  private var enableButton: some View {
    HStack {
      Button {
        control.enable.toggle()
      } label: {
        Text("Shader enabled: \(control.enable.description)")
      }
    }
    .padding()
  }

  private var debugButton: some View {
    HStack {
      Button {
        control.showDebugButton.toggle()
      } label: {
        Text("Show Debug Button: \(control.showDebugButton.description)")
      }
    }
    .padding()
  }

}

#Preview("Controls View") {
  ControlsView(control: ControlViewModel()) as! any View
}
