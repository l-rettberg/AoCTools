//
//  DayTests.swift
//  
//  Advent of Code tools
//

import XCTest
import AoCTools

final class Day98: AOCDay {
    let input: String
    init(rawInput: String? = nil) {
        self.input = rawInput ?? Self.rawInput
    }

    func part1() -> Int { 98 }
    func part2() -> String { "d98" }
}

final class Day99: AOCDay {
    let input: String

    init(rawInput: String? = nil) {
        self.input = rawInput ?? Self.rawInput
    }

    func part1() -> Int { 0 }
    func part2() -> String { "" }
}

extension Day99 {
    static let rawInput = "day99data"
}

class DayTests: XCTestCase {
    func testDays() throws {
        let d99 = Day99()
        XCTAssertEqual(d99.day, "99")
        XCTAssertEqual(d99.input, "day99data")
        XCTAssertEqual(Day99.rawInput, "day99data")
        XCTAssertEqual(d99.part1(), 0)
        XCTAssertEqual(d99.part2(), "")

        let d98 = Day98(rawInput: "test")
        XCTAssertEqual(d98.day, "98")
        XCTAssertEqual(d98.input, "test")
        XCTAssertEqual(Day98.rawInput, "")
        XCTAssertEqual(d98.part1(), 98)
        XCTAssertEqual(d98.part2(), "d98")
    }
}
