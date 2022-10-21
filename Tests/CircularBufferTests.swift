//
//  CircularBufferTests.swift
//  
//
//  Created by Gereon Steffens on 21.10.22.
//

import XCTest
import AoCTools

final class CircularBufferTests: XCTestCase {

    func testCircularBuffer() {
        let cb = CircularBuffer<Int>()
        cb.insert(value: 0)
        XCTAssertEqual(cb.value(), 0)

        cb.insert(value: 1)
        XCTAssertEqual(cb.value(), 1)

        cb.insert(value: 2)
        XCTAssertEqual(cb.value(), 2)

        cb.moveCurrent(by: 1)
        XCTAssertEqual(cb.value(), 0)

        cb.moveCurrent(by: 1)
        XCTAssertEqual(cb.value(), 1)

        cb.moveCurrent(by: 1)
        XCTAssertEqual(cb.value(), 2)

        cb.moveCurrent(by: 2)
        XCTAssertEqual(cb.value(), 1)

        cb.moveCurrent(by: -2)
        XCTAssertEqual(cb.value(), 2)
    }

    func testCircularBufferRemove() {
        let cb = CircularBuffer<Int>()
        cb.insert(value: 0)
        cb.insert(value: 1)
        cb.insert(value: 2)

        let removed = cb.remove()
        XCTAssertEqual(removed, 2)
        XCTAssertEqual(cb.value(), 1)

        cb.moveCurrent(by: 1)
        XCTAssertEqual(cb.value(), 0)

        cb.moveCurrent(by: 1)
        XCTAssertEqual(cb.value(), 1)
    }

    func testCircularBufferEmpty() {
        let cb = CircularBuffer<Int>()
        XCTAssertEqual(cb.isEmpty, true)

        cb.insert(value: 0)
        XCTAssertEqual(cb.isEmpty, false)

        cb.remove()
        XCTAssertEqual(cb.isEmpty, true)
    }
}
