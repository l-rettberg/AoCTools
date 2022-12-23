//
//  SequenceTests.swift
//  
//  Advent of Code tools
//

import XCTest
import AoCTools

class SequenceTests: XCTestCase {
    func testExample() throws {
        let array = [1, 2, 3, 4]
        XCTAssertEqual(array.count(where: { $0 == 1 }), 1)
        XCTAssertEqual(array.count(where: { $0.isMultiple(of: 2)}), 2)
    }

    func testMinMax() throws {
        let (min, max) = try XCTUnwrap([1,2,3,4,5].shuffled().minAndMax())
        XCTAssertEqual(max, 5)
        XCTAssertEqual(min, 1)

        let points = [Point.zero, Point(1,100), Point(2,200)]
        let (minX, maxX) = try XCTUnwrap(points.shuffled().minAndMax(of: \.x))
        XCTAssertEqual(maxX, 2)
        XCTAssertEqual(minX, 0)

        let (minY, maxY) = try XCTUnwrap(points.shuffled().minAndMax(of: \.y))
        XCTAssertEqual(maxY, 200)
        XCTAssertEqual(minY, 0)
    }
}
