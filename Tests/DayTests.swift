//
//  DayTests.swift
//  
//  Advent of Code tools
//

import XCTest
import AoCTools

final class Day98: AOCDay {
    let input: String
    
    init(input: String) {
        self.input = input
    }

    func part1() -> Int { 98 }
    func part2() -> String { input }
}

final class Day99: AOCDay {
    let input: String

    init(input: String) { 
        self.input = input
    }

    func part1() -> Int { 99 }
    func part2() -> String { input }
}

extension Day99 {
    static let input = "day99data"
}

// no Day98 extension

class DayTests: XCTestCase {
    func testDayWithInput() throws {
        let d99 = Day99(input: Day99.input)
        XCTAssertEqual(d99.day, "99")
        XCTAssertEqual(d99.input, Day99.input)
        XCTAssertEqual(d99.part1(), 99)
        XCTAssertEqual(d99.part2(), Day99.input)

        let d99b = Day99(input: "testinput")
        XCTAssertEqual(d99b.day, "99")
        XCTAssertEqual(d99b.input, "testinput")
        XCTAssertEqual(d99b.part1(), 99)
        XCTAssertEqual(d99b.part2(), "testinput")
    }

    func testDayWithoutInput() throws {
        let d98 = Day98(input: "test")
        XCTAssertEqual(d98.day, "98")
        XCTAssertEqual(d98.input, "test")
        XCTAssertEqual(Day98.input, "")
        XCTAssertEqual(d98.part1(), 98)
        XCTAssertEqual(d98.part2(), "test")

        let d98b = Day98(input: Day98.input)
        XCTAssertEqual(d98b.day, "98")
        XCTAssertEqual(d98b.input, "")
        XCTAssertEqual(d98b.part1(), 98)
        XCTAssertEqual(d98b.part2(), "")
    }
}
