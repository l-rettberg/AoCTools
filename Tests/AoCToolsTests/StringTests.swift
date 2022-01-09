//
//  StringTests.swift
//  
//
//  Created by Gereon Steffens on 09.01.22.
//

import XCTest
import AoCTools

class StringTests: XCTestCase {
    func testTrim() throws {
        var str = "  abc   "
        XCTAssertEqual(str.trimmed(), "abc")

        str.trim()
        XCTAssertEqual(str, "abc")
    }

    func testIndex() throws {
        let str = "abc"

        XCTAssertEqual(str.indexOf("b"), 1)
        XCTAssertEqual(str.indexOf("x"), nil)
    }

    func testIndices() throws {
        let str = "aabbcc"

        XCTAssertEqual(str.indicesOf("ab"), [1])
        XCTAssertEqual(str.indicesOf("a"), [0, 1])
        XCTAssertEqual(str.indicesOf("b"), [2, 3])
        XCTAssertEqual(str.indicesOf("bb"), [2])
        XCTAssertEqual(str.indicesOf("xx"), [])
    }
}
