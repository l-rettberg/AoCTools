//
//  Tree.swift
//
//  Advent of Code Tools
//

public struct TreeNode<Value> {
    public let value: Value
    private(set) public var children: [TreeNode]

    public var count: Int {
        1 + children.reduce(0) { $0 + $1.count }
    }

    public init(_ value: Value, children: [TreeNode] = []) {
        self.value = value
        self.children = children
    }

    public mutating func add(_ node: TreeNode) {
        children.append(node)
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
}

extension TreeNode: Equatable where Value: Equatable { }

extension TreeNode: Hashable where Value: Hashable { }

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

