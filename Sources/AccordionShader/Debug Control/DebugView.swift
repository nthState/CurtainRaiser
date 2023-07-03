//
//  Copyright © nthState Ltd 2023. All rights reserved.
//

import SwiftUI

struct DebugView {
  @EnvironmentObject var debugModel: DebugModel
  private let maxAngle: CGFloat = 90.0
  private let calculatedAngle: CGFloat

  init(offset: CGPoint) {
    self.calculatedAngle = maxAngle * offset.y
  }
}

extension DebugView: View {

  var body: some View {
    content
  }

  private var content: some View {
    Form {

      title

      Section {
        angleView
      }

      Section {
        cameraXView
        cameraYView
        cameraZView
      }

        Section {
          lookAtXView
          lookAtYView
          lookAtZView
        }

      Section {
        fovView
        nearView
        farView
      }

      Section {
        showGridLinesButton
      }
    }
    .font(.subheadline.monospaced())
    .padding()
  }

  private var title: some View {
    Text("debug.view.title", bundle: .module)
  }

  private var showGridLinesButton: some View {
    HStack {
      Button {
        debugModel.enableLinesShader.toggle()
      } label: {
        Text("debug.enableLinesShader \(debugModel.enableLinesShader.description)", bundle: .module)
      }
    }
    .padding()
  }

  private var angleView: some View {
    HStack {
      Text("debug.angle \(calculatedAngle)", bundle: .module)
    }
  }

  private var cameraXView: some View {
    HStack {
      Text("debug.camera.x \(debugModel.cameraX)", bundle: .module)
      Slider(value: $debugModel.cameraX, in: -180.0...180.0, step: 5)
      Button(action: {
        debugModel.cameraX = 0
      }, label: {
        Text("common.reset", bundle: .module)
      })
    }
  }

  private var cameraYView: some View {
    HStack {
      Text("debug.camera.y \(debugModel.cameraY)", bundle: .module)
      Slider(value: $debugModel.cameraY, in: -180.0...180.0, step: 5)
      Button(action: {
        debugModel.cameraY = 0
      }, label: {
        Text("common.reset", bundle: .module)
      })
    }
  }

  private var cameraZView: some View {
    HStack {
      Text("debug.camera.z \(debugModel.cameraZ)", bundle: .module)
      Slider(value: $debugModel.cameraZ, in: -180...180.0, step: 5)
      Button(action: {
        debugModel.cameraZ = 150
      }, label: {
        Text("common.reset", bundle: .module)
      })
    }
  }

    private var lookAtXView: some View {
      HStack {
        Text("debug.lookAt.x \(debugModel.lookAtX)", bundle: .module)
        Slider(value: $debugModel.lookAtX, in: -180.0...180.0, step: 5)
        Button(action: {
          debugModel.lookAtX = 0
        }, label: {
          Text("common.reset", bundle: .module)
        })
      }
    }

    private var lookAtYView: some View {
      HStack {
        Text("debug.lookAt.y \(debugModel.lookAtY)", bundle: .module)
        Slider(value: $debugModel.lookAtY, in: -180.0...180.0, step: 5)
        Button(action: {
          debugModel.lookAtY = 0
        }, label: {
          Text("common.reset", bundle: .module)
        })
      }
    }

    private var lookAtZView: some View {
      HStack {
        Text("debug.lookAt.z \(debugModel.lookAtZ)", bundle: .module)
        Slider(value: $debugModel.lookAtZ, in: -180...180.0, step: 5)
        Button(action: {
          debugModel.lookAtZ = 150
        }, label: {
          Text("common.reset", bundle: .module)
        })
      }
    }

  private var fovView: some View {
    HStack {
      Text("debug.projection.fov \(debugModel.fov)", bundle: .module)
      Slider(value: $debugModel.fov, in: 0.0...360.0, step: 5)
      Button(action: {
        debugModel.fov = 90
      }, label: {
        Text("common.reset", bundle: .module)
      })
    }
  }

  private var nearView: some View {
    HStack {
      Text("debug.projection.nearPlane \(debugModel.near)", bundle: .module)
      Slider(value: $debugModel.near, in: -1.0...10)
      Button(action: {
        debugModel.near = 0.01
      }, label: {
        Text("common.reset", bundle: .module)
      })
    }
  }

  private var farView: some View {
    HStack {
      Text("debug.projection.farPlane \(debugModel.far)", bundle: .module)
      Slider(value: $debugModel.far, in: 0.0...2000.0, step: 10)
      Button(action: {
        debugModel.far = 1000.0
      }, label: {
        Text("common.reset", bundle: .module)
      })
    }
  }
}

// #if DEBUG
// #Preview("Debug View") {
//    DebugView(yOffset: .constant(45))
//        .environmentObject(DebugModel())
// }
// #endif
