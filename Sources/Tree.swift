//
//  Tree.swift
//  
//  Advent of Code Tools
//

import Foundation

public class Tree<T> {
    public typealias Node = TreeNode<T>

    public let root: Node

    public var count: Int {
        root.count
    }
    
    public init(root: Node) {
        self.root = root
    }

    public func visitAll(_ closure: (_ node: Node, _ level: Int) -> Void) {
        root.visitAll(closure)
    }

    public func reduce<Result>(_ initialResult: Result,
                               _ nextPartialResult: (Result, T) -> Result
    ) -> Result {
        root.reduce(initialResult, nextPartialResult)
    }

    public func reduce<Result>(into result: Result,
                               _ updateAccumulatingResult: (inout Result, T) -> (Void)
    ) -> Result {
        root.reduce(into: result, updateAccumulatingResult)
    }

    public func first(where predicate: (T) -> Bool) -> Node? {
        root.first(where: predicate)
    }

    public func filter(where predicate: (T) -> Bool) -> [Node] {
        root.filter(where: predicate)
    }
}

extension Tree where T: Hashable {
    public func hash(into hasher: inout Hasher) {
        hasher.combine(root)
    }
}

extension Tree where T: CustomStringConvertible {
    public func print() {
        root.print()
    }
}

extension Tree where T: Equatable {
    public func level(of node: Node) -> Int? {
        level(of: node.value)
    }

    public func level(of value: T) -> Int? {
        guard let node = root.first(where: { $0 == value }) else {
            return nil
        }

        var level = 0
        var n: Node? = node
        while n?.parent != nil {
            n = n?.parent
            level += 1
        }
        return level
    }

    public func lowestCommonAncestor(of node1: Node, and node2: Node) -> Node {
        lowestCommonAncestor(of: node1.value, and: node2.value)
    }

    public func lowestCommonAncestor(of value1: T, and value2: T) -> Node {
        let path1 = path(from: value1, to: root)
        let path2 = path(from: value2, to: root)

        assert(!path1.isEmpty)
        assert(!path2.isEmpty)

        var i = path1.count - 1
        var j = path2.count - 1
        while i >= 0 && j >= 0 && path1[i].value == path2[j].value {
            i -= 1
            j -= 1
        }

        return path1[i+1]
    }

    private func path(from value: T, to node: Node) -> [Node] {
        if node.value == value {
            return [node]
        }

        for child in node.children {
            var path = path(from: value, to: child)
            if !path.isEmpty {
                path.append(node)
                return path
            }
        }

        return []
    }
}
