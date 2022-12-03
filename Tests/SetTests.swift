//
//  SetTests.swift
//  
//
//  Created by Gereon Steffens on 03.10.22.
//

import XCTest
import AoCTools

final class SetTests: XCTestCase {

    func testAdd() throws {
        let s1 = Set([1, 2])
        let s2 = Set([3, 4])
        XCTAssertEqual(s1 + s2, Set([1, 2, 3, 4]))

        XCTAssertEqual(s1 + 4, Set([1, 2, 4]))
    }

    func testSubtract() throws {
        let s1 = Set([1, 2, 3, 4])
        let s2 = Set([3, 4])
        XCTAssertEqual(s1 - s2, Set([1, 2]))

        XCTAssertEqual(s1 - 4, Set([1, 2, 3]))
    }

    func testCombinations() throws {
        let s1 = Set([1, 2, 3])
        let combinations = s1.combinations()
        XCTAssertEqual(combinations.count, 7)

        XCTAssertTrue(combinations.contains([1]))
        XCTAssertTrue(combinations.contains([2]))
        XCTAssertTrue(combinations.contains([3]))
        XCTAssertTrue(combinations.contains([1, 2]))
        XCTAssertTrue(combinations.contains([1, 3]))
        XCTAssertTrue(combinations.contains([2, 3]))
        XCTAssertTrue(combinations.contains([1, 2, 3]))
    }
}
