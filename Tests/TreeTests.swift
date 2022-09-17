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

        let tree = Tree(root: node1)
        XCTAssertEqual(tree.count, 3)
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

    func testTreeVisit3() {
        let node3 = TreeNode(3, children: [TreeNode(6), TreeNode(7)])
        let node2 = TreeNode(2, children: [TreeNode(4), TreeNode(5)])
        let node1 = TreeNode(1, children: [node2, node3])

        var visits = [Int]()
        node1.visitAll { node, level in
            visits.append(node.value)
        }

        XCTAssertEqual(visits, [1,2,4,5,3,6,7]) // DFS
    }

    func testTreeBFS() {
        let node3 = TreeNode(3, children: [TreeNode(6), TreeNode(7)])
        let node2 = TreeNode(2, children: [TreeNode(4), TreeNode(5)])
        let node1 = TreeNode(1, children: [node2, node3])

        let bfs = node1.breadthFirstSearchAll { _ in true }
        let values = bfs.map { $0.value }
        XCTAssertEqual(values, [1,2,3,4,5,6,7]) // BFS
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

        let tree = Tree(root: node1)
        XCTAssertEqual(tree.reduce(0, +), 10)
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

        let tree = Tree(root: node1)
        XCTAssertEqual(tree.reduce(into: 0, +=), 10)
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

    func testTreeLevel() {
        let node1 = TreeNode(1)
        let node2 = TreeNode(2)
        let node3 = TreeNode(3)
        let node4 = TreeNode(4)
        let node5 = TreeNode(5)
        node2.add(node3)
        node2.add(node4)
        node1.add(node2)
        node1.add(node5)

        let tree = Tree(root: node1)
        XCTAssertEqual(tree.level(of: 1), 0)
        XCTAssertEqual(tree.level(of: 2), 1)
        XCTAssertEqual(tree.level(of: 3), 2)
        XCTAssertEqual(tree.level(of: 4), 2)
        XCTAssertEqual(tree.level(of: 5), 1)
        XCTAssertEqual(tree.level(of: 6), nil)
    }

    func testTreeCommonAncestor() {
        let node1 = TreeNode(1)
        let node2 = TreeNode(2)
        let node3 = TreeNode(3)
        let node4 = TreeNode(4)
        let node5 = TreeNode(5)
        node4.add(node5)
        node3.add(node4)
        node2.add(node3)
        node1.add(node2)

        let tree = Tree(root: node1)
        XCTAssertEqual(tree.lowestCommonAncestor(of: 3, and: 5), node3)
    }

    func testTreeCommonAncestor2() {
        let node1 = TreeNode("A")
        let node2 = TreeNode("B")
        let node3 = TreeNode("C")
        let node4 = TreeNode("D")
        let node5 = TreeNode("E")
        node4.add(node5)
        node3.add(node4)
        node2.add(node3)
        node1.add(node2)

        let node6 = TreeNode("F")
        let node7 = TreeNode("G")
        node6.add(node7)
        node2.add(node6)

        let tree = Tree(root: node1)
        XCTAssertEqual(tree.lowestCommonAncestor(of: "E", and: "G"), node2)
    }
}
