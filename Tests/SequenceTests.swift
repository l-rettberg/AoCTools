//
//  SequenceTests.swift
//  
//
//  Created by Gereon Steffens on 09.01.22.
//

import XCTest
import AoCTools

class SequenceTests: XCTestCase {
    func testExample() throws {
        let array = [1, 2, 3, 4]
        XCTAssertEqual(array.count(where: { $0 == 1 }), 1)
        XCTAssertEqual(array.count(where: { $0.isMultiple(of: 2)}), 2)
    }
}
