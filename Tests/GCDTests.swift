//
//  GCDTests.swift
//  
//  Advent of Code tools
//

import XCTest
import AoCTools

final class GCDTests: XCTestCase {

    func testGCD() throws {
        XCTAssertEqual(gcd(10, 9), 1)
        XCTAssertEqual(gcd(9, 6), 3)
        XCTAssertEqual(gcd(12, 6), 6)
        XCTAssertEqual(gcd(16, 8), 8)
        XCTAssertEqual(gcd(10, 8), 2)
    }

    func testLCM() throws {
        XCTAssertEqual(lcm(10, 9), 90)
        XCTAssertEqual(lcm(10, 2), 10)
        XCTAssertEqual(lcm(12, 3), 12)
        XCTAssertEqual(lcm(5, 7), 35)
        XCTAssertEqual(lcm(12, 8), 24)
    }
}
