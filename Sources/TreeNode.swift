//
//  TreeNode.swift
//
//  Advent of Code Tools
//

public class TreeNode<Value> {
    public let value: Value
    private(set) public var children: [TreeNode]
    private(set) public var parent: TreeNode?

    public var count: Int {
        1 + children.reduce(0) { $0 + $1.count }
    }

    public init(_ value: Value, children: [TreeNode] = []) {
        self.value = value
        self.parent = nil
        self.children = children
        children.forEach { $0.parent = self }
    }

    public func add(_ node: TreeNode) {
        children.append(node)
        node.parent = self
    }

    public func delete() {
        guard
            let parent = self.parent,
            let index = parent.children.firstIndex(where: { $0 === self })
        else {
            return
        }

        parent.children.remove(at: index)
        self.parent = nil
    }

    /// recursively visit all nodes in the tree, depth-first
    /// - Parameters:
    ///   - closure: called for every node in the tree
    ///   - node: the visited node
    ///   - level: the depth of the node (root is at 0)
    public func visitAll(_ closure: (_ node: TreeNode, _ level: Int) -> Void) {
        visitAll(at: 0, closure)
    }

    private func visitAll(at level: Int, _ closure: (TreeNode, Int) -> Void) {
        closure(self, level)
        children.forEach { $0.visitAll(at: level + 1, closure) }
    }

    public func reduce<Result>(_ initialResult: Result,
                               _ nextPartialResult: (Result, Value) -> Result
    ) -> Result {
        var result = nextPartialResult(initialResult, value)
        children.forEach {
            result = $0.reduce(result, nextPartialResult)
        }
        return result
    }

    public func reduce<Result>(into result: Result,
                               _ updateAccumulatingResult: (inout Result, Value) -> (Void)
    ) -> Result {
        var result = result
        updateAccumulatingResult(&result, value)
        children.forEach {
            result = $0.reduce(into: result, updateAccumulatingResult)
        }
        return result
    }
}

// MARK: - DFS recursive
extension TreeNode {
    /// Perform a recursive depth-first search for the node where `predicate` returns true
    /// - Parameter predicate: a closure to check if the `value` of a node is a match
    /// - Returns: the first node that satisfies `predicate`, or `nil` if no such node is found
    public func first(where predicate: (Value) -> Bool) -> TreeNode? {
        if predicate(value) {
            return self
        }
        for child in children {
            if let found = child.first(where: predicate) {
                return found
            }
        }
        return nil
    }

    /// Perform a recursive depth-first search for all nodes where `predicate` returns true
    public func filter(where predicate: (Value) -> Bool) -> [TreeNode] {
        var result = [TreeNode]()
        filter(where: predicate, result: &result)
        return result
    }

    private func filter(where predicate: (Value) -> Bool, result: inout [TreeNode]) {
        if predicate(value) {
            result.append(self)
        }
        children.forEach {
            $0.filter(where: predicate, result: &result)
        }
    }
}

// MARK: - DFS iterative
extension TreeNode {
    public func firstIterative(where predicate: (Value) -> Bool) -> TreeNode? {
        var list = List<TreeNode>()
        list.append(self)

        while let current = list.removeFirst() {
            if predicate(current.value) {
                return current
            }
            list.prepend(contentsOf: current.children)
        }
        return nil
    }

    public func filterIterative(where predicate: (Value) -> Bool) -> [TreeNode] {
        var list = List<TreeNode>()
        var result = [TreeNode]()
        list.append(self)

        while let current = list.removeFirst() {
            if predicate(current.value) {
                result.append(current)
            }
            list.prepend(contentsOf: current.children)
        }
        return result
    }
}

// MARK: - BFS
extension TreeNode {
    /// Perform a breadth-first search for the node where `predicate` returns true
    /// - Parameter predicate: a closure to check if the `value` of a node is a match
    /// - Returns: the first node that satisfies `predicate`, or `nil` if no such node is found
    public func breadthFirstSearch(_ predicate: (Value) -> Bool) -> TreeNode? {
        var queue = Queue<TreeNode>()
        queue.push(self)

        while let current = queue.pop() {
            Swift.print("checking \(current.value)")
            if predicate(current.value) {
                return current
            }
            queue.push(contentsOf: current.children)
        }
        return nil
    }

    public func breadthFirstSearchAll(_ predicate: (Value) -> Bool) -> [TreeNode]
    {
        var result = [TreeNode]()
        var queue = Queue<TreeNode>()
        queue.push(self)

        while let current = queue.pop() {
            if predicate(current.value) {
                result.append(current)
            }
            queue.push(contentsOf: current.children)
        }
        return result
    }

}

extension TreeNode: Equatable where Value: Equatable {
    public static func == (lhs: TreeNode, rhs: TreeNode) -> Bool {
        lhs.value == rhs.value && lhs.children == rhs.children
    }
}

extension TreeNode: Hashable where Value: Hashable {
    public func hash(into hasher: inout Hasher) {
        hasher.combine(value)
        hasher.combine(children)
    }
}

extension TreeNode where Value: CustomStringConvertible {
    public func print() {
        Self.printTree(at: self, level: 0)
    }

    private static func printTree(at node: TreeNode, level: Int) {
        let indent = String(repeating: " ", count: level * 2)
        Swift.print(indent, terminator: "")
        Swift.print(node.value)
        for child in node.children {
            printTree(at: child, level: level + 1)
        }
    }
}

