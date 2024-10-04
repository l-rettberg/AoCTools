//
//  CollectionTests.swift
//
//  Advent of Code tools
//

import XCTest
import AoCTools

class CollectionTests: XCTestCase {
    func testReadSubscript() throws {
        let array = [[1, 2, 3], [4, 5, 6]]
        XCTAssertEqual(array[Point.zero], 1)

        XCTAssertEqual(array[safe: .zero], 1)
        XCTAssertEqual(array[safe: Point(10, 10)], nil)
    }

    func testWriteSubscript() throws {
        var array = [[1, 2, 3], [4, 5, 6]]
        XCTAssertEqual(array[Point.zero], 1)
        array[.zero] = 42
        XCTAssertEqual(array[Point.zero], 42)

        XCTAssertEqual(array[safe: .zero], 42)
        XCTAssertEqual(array[safe: Point(10, 10)], nil)

        let hash = array.hashValue
        array[safe: Point(10, 10)] = nil
        array[safe: Point(10, 10)] = 5
        // array remained untouched
        XCTAssertEqual(hash, array.hashValue)
    }
}
