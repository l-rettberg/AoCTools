//
//  List.swift
//
//  Advent of Code Tools
//

/// A doubly-linked list, adding/removing elements at start and end are O(1)
/// Follows the usual copy-on-write semantics for structs
public struct List<Element> {

    public class Node {
        public let value: Element
        public fileprivate(set) var next: Node?
        public fileprivate(set) var prev: Node?

        init(_ value: Element) {
            self.value = value
        }
    }

    /// Return the number of elements in this list
    public private(set) var count = 0

    public init() { }

    public init<S: Sequence>(_ elements: S) where S.Element == Element {
        elements.forEach { append($0) }
    }

    /// A Boolean value indication whether the list is empty
    public var isEmpty: Bool { head == nil }

    /// The first element or `nil`
    public var first: Element? { head?.value }

    /// The last element or `nil`
    public var last: Element? { tail?.value }

    /// Add an element to the front of the list
    public mutating func prepend(_ element: Element) {
        makeUnique()
        let node = Node(element)
        if head == nil {
            assert(tail == nil)
            head = node
            tail = node
        } else {
            head?.prev = node
            node.next = head
            head = node
        }
        count += 1
    }

    public mutating func prepend<S: Sequence>(contentsOf elements: S) where S.Element == Element {
        elements.forEach { prepend($0) }
    }

    /// Add an element to the end of the list
    public mutating func append(_ element: Element) {
        makeUnique()
        let node = Node(element)
        if tail == nil {
            assert(head == nil)
            head = node
            tail = node
        } else {
            node.prev = tail
            tail?.next = node
            tail = node
        }
        count += 1
    }

    public mutating func append<S: Sequence>(contentsOf elements: S) where S.Element == Element {
        elements.forEach { append($0) }
    }

    /// Remove and return the element at the front of the list
    @discardableResult
    public mutating func removeFirst() -> Element? {
        guard head != nil else {
            return nil
        }

        makeUnique()
        count -= 1
        let headNode = head
        head = head?.next
        head?.prev = nil
        if head == nil {
            tail = nil
        }
        headNode?.next = nil
        headNode?.prev = nil
        return headNode?.value
    }

    /// Remove and return the element at the end of the list
    @discardableResult
    public mutating func removeLast() -> Element? {
        guard tail != nil else {
            return nil
        }

        makeUnique()
        count -= 1
        let tailNode = tail
        tail = tail?.prev
        tail?.next = nil
        if tail == nil {
            head = nil
        }
        tailNode?.next = nil
        tailNode?.prev = nil
        return tailNode?.value
    }

    public mutating func remove(_ node: List.Node) {
        makeUnique()

        if node === head {
            assert(node.prev == nil)
            head = head?.next
            node.next = nil
            count -= 1
            if head == nil { tail = nil }
        } else if node === tail {
            assert(node.next == nil)
            tail = tail?.prev
            node.prev = nil
            count -= 1
            if tail == nil { head = nil }
        } else {
            assert(node.next != nil && node.prev != nil)
            node.prev?.next = node.next
            node.next?.prev = node.prev
            node.prev = nil
            node.next = nil
            count -= 1
        }
    }

    public private(set) var head: Node?
    public private(set) var tail: Node? {
        didSet { sentinel.tail = tail }
    }

    // MARK: - Copy-on-write and deinit

    // we need a reference object both for `isKnownUniquelyReferenced` and
    // for implementing a deinit method that deinits all remaining elements
    private final class Sentinel {
        var tail: Node?

        deinit {
            var t = tail
            while t != nil {
                t?.next = nil
                t = t?.prev
            }
        }
    }

    private var sentinel = Sentinel()

    private var isUnique: Bool {
        mutating get { isKnownUniquelyReferenced(&sentinel) }
    }

    private mutating func makeUnique() {
        guard !isUnique else {
            return
        }

        var newHead: Node?
        var newTail: Node?

        var node = head
        while node != nil {
            let copy = Node(node!.value)
            if newHead == nil {
                newHead = copy
            }
            copy.prev = newTail
            newTail?.next = copy
            newTail = copy

            node = node?.next
        }

        head = newHead
        tail = newTail
    }
}

extension List: Sequence {
    public func makeIterator() -> ListIterator<Element> {
        ListIterator(current: head)
    }
}

public class ListIterator<Element>: IteratorProtocol {
    private var current: List<Element>.Node?

    init(current: List<Element>.Node?) {
        self.current = current
    }

    public func next() -> Element? {
        let value = current?.value
        current = current?.next
        return value
    }
}
