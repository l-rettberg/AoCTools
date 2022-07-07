//
//  TreeTests.swift
//  
//
//  Created by Gereon Steffens on 07.07.22.
//

import XCTest
import AoCTools

class TreeTests: XCTestCase {

    func testTreeCount() {
        var node1 = TreeNode(1)
        var node2 = TreeNode(2)
        let node3 = TreeNode(3)
        node2.add(node3)
        node1.add(node2)
        XCTAssertEqual(node1.count, 3)
        XCTAssertEqual(node2.count, 2)
        XCTAssertEqual(node3.count, 1)
    }

    func testTreeVisit() {
        var node1 = TreeNode(1)
        var node2 = TreeNode(2)
        let node3 = TreeNode(3)
        node2.add(node3)
        node1.add(node2)

        var visits = [Int]()
        node1.visitAll {
            visits.append($0)
        }
        XCTAssertEqual(visits, [1,2,3])
    }

    func testTreeVisit2() {
        var node1 = TreeNode(1)
        var node2 = TreeNode(2)
        let node3 = TreeNode(3)
        let node4 = TreeNode(4)
        node2.add(node3)
        node2.add(node4)
        node1.add(node2)

        var visits = [Int]()
        node1.visitAll {
            visits.append($0)
        }
        XCTAssertEqual(visits, [1,2,3,4])
    }

    func testTreeReduce() {
        var node1 = TreeNode(1)
        var node2 = TreeNode(2)
        let node3 = TreeNode(3)
        let node4 = TreeNode(4)
        node2.add(node3)
        node2.add(node4)
        node1.add(node2)

        let sum = node1.reduce(0, +)
        XCTAssertEqual(sum, 10)
    }

    func testTreeReduceInto() {
        var node1 = TreeNode(1)
        var node2 = TreeNode(2)
        let node3 = TreeNode(3)
        let node4 = TreeNode(4)
        node2.add(node3)
        node2.add(node4)
        node1.add(node2)

        let sum = node1.reduce(into: 0, +=)
        XCTAssertEqual(sum, 10)
    }

}
