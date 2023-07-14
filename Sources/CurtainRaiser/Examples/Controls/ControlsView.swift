//
//  Copyright © nthState Ltd 2023. All rights reserved.
//

import SwiftUI

internal struct ControlsView {
  @Binding var control: ControlViewModel
}

extension ControlsView: View {

  var body: some View {
    content
  }

  private var content: some View {
    Form {
      Section {
        offsetSlider
      }
      Section {
        sectionCount
        maxShadow
        pleatHeight
        lift
      }
      Section {
        enableButton
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

  private var sectionsDouble: Binding<Double> {
    Binding<Double>(get: {
      return Double(control.sections)
    }, set: {
      control.sections = Int($0)
    })
  }

  private var sectionCount: some View {
    HStack {
      Text("control.sections \(control.sections)", bundle: .module)
      Slider(value: sectionsDouble, in: 0...15, step: 1.0)
    }
  }

  private var maxShadow: some View {
    HStack {
      Text("control.maxShadow \(control.maxShadow)", bundle: .module)
      Slider(value: $control.maxShadow, in: 0...2)
    }
  }

  private var pleatHeight: some View {
    HStack {
      Text("control.pleatHeight \(control.pleatHeight)", bundle: .module)
      Slider(value: $control.pleatHeight, in: 0...5)
    }
  }

  private var lift: some View {
    HStack {
      Text("control.lift \(control.lift)", bundle: .module)
      Slider(value: $control.lift, in: 0...1)
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
  }

}

#if DEBUG
#Preview("Controls View") {
  ControlsView(control: .constant(ControlViewModel()))
}
#endif
