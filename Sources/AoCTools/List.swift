//
//  List.swift
//
//  Advent of Code Tools
//

/// A doubly-linked list, adding/removing elements at start and end are O(1)
/// Follows the usual copy-on-write semantics for structs
public struct List<Element> {
    /// Return the number of element in this list
    public private(set) var count = 0

    public init() { }

    public init<S: Sequence>(_ elements: S) where S.Element == Element {
        elements.forEach { append($0) }
    }

    /// A Boolean value indication whether the list is empty
    public var isEmpty: Bool { head == nil }

    /// The first element or `nil`
    public var first: Element? { head?.element }

    /// The last element or `nil`
    public var last: Element? { tail?.element }

    /// Add an element to the front of the list
    public mutating func prepend(_ element: Element) {
        makeUnique()
        let node = ListNode(element)
        if head == nil {
            head = node
            tail = node
        } else {
            head?.prev = node
            node.next = head
            head = node
        }
        count += 1
    }

    /// Add an element to the end of the list
    public mutating func append(_ element: Element) {
        makeUnique()
        let node = ListNode(element)
        if tail == nil {
            head = node
            tail = node
        } else {
            node.prev = tail
            tail?.next = node
            tail = node
        }
        count += 1
    }

    /// Remove and return the element at the front of the list
    @discardableResult
    public mutating func removeFirst() -> Element? {
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
        return headNode?.element
    }

    /// Remove and return the element at the end of the list
    @discardableResult
    public mutating func removeLast() -> Element? {
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
        return tailNode?.element
    }

    // MARK: - internal storage
    private class ListNode {
        let element: Element
        var next: ListNode? = nil
        var prev: ListNode? = nil

        init(_ element: Element) {
            self.element = element
        }
    }

    private var head: ListNode? = nil
    private var tail: ListNode? = nil {
        didSet { sentinel.tail = tail }
    }

    // MARK: - Copy-on-write and deinit

    // we need a reference object both for `isKnownUniquelyReferenced` and
    // for implementing a deinit method that deinits all remaining elements
    private final class Sentinel {
        var tail: ListNode?

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
        guard !isUnique else { return }

        var newHead: ListNode? = nil
        var newTail: ListNode? = nil

        var node = head
        while node != nil {
            let copy = ListNode(node!.element)
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
