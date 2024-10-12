//
//  StackTests.swift
//  
//  Advent of Code tools
//

import Testing
import AoCTools

@Suite
struct StackTests {
    @Test func testStack() throws {
        var stack = Stack<Int>()

        // swiftlint:disable:next empty_count
        #expect(stack.count == 0)
        #expect(stack.isEmpty)

        stack.push(1)
        stack.push(2)
        #expect(stack.count == 2)
        #expect(!stack.isEmpty)

        #expect(stack.peek() == 2)

        #expect(stack.pop() == 2)
        #expect(stack.count == 1)

        #expect(stack.pop() == 1)
        #expect(stack.isEmpty)

        #expect(stack.peek() == nil)
    }
}
