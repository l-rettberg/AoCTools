//
//  HexPointTests.swift
//  
//
//  Created by Gereon Steffens on 19.07.22.
//

import XCTest
import AoCTools

class HexPointTests: XCTestCase {

    func testPoint() throws {
        let zero = Hex.Point.zero
        XCTAssertEqual(zero.q, 0)
        XCTAssertEqual(zero.r, 0)
        XCTAssertEqual(zero.s, 0)

        let one = Hex.Point(1, 1, 1)
        XCTAssertEqual(one.q, 1)
        XCTAssertEqual(one.r, 1)
        XCTAssertEqual(one.s, 1)

        let sum = zero + one
        XCTAssertEqual(sum, one)

        let two = one + one
        XCTAssertEqual(two.q, 2)
        XCTAssertEqual(two.r, 2)
        XCTAssertEqual(two.s, 2)
    }

    func testDistance() throws {
        XCTAssertEqual(Hex.Point.zero.distance(to: .zero), 0)

        XCTAssertEqual(Hex.Point(1, 1, 0).distance(), 1)
        XCTAssertEqual(Hex.Point(1, 0, 1).distance(), 1)
        XCTAssertEqual(Hex.Point(0, 1, 1).distance(), 1)
    }

    func testNeighbors() throws {
        let zero = Hex.Point.zero
        XCTAssertEqual(zero.neighbors(orientation: .pointy).count, 6)
        XCTAssertEqual(zero.neighbors(orientation: .flat).count, 6)

        for n in zero.neighbors(orientation: .pointy) {
            XCTAssertEqual(n.distance(to: .zero), 1)
            let m = zero + n + n
            XCTAssertEqual(m.distance(to: .zero), 2)
        }

        for n in zero.neighbors(orientation: .flat) {
            XCTAssertEqual(n.distance(to: .zero), 1)
            let m = zero + n + n
            XCTAssertEqual(m.distance(to: .zero), 2)
        }
    }

    func testOppositeDirection() throws {
        let zero = Hex.Point.zero

        for direction in Hex.PointyDirection.allCases {
            XCTAssertEqual(zero + direction.offset + direction.opposite.offset, zero)
        }
        for direction in Hex.FlatDirection.allCases {
            XCTAssertEqual(zero + direction.offset + direction.opposite.offset, zero)
        }

    }

}
