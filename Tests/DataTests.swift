//
//  DataTests.swift
//  
//  Advent of Code tools
//

import AoCTools
import Foundation
import Testing

@Suite
struct DataTests {

    @Test func testHexByte() throws {
        #expect(UInt8(0).hex == "00")
        #expect(UInt8(10).hex == "0a")
        #expect(UInt8(127).hex == "7f")
        #expect(UInt8(255).hex == "ff")
    }

    @Test func testHexBytes() throws {
        let arr: [UInt8] = [ 0, 1, 10]
        #expect(arr.hex == "00010a")
    }

    @Test func testHexData() throws {
        let arr: [UInt8] = [ 47, 11, 08, 15 ]
        let data = Data(bytes: arr, count: arr.count)
        #expect(data.hex == "2f0b080f")
    }

}
