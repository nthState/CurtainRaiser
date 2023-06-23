//
//  Copyright © nthState Ltd 2023. All rights reserved.
//

import SwiftUI

struct DebugView {
    @EnvironmentObject var debugModel: DebugModel
}

extension DebugView: View {

  var body: some View {
    content
  }

  private var content: some View {
    VStack {

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
        showGridLinesButton
      }
    }
    .font(.subheadline.monospaced())
    .padding()
  }

  private var showGridLinesButton: some View {
    HStack {
      Button {
          debugModel.enableLinesShader.toggle()
      } label: {
        Text("Lines Shader Enabled: \(debugModel.enableLinesShader.description)")
      }
    }
    .padding()
  }

  private var cameraXView: some View {
    HStack {
      Text("cameraX: \(debugModel.cameraX, specifier: "%0.3f")")
      Slider(value: $debugModel.cameraX, in: -180.0...180.0)
      Button("Reset") {
        debugModel.cameraX = 0.0
      }
    }
  }

  private var cameraYView: some View {
    HStack {
      Text("cameraY: \(debugModel.cameraY, specifier: "%0.3f")")
      Slider(value: $debugModel.cameraY, in: -180.0...180.0)
      Button("Reset") {
        debugModel.cameraY = 0.0
      }
    }
  }

  private var cameraZView: some View {
    HStack {
      Text("cameraZ: \(debugModel.cameraZ, specifier: "%0.3f")")
      Slider(value: $debugModel.cameraZ, in: -10...150.0)
      Button("Reset") {
        debugModel.cameraZ = 0.0
      }
    }
  }

  private var fovView: some View {
    HStack {
      Text("fov: \(debugModel.fov, specifier: "%0.3f")")
      Slider(value: $debugModel.fov, in: 0.0...360.0)
      Button("Reset") {
        debugModel.fov = 90.0
      }
    }
  }

  private var nearView: some View {
    HStack {
      Text("near: \(debugModel.near, specifier: "%0.3f")")
      Slider(value: $debugModel.near, in: -1.0...10)
      Button("Reset") {
        debugModel.near = 0.01
      }
    }
  }

  private var farView: some View {
    HStack {
      Text("far: \(debugModel.far, specifier: "%0.3f")")
      Slider(value: $debugModel.far, in: 0.0...1000.0)
      Button("Reset") {
        debugModel.far = 1000.0
      }
    }
  }
}

// #if DEBUG
// #Preview("Debug View") {
//    DebugView()
//        .environmentObject(DebugModel())
// }
// #endif
