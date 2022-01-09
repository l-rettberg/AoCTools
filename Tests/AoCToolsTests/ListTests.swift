//
//  ListTests.swift
//  
//
//  Created by Gereon Steffens on 09.01.22.
//

import XCTest
import AoCTools

class ListTests: XCTestCase {
    func testList() throws {
        var list = List([1,2,3,4])

        XCTAssertEqual(list.first, 1)
        XCTAssertEqual(list.last, 4)
        XCTAssertEqual(list.count, 4)

        list.removeLast()
        XCTAssertEqual(list.count, 3)
        XCTAssertEqual(list.first, 1)
        XCTAssertEqual(list.last, 3)

        list.removeFirst()
        XCTAssertEqual(list.count, 2)
        XCTAssertEqual(list.first, 2)
        XCTAssertEqual(list.last, 3)
    }

    func testListCopyOnWrite() {
        let list = List([1,2,3,4])

        var l2 = list
        l2.removeFirst()
        l2.removeLast()

        XCTAssertEqual(l2.first, 2)
        XCTAssertEqual(l2.last, 3)
        XCTAssertEqual(l2.count, 2)

        XCTAssertEqual(list.first, 1)
        XCTAssertEqual(list.last, 4)
        XCTAssertEqual(list.count, 4)
    }
}
