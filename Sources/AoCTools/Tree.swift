//
//  Tree.swift
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
        self.children = children
        self.parent = nil
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

    public func visitAll(_ closure: (Value) -> Void) {
        closure(value)
        children.forEach { $0.visitAll(closure) }
    }

    public func reduce<Result>(_ initialResult: Result,
                               _ nextPartialResult: (Result, Value) -> Result)
    -> Result {
        var result = nextPartialResult(initialResult, value)
        children.forEach {
            result = $0.reduce(result, nextPartialResult)
        }
        return result
    }

    public func reduce<Result>(into result: Result,
                               _ updateAccumulatingResult: (inout Result, Value) -> (Void))
    -> Result {
        var result = result
        updateAccumulatingResult(&result, value)
        children.forEach {
            result = $0.reduce(into: result, updateAccumulatingResult)
        }
        return result
    }

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

    public func filter(where predicate: (Value) -> Bool) -> [TreeNode] {
        var result = [TreeNode]()
        filter(where: predicate, storeIn: &result)
        return result
    }

    public func filter(where predicate: (Value) -> Bool, storeIn result: inout [TreeNode]) {
        if predicate(value) {
            result.append(self)
        }
        children.forEach {
            $0.filter(where: predicate, storeIn: &result)
        }
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

