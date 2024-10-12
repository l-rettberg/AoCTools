//
//  CircularBufferTests.swift
//  
//  Advent of Code tools
//

import Testing
import AoCTools

@Suite
struct CircularBufferTests {
    @Test func testCircularBuffer() {
        let cb = CircularBuffer<Int>()
        cb.insert(value: 0)
        #expect(cb.value() == 0)

        cb.insert(value: 1)
        #expect(cb.value() == 1)

        cb.insert(value: 2)
        #expect(cb.value() == 2)

        cb.moveCurrent(by: 1)
        #expect(cb.value() == 0)

        cb.moveCurrent(by: 1)
        #expect(cb.value() == 1)

        cb.moveCurrent(by: 1)
        #expect(cb.value() == 2)

        cb.moveCurrent(by: 2)
        #expect(cb.value() == 1)

        cb.moveCurrent(by: -2)
        #expect(cb.value() == 2)
    }

    @Test func testCircularBufferRemove() {
        let cb = CircularBuffer<Int>()
        cb.insert(value: 0)
        cb.insert(value: 1)
        cb.insert(value: 2)

        let removed = cb.remove()
        #expect(removed == 2)
        #expect(cb.value() == 1)

        cb.moveCurrent(by: 1)
        #expect(cb.value() == 0)

        cb.moveCurrent(by: 1)
        #expect(cb.value() == 1)
    }

    @Test func testCircularBufferEmpty() {
        let cb = CircularBuffer<Int>()
        #expect(cb.isEmpty)

        cb.insert(value: 0)
        #expect(!cb.isEmpty)

        cb.remove()
        #expect(cb.isEmpty)
    }
}
