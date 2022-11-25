//
//  Stack.swift
//
//  Advent of Code Tools
//

/// A simple FIFO collection of elements
public struct Stack<Element> {
    private var storage: [Element]

    public init() {
        storage = []
    }

    /// Return the number of element in this stack
    public var count: Int { storage.count }

    /// A Boolean value indication whether the stack is empty
    public var isEmpty: Bool { storage.isEmpty }

    /// Add an element at the top of stack.
    public mutating func push(_ element: Element) {
        storage.append(element)
    }

    /// Remove the element at the top of the stack and return it.
    /// For an empty stack, return `nil`.
    @discardableResult
    public mutating func pop() -> Element? {
        if storage.isEmpty {
            return nil
        }
        return storage.removeLast()
    }

    /// Return the top element of the stack without removing it.
    /// For an empty stack, return `nil`.
    public func peek() -> Element? {
        storage.last
    }
}
