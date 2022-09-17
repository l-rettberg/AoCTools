//
//  StackTests.swift
//  
//
//  Created by Gereon Steffens on 09.01.22.
//

import XCTest
import AoCTools

class StackTests: XCTestCase {
    func testStack() throws {
        var stack = Stack<Int>()

        XCTAssertEqual(stack.count, 0)
        XCTAssertTrue(stack.isEmpty)

        stack.push(1)
        stack.push(2)
        XCTAssertEqual(stack.count, 2)
        XCTAssertFalse(stack.isEmpty)

        XCTAssertEqual(stack.peek(), 2)

        XCTAssertEqual(stack.pop(), 2)
        XCTAssertEqual(stack.count, 1)

        XCTAssertEqual(stack.pop(), 1)
        XCTAssertEqual(stack.count, 0)

        XCTAssertNil(stack.peek())
    }
}
