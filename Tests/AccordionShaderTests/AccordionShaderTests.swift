//
//  Copyright © nthState Ltd 2023. All rights reserved.
//

import XCTest
@testable import AccordionShader

final class AccordionShaderTests: XCTestCase {

  func test_clamp_lowerbounds() throws {

    let value = -1.0

    let result = value.clamped(to: 0...1)

    XCTAssertEqual(result, 0, "Value should be clamped to 0")
  }

  func test_clamp_upperbounds() throws {

    let value = 2.0

    let result = value.clamped(to: 0...1)

    XCTAssertEqual(result, 1, "Value should be clamped to 1")
  }

  func test_clamp_midbounds() throws {

    let value = 0.5

    let result = value.clamped(to: 0...1)

    XCTAssertEqual(result, 0.5, "Value should be clamped to 0.5")
  }

}
