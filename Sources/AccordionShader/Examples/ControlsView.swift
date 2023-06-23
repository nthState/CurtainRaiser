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
        Text("control.offset \(control.offset.y)", bundle: .module)
        Slider(value: $control.offset.y, in: 0...1)
    }
  }

  private var sectionCount: some View {
    HStack {
      Text("control.sections \(control.sections)", bundle: .module)
      Slider(value: $control.sections, in: 0...15, step: 1.0)
    }
  }

  private var enableButton: some View {
    HStack {
      Button {
        control.enable.toggle()
      } label: {
        Text("control.shaderEnabled \(control.enable.description)", bundle: .module)
      }
    }
    .padding()
  }

  private var debugButton: some View {
    HStack {
      Button {
        control.showDebugButton.toggle()
      } label: {
        Text("control.showDebugButton \(control.showDebugButton.description)", bundle: .module)
      }
    }
    .padding()
  }

}

#Preview("Controls View") {
  ControlsView(control: ControlViewModel()) as! any View
}
