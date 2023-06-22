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
        cameraXView
        cameraYView
        cameraZView
      }

      Group {
        fovView
        nearView
        farView
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

  private var debugButton: some View {
    HStack {
      Button {
        control.debug.toggle()
      } label: {
        Text("Debug enabled: \(control.debug.description)")
      }
    }
  }

  private var enableButton: some View {
    HStack {
      Button {
        control.enable.toggle()
      } label: {
        Text("Distort enabled: \(control.enable.description)")
      }
    }
    .padding()
  }

  private var cameraXView: some View {
    HStack {
      Text("cameraX: \(control.cameraX, specifier: "%0.3f")")
      Slider(value: $control.cameraX, in: -180.0...180.0)
      Button("Reset") {
        control.cameraX = 0.0
      }
    }
  }

  private var cameraYView: some View {
    HStack {
      Text("cameraY: \(control.cameraY, specifier: "%0.3f")")
      Slider(value: $control.cameraY, in: -180.0...180.0)
      Button("Reset") {
        control.cameraY = 0.0
      }
    }
  }

  private var cameraZView: some View {
    HStack {
      Text("cameraZ: \(control.cameraZ, specifier: "%0.3f")")
      Slider(value: $control.cameraZ, in: -10...150.0)
      Button("Reset") {
        control.cameraZ = 0.0
      }
    }
  }

  private var angleView: some View {
    HStack {
      Text("angle: \(90.0 * control.yOffset, specifier: "%0.3f")")
    }
  }

  private var fovView: some View {
    HStack {
      Text("fov: \(control.fov, specifier: "%0.3f")")
      Slider(value: $control.fov, in: 0.0...360.0)
      Button("Reset") {
        control.fov = 90.0
      }
    }
  }

  private var nearView: some View {
    HStack {
      Text("near: \(control.near, specifier: "%0.3f")")
      Slider(value: $control.near, in: -1.0...10)
      Button("Reset") {
        control.near = 0.01
      }
    }
  }

  private var farView: some View {
    HStack {
      Text("far: \(control.far, specifier: "%0.3f")")
      Slider(value: $control.far, in: 0.0...1000.0)
      Button("Reset") {
        control.far = 1000.0
      }
    }
  }
}

#Preview("Controls View") {
  ControlsView(control: ControlViewModel()) as! any View
}
