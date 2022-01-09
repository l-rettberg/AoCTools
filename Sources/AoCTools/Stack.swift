//
//  Stack.swift
//  
//  Advent of Code 2016
//

/// A Stack (FIFO) collection of elements
struct Stack<Element> {
    private var storage: [Element]

    init() {
        storage = []
    }

    /// Return the number of element in this stack
    var count: Int { storage.count }

    /// A Boolean value indication whether the stack is empty
    var isEmpty: Bool { storage.isEmpty }

    /// Add an element at the top of stack.
    mutating func push(_ element: Element) {
        storage.append(element)
    }

    /// Remove the element at the top of the stack and return it.
    /// Popping from an empty stack results in a crash.
    mutating func pop() -> Element {
        storage.removeLast()
    }

    /// Return the top element of the stack, without removing it.
    /// For an empty stack, return `nil`.
    func peek() -> Element? {
        storage.last
    }
}
