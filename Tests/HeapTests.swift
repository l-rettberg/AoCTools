//
//  HeapTests.swift
//  
//  Advent of Code tools
//

import XCTest
import AoCTools

class HeapTests: XCTestCase {
    func testMinHeap() throws {
        var heap = Heap<Int>.minHeap()

        let max = 100
        let a = Array(1...max).shuffled()
        a.forEach { heap.insert($0) }

        XCTAssertEqual(heap.count, max)
        for i in 1...max {
            XCTAssertEqual(heap.pop(), i)
        }
    }

    func testMaxHeap() throws {
        var heap = Heap<Int>.maxHeap()

        let max = 100
        Array(1...max).shuffled().forEach { heap.insert($0) }

        XCTAssertEqual(heap.count, max)
        for i in (1...max).reversed() {
            XCTAssertEqual(heap.pop(), i)
        }
    }
}
