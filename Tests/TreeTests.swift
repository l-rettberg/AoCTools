//
//  TreeTests.swift
//  
//  Advent of Code tools
//

import Testing
import AoCTools

@Suite
struct TreeTests {

    @Test func testTreeNodes() {
        let node1 = TreeNode(1)
        let node2 = TreeNode(2)
        let node3 = TreeNode(3)
        node2.add(node3)
        node1.add(node2)
        #expect(node1.parent == nil)
        #expect(node2.parent == node1)
        #expect(node3.parent == node2)
    }

    @Test func testTreeNodes2() {
        let node3 = TreeNode(3)
        let node2 = TreeNode(2, children: [node3])
        let node1 = TreeNode(1, children: [node2])
        #expect(node1.parent == nil)
        #expect(node2.parent == node1)
        #expect(node3.parent == node2)
    }

    @Test func testTreeCount() {
        let node1 = TreeNode(1)
        let node2 = TreeNode(2)
        let node3 = TreeNode(3)
        node2.add(node3)
        node1.add(node2)
        #expect(node1.count == 3)
        #expect(node2.count == 2)
        #expect(node3.count == 1)

        let tree = Tree(root: node1)
        #expect(tree.count == 3)
    }

    @Test func testTreeVisit() {
        let node1 = TreeNode(1)
        let node2 = TreeNode(2)
        let node3 = TreeNode(3)
        node2.add(node3)
        node1.add(node2)

        var visits = [Int]()
        node1.visitAll { node, _ in
            visits.append(node.value)
        }
        #expect(visits == [1, 2, 3])
    }

    @Test func testTreeVisit2() {
        let node2 = TreeNode(2, children: [TreeNode(3), TreeNode(4)])
        let node1 = TreeNode(1, children: [node2])

        var visits = [Int]()
        node1.visitAll { node, level in
            visits.append(node.value * level)
        }
        #expect(visits == [0, 2, 6, 8])
    }

    @Test func testTreeVisit3() {
        let node3 = TreeNode(3, children: [TreeNode(6), TreeNode(7)])
        let node2 = TreeNode(2, children: [TreeNode(4), TreeNode(5)])
        let node1 = TreeNode(1, children: [node2, node3])

        var visits = [Int]()
        node1.visitAll { node, _ in
            visits.append(node.value)
        }

        #expect(visits == [1, 2, 4, 5, 3, 6, 7]) // DFS
    }

    @Test func testTreeBFS() {
        let node3 = TreeNode(3, children: [TreeNode(6), TreeNode(7)])
        let node2 = TreeNode(2, children: [TreeNode(4), TreeNode(5)])
        let node1 = TreeNode(1, children: [node2, node3])

        let bfs = node1.breadthFirstSearchAll { _ in true }
        let values = bfs.map { $0.value }
        #expect(values == [1, 2, 3, 4, 5, 6, 7]) // BFS
    }

    @Test func testTreeReduce() {
        let node1 = TreeNode(1)
        let node2 = TreeNode(2)
        let node3 = TreeNode(3)
        let node4 = TreeNode(4)
        node2.add(node3)
        node2.add(node4)
        node1.add(node2)

        let sum = node1.reduce(0, +)
        #expect(sum == 10)

        let tree = Tree(root: node1)
        #expect(tree.reduce(0, +) == 10)
    }

    @Test func testTreeReduceInto() {
        let node1 = TreeNode(1)
        let node2 = TreeNode(2)
        let node3 = TreeNode(3)
        let node4 = TreeNode(4)
        node2.add(node3)
        node2.add(node4)
        node1.add(node2)

        let sum = node1.reduce(into: 0, +=)
        #expect(sum == 10)

        let tree = Tree(root: node1)
        #expect(tree.reduce(into: 0, +=) == 10)
    }

    @Test func testTreeFind() {
        let node1 = TreeNode(1)
        let node2 = TreeNode(2)
        let node3 = TreeNode(3)
        let node4 = TreeNode(4)
        let node5 = TreeNode(1)
        node2.add(node3)
        node2.add(node4)
        node1.add(node2)
        node1.add(node5)

        #expect(node1.first { $0 == 1} == node1)
        #expect(node1.first { $0 == 4} == node4)
        #expect(node1.first { $0 == 99} == nil)
    }

    @Test func testTreeFindIterative() {
        let node1 = TreeNode(1)
        let node2 = TreeNode(2)
        let node3 = TreeNode(3)
        let node4 = TreeNode(4)
        let node5 = TreeNode(1)
        node2.add(node3)
        node2.add(node4)
        node1.add(node2)
        node1.add(node5)

        #expect(node1.firstIterative { $0 == 1} == node1)
        #expect(node1.firstIterative { $0 == 4} == node4)
        #expect(node1.firstIterative { $0 == 99} == nil)
    }

    @Test func testTreeFilter() {
        let node1 = TreeNode(1)
        let node2 = TreeNode(2)
        let node3 = TreeNode(3)
        let node4 = TreeNode(4)
        let node5 = TreeNode(1)
        node2.add(node3)
        node2.add(node4)
        node1.add(node2)
        node1.add(node5)

        #expect(node1.filter { $0 == 1} == [node1, node5])
        #expect(node1.filter { $0 == 4} == [node4])
        #expect(node1.filter { $0 == 99}.isEmpty)
    }

    @Test func testTreeFilterIterative() {
        let node1 = TreeNode(1)
        let node2 = TreeNode(2)
        let node3 = TreeNode(3)
        let node4 = TreeNode(4)
        let node5 = TreeNode(1)
        node2.add(node3)
        node2.add(node4)
        node1.add(node2)
        node1.add(node5)

        #expect(node1.filterIterative { $0 == 1} == [node1, node5])
        #expect(node1.filterIterative { $0 == 4} == [node4])
        #expect(node1.filterIterative { $0 == 99}.isEmpty)
    }

    @Test func testTreeDelete() {
        let node1 = TreeNode(1)
        let node2 = TreeNode(2)
        let node3 = TreeNode(3)
        let node4 = TreeNode(4)
        let node5 = TreeNode(1)
        node2.add(node3)
        node2.add(node4)
        node1.add(node2)
        node1.add(node5)

        #expect(node1.count == 5)
        #expect(node5.parent == node1)
        node5.delete()
        #expect(node5.parent == nil)
        #expect(node1.count == 4)

        node5.delete()
        #expect(node1.count == 4)

        node2.delete()
        #expect(node1.count == 1)

        #expect(node2.count == 3)
    }

    @Test func testTreeLevel() {
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
        #expect(tree.level(of: 1) == 0)
        #expect(tree.level(of: 2) == 1)
        #expect(tree.level(of: 3) == 2)
        #expect(tree.level(of: 4) == 2)
        #expect(tree.level(of: 5) == 1)
        #expect(tree.level(of: 6) == nil)
    }

    @Test func testTreeCommonAncestor() {
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
        #expect(tree.lowestCommonAncestor(of: 3, and: 5) == node3)
    }

    @Test func testTreeCommonAncestor2() {
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
        #expect(tree.lowestCommonAncestor(of: "E", and: "G") == node2)
    }
}
