//
//  Copyright © nthState Ltd 2023. All rights reserved.
//

import SwiftUI

struct Checkerboard: Shape {

  let rows: Int
  let columns: Int

  func path(in rect: CGRect) -> Path {
    var path = Path()

    let rowSize = rect.height / CGFloat(rows)
    let columnSize = rect.width / CGFloat(columns)

    for row in 0..<rows {
      for column in 0..<columns {
        if Int(row + column) % 2 == 0 {
          let x = columnSize * CGFloat(column)
          let y = rowSize * CGFloat(row)
          let rect = CGRect(x: x, y: y, width: columnSize, height: rowSize)
          path.addRect(rect)
        }
      }
    }

    return path
  }
}
