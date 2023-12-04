//
//  CircularBuffer.swift
//  
//  Advent of Code tools
//

/// Circular buffer of unlimited size
/// Keeps track of a "current" position which can be moved forwards/clockwise or backwards/counterclockwise
public class CircularBuffer<T> {
    private class Node {
        let value: T
        var next: Node?
        var prev: Node?

        init(value: T) {
            self.value = value
            self.next = nil
            self.prev = nil
        }
    }

    private var current: Node?

    public init() {}

    deinit {
        var n: Node? = current

        while n != nil {
            let next = n?.next
            n?.prev = nil
            n?.next = nil
            n = next
        }
    }

    public var isEmpty: Bool { current == nil }
    public private(set) var count = 0

    /// Add a new value just after the current position,
    /// moves the current position to the newly added node
    public func insert(value: T) {
        let node = Node(value: value)

        if current == nil {
            current = node
            node.next = current
            node.prev = current
        } else {
            node.next = current?.next
            node.prev = current
            current?.next?.prev = node
            current?.next = node
            current = node
        }
        count += 1
    }

    /// Remove the current node and return its value. It is an error to call this method on an empty CircularBuffer
    @discardableResult
    public func remove() -> T {
        count -= 1
        let node = current

        // swiftlint:disable:next empty_count
        if count == 0 {
            current = nil
        } else {
            current?.prev?.next = current?.next
            current?.next?.prev = current?.prev
            current = node?.prev
        }
        node?.prev = nil
        node?.next = nil
        return node!.value
    }

    /// move the "current" node forward/clockwise (positive values of `step`) or backwards/counterclockwise (negative values)
    public func moveCurrent(by steps: Int) {
        for _ in 0..<abs(steps) {
            if steps > 0 {
                current = current?.next
            } else {
                current = current?.prev
            }
        }
    }

    /// return the value of the "current" node. It is an error to call this method on an empty CircularBuffer
    public func value() -> T {
        current!.value
    }
}
