//
//  CollectionTests.swift
//
//  Advent of Code tools
//

import Testing
import AoCTools

@Suite
struct CollectionTests {
    @Test func testReadSubscript() throws {
        let array = [[1, 2, 3], [4, 5, 6]]
        #expect(array[Point.zero] == 1)

        #expect(array[safe: .zero] == 1)
        #expect(array[safe: Point(10, 10)] == nil)
    }

    @Test func testWriteSubscript() throws {
        var array = [[1, 2, 3], [4, 5, 6]]
        #expect(array[Point.zero] == 1)
        array[.zero] = 42
        #expect(array[Point.zero] == 42)

        #expect(array[safe: .zero] == 42)
        #expect(array[safe: Point(10, 10)] == nil)

        let hash = array.hashValue
        array[safe: Point(10, 10)] = nil
        array[safe: Point(10, 10)] = 5
        // array remained untouched
        #expect(hash == array.hashValue)
    }
}
