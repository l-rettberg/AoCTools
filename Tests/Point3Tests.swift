//
//  PointTests.swift
//
//
//  Created by Gereon Steffens on 19.07.22.
//

import XCTest
import AoCTools

class Point3Tests: XCTestCase {

    func testPoint() throws {
        let zero = Point3.zero
        XCTAssertEqual(zero.x, 0)
        XCTAssertEqual(zero.y, 0)
        XCTAssertEqual(zero.z, 0)

        let one = Point3(1, 1, 1)
        XCTAssertEqual(one.x, 1)
        XCTAssertEqual(one.y, 1)
        XCTAssertEqual(one.z, 1)

        let sum = zero + one
        XCTAssertEqual(sum, one)

        let two = one + one
        XCTAssertEqual(two.x, 2)
        XCTAssertEqual(two.y, 2)
        XCTAssertEqual(two.z, 2)

        let three = one * 3
        XCTAssertEqual(three.x, 3)
        XCTAssertEqual(three.y, 3)
        XCTAssertEqual(three.z, 3)
    }

    func testDistance() throws {
        XCTAssertEqual(Point3(0, 5, 0).distance(), 5)
        XCTAssertEqual(Point3(5, 0, 0).distance(), 5)

        XCTAssertEqual(Point3(1, 5, 0).distance(), 6)
        XCTAssertEqual(Point3(5, 1, 0).distance(), 6)

        XCTAssertEqual(Point3(0, 5, 0).distance(to: Point3(0, 4, 0)), 1)
        XCTAssertEqual(Point3(5, 0, 0).distance(to: Point3(10, 0, 0)), 5)

        XCTAssertEqual(Point3(0, 5, 1).distance(), 6)
        XCTAssertEqual(Point3(5, 0, 1).distance(), 6)

        XCTAssertEqual(Point3(1, 5, 1).distance(), 7)
        XCTAssertEqual(Point3(5, 1, 1).distance(), 7)

        XCTAssertEqual(Point3(0, 5, 1).distance(to: Point3(0, 4, 2)), 2)
        XCTAssertEqual(Point3(5, 0, 1).distance(to: Point3(10, 0, 2)), 6)
    }

    func testNeighbors() throws {
        let zero = Point3.zero

        XCTAssertEqual(zero.neighbors(adjacency: .all).count, 26)
        XCTAssertEqual(Set(zero.neighbors(adjacency: .all)).count, 26)

        XCTAssertEqual(zero.neighbors(adjacency: .orthogonal).count, 6)
        XCTAssertEqual(zero.neighbors(adjacency: .diagonal).count, 20)

        for n in zero.neighbors(adjacency: .orthogonal) {
            XCTAssertEqual(n.distance(to: .zero), 1)
        }

        var d2 = 0
        var d3 = 0
        for n in zero.neighbors(adjacency: .diagonal) {
            let distance = n.distance(to: .zero)
            if distance == 2 { d2 += 1 }
            if distance == 3 { d3 += 1 }
        }
        XCTAssertEqual(d2, 12)
        XCTAssertEqual(d3, 8)
    }
}
