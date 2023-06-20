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
          sectionCount
          offsetSlider
          cameraXView
          cameraYView
          cameraZView
          angleView
          fovView
          enableButton
          debugButton
        }
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
        Text("angle: \(control.angle, specifier: "%0.3f")")
        Slider(value: $control.angle, in: -180.0...180.0)
        Button("Reset") {
          control.angle = 0.0
        }
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
}

#Preview("Controls View") {
    ControlsView(control: ControlViewModel())
}
