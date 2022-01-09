//
//  QueueTests.swift
//  
//
//  Created by Gereon Steffens on 09.01.22.
//

import XCTest
import AoCTools

class QueueTests: XCTestCase {
    func testQueue() throws {
        var queue = Queue<Int>()

        XCTAssertEqual(queue.count, 0)
        XCTAssertTrue(queue.isEmpty)

        queue.push(1)
        queue.push(2)
        XCTAssertEqual(queue.count, 2)
        XCTAssertFalse(queue.isEmpty)

        XCTAssertEqual(queue.peek(), 1)

        XCTAssertEqual(queue.pop(), 1)
        XCTAssertEqual(queue.count, 1)

        XCTAssertEqual(queue.pop(), 2)
        XCTAssertEqual(queue.count, 0)

        XCTAssertNil(queue.peek())
    }
}
