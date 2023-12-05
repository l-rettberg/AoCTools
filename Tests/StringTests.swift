//
//  StringTests.swift
//  
//  Advent of Code tools
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

    func testLastIndex() throws {
        let str = "abc"

        XCTAssertEqual(str.lastIndexOf("b"), 1)
        XCTAssertEqual(str.lastIndexOf("x"), nil)

        XCTAssertEqual("abbc".lastIndexOf("b"), 2)
    }

    func testSubscript() throws {
        let str = "abcdef"

        XCTAssertEqual(str.charAt(0), "a")
        XCTAssertEqual(str.charAt(1), "b")
        XCTAssertEqual(str.charAt(5), "f")

        XCTAssertEqual(str[0], "a")
        XCTAssertEqual(str[1], "b")
        XCTAssertEqual(str[5], "f")
    }

    func testSubstring() throws {
        let str = "abcdef"

        XCTAssertEqual(str.substring(0, 2), "ab")
        XCTAssertEqual(str.substring(3, 2), "de")
    }

    func testSubstringAfter() throws {
        XCTAssertEqual("foo:bar".substring(after: ":"), "bar")
    }

    func testRangeSubscript() throws {
        let str = "abcdef"

        XCTAssertEqual(str[0...1], "ab")
        XCTAssertEqual(str[3..<5], "de")
    }

    func testInts() throws {
        XCTAssertEqual("1,2,3".asInts(), [1,2,3])
        XCTAssertEqual("1, 2, 3".asInts(), [1,2,3])
    }

    func testTokenized() throws {
        XCTAssertEqual("1;2;3".tokenized(separator: ";"), ["1", "2", "3"])
        XCTAssertEqual("1 - 2 - 3".tokenized(separator: "-"), ["1", "2", "3"])
    }

    func testAllInt() throws {
        XCTAssertEqual("1,2,3".allInts(), [1,2,3])
        XCTAssertEqual("1 red -2 blue 3green".allInts(), [1,-2,3])
        XCTAssertEqual("Game 1: 1 red, 2 bluem 3 green; 4 yellow".allInts(), [1,1,2,3,4])
    }

    func testLines() throws {
        XCTAssertEqual("foo\nbar".lines, ["foo", "bar"])
        XCTAssertEqual("foo\n\nbar".lines, ["foo", "", "bar"])
        XCTAssertEqual("\nfoo\n\nbar\n ".lines, ["", "foo", "", "bar", " "])
    }
}
