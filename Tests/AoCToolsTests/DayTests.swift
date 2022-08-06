//
//  DayTests.swift
//  
//
//  Created by Gereon Steffens on 06.08.22.
//

import XCTest
import AoCTools

final class Day99: AOCDay {
    let input: String

    init(rawInput: String? = nil) {
        self.input = rawInput ?? Self.rawInput
    }

    func part1() -> Int { 0 }
    func part2() -> String { "" }
}

extension Day99 {
    static let rawInput = "data"
}

class DayTests: XCTestCase {
    func testDays() throws {
        let d99 = Day99()
        d99.run()

        XCTAssertEqual(d99.day, "99")
        XCTAssertEqual(d99.part1(), 0)
        XCTAssertEqual(d99.part2(), "")
        XCTAssertEqual(d99.input, "data")

        let testD99 = Day99(rawInput: "test")
        XCTAssertEqual(testD99.day, "99")
        XCTAssertEqual(testD99.input, "test")
    }
}
