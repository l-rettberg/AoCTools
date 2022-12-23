//
//  DataTests.swift
//  
//  Advent of Code tools
//

import XCTest
import AoCTools

class DataTests: XCTestCase {

    func testHexByte() throws {
        XCTAssertEqual(UInt8(0).hex, "00")
        XCTAssertEqual(UInt8(10).hex, "0a")
        XCTAssertEqual(UInt8(127).hex, "7f")
        XCTAssertEqual(UInt8(255).hex, "ff")
    }

    func testHexBytes() throws {
        let arr: [UInt8] = [ 0, 1, 10]
        XCTAssertEqual(arr.hex, "00010a")
    }

    func testHexData() throws {
        let arr: [UInt8] = [ 47, 11, 08, 15 ]
        let data = Data(bytes: arr, count: arr.count)
        XCTAssertEqual(data.hex, "2f0b080f")
    }

}
