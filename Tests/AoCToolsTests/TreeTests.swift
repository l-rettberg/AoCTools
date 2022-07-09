//
//  TreeTests.swift
//  
//
//  Created by Gereon Steffens on 07.07.22.
//

import XCTest
import AoCTools

class TreeTests: XCTestCase {

    func testTreeNodes() {
        let node1 = TreeNode(1)
        let node2 = TreeNode(2)
        let node3 = TreeNode(3)
        node2.add(node3)
        node1.add(node2)
        XCTAssertEqual(node1.parent, nil)
        XCTAssertEqual(node2.parent, node1)
        XCTAssertEqual(node3.parent, node2)
    }

    func testTreeNodes2() {
        let node3 = TreeNode(3)
        let node2 = TreeNode(2, children: [node3])
        let node1 = TreeNode(1, children: [node2])
        XCTAssertEqual(node1.parent, nil)
        XCTAssertEqual(node2.parent, node1)
        XCTAssertEqual(node3.parent, node2)
    }

    func testTreeCount() {
        let node1 = TreeNode(1)
        let node2 = TreeNode(2)
        let node3 = TreeNode(3)
        node2.add(node3)
        node1.add(node2)
        XCTAssertEqual(node1.count, 3)
        XCTAssertEqual(node2.count, 2)
        XCTAssertEqual(node3.count, 1)
    }

    func testTreeVisit() {
        let node1 = TreeNode(1)
        let node2 = TreeNode(2)
        let node3 = TreeNode(3)
        node2.add(node3)
        node1.add(node2)

        var visits = [Int]()
        node1.visitAll { node, _ in
            visits.append(node.value)
        }
        XCTAssertEqual(visits, [1,2,3])
    }

    func testTreeVisit2() {
        let node2 = TreeNode(2, children: [TreeNode(3), TreeNode(4)])
        let node1 = TreeNode(1, children: [node2])

        var visits = [Int]()
        node1.visitAll { node, level in
            visits.append(node.value * level)
        }
        XCTAssertEqual(visits, [0,2,6,8])
    }

    func testTreeReduce() {
        let node1 = TreeNode(1)
        let node2 = TreeNode(2)
        let node3 = TreeNode(3)
        let node4 = TreeNode(4)
        node2.add(node3)
        node2.add(node4)
        node1.add(node2)

        let sum = node1.reduce(0, +)
        XCTAssertEqual(sum, 10)
    }

    func testTreeReduceInto() {
        let node1 = TreeNode(1)
        let node2 = TreeNode(2)
        let node3 = TreeNode(3)
        let node4 = TreeNode(4)
        node2.add(node3)
        node2.add(node4)
        node1.add(node2)

        let sum = node1.reduce(into: 0, +=)
        XCTAssertEqual(sum, 10)
    }

    func testTreeFind() {
        let node1 = TreeNode(1)
        let node2 = TreeNode(2)
        let node3 = TreeNode(3)
        let node4 = TreeNode(4)
        let node5 = TreeNode(1)
        node2.add(node3)
        node2.add(node4)
        node1.add(node2)
        node1.add(node5)

        XCTAssertEqual(node1.first { $0 == 1}, node1)
        XCTAssertEqual(node1.first { $0 == 4}, node4)
        XCTAssertEqual(node1.first { $0 == 99}, nil)
    }

    func testTreeFilter() {
        let node1 = TreeNode(1)
        let node2 = TreeNode(2)
        let node3 = TreeNode(3)
        let node4 = TreeNode(4)
        let node5 = TreeNode(1)
        node2.add(node3)
        node2.add(node4)
        node1.add(node2)
        node1.add(node5)

        XCTAssertEqual(node1.filter { $0 == 1}, [node1, node5])
        XCTAssertEqual(node1.filter { $0 == 4}, [node4])
        XCTAssertEqual(node1.filter { $0 == 99}, [])
    }

    func testTreeDelete() {
        let node1 = TreeNode(1)
        let node2 = TreeNode(2)
        let node3 = TreeNode(3)
        let node4 = TreeNode(4)
        let node5 = TreeNode(1)
        node2.add(node3)
        node2.add(node4)
        node1.add(node2)
        node1.add(node5)

        XCTAssertEqual(node1.count, 5)
        XCTAssertEqual(node5.parent, node1)
        node5.delete()
        XCTAssertEqual(node5.parent, nil)
        XCTAssertEqual(node1.count, 4)

        node5.delete()
        XCTAssertEqual(node1.count, 4)

        node2.delete()
        XCTAssertEqual(node1.count, 1)

        XCTAssertEqual(node2.count, 3)
    }
}
