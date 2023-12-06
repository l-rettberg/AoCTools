//
//  SequenceTests.swift
//  
//  Advent of Code tools
//

import XCTest
import AoCTools

class SequenceTests: XCTestCase {
    func testCount() throws {
        let array = [1, 2, 3, 4]
        XCTAssertEqual(array.count(where: { $0 == 1 }), 1)
        XCTAssertEqual(array.count(where: { $0.isMultiple(of: 2)}), 2)
    }

    func testMinMax() throws {
        let (min, max) = try XCTUnwrap([1, 2, 3, 4, 5].shuffled().minAndMax())
        XCTAssertEqual(max, 5)
        XCTAssertEqual(min, 1)

        let points = [Point.zero, Point(1, 100), Point(2, 200)]
        let (minX, maxX) = try XCTUnwrap(points.shuffled().minAndMax(of: \.x))
        XCTAssertEqual(maxX, 2)
        XCTAssertEqual(minX, 0)

        let (minY, maxY) = try XCTUnwrap(points.shuffled().minAndMax(of: \.y))
        XCTAssertEqual(maxY, 200)
        XCTAssertEqual(minY, 0)
    }

    func testSum() throws {
        XCTAssertEqual([1, 2, 3, 4].sum(), 10)
        XCTAssertEqual([1, 2, 3, 4].product(), 24)

        struct Foo {
            let bar: Int
            init(_ bar: Int) { self.bar = bar }
        }

        XCTAssertEqual([Foo(1), Foo(2)].sumOf(\.bar), 3)
        XCTAssertEqual([Foo(3), Foo(4)].productOf(\.bar), 12)
    }
}
