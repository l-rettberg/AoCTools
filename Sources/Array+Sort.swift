//
//  Array+Sort.swift
//
//  Advent of Code Tools
//

// Array.sort and Array.sorted using Keypaths,

extension Sequence {
    public func sorted<Value>(by keyPath: KeyPath<Element, Value>,
                              using valuesAreInIncreasingOrder: (Value, Value) throws -> Bool
    ) rethrows -> [Element] {
        try self.sorted(by: {
            try valuesAreInIncreasingOrder($0[keyPath: keyPath], $1[keyPath: keyPath])
        })
    }

    public func sorted<Value: Comparable>(by keyPath: KeyPath<Element, Value>) -> [Element] {
        self.sorted(by: keyPath, using: <)
    }
}

extension Array {
    public mutating func sort<Value>(by keyPath: KeyPath<Element, Value>,
                                     using valuesAreInIncreasingOrder: (Value, Value) throws -> Bool) rethrows {
        self = try self.sorted(by: keyPath, using: valuesAreInIncreasingOrder)
    }

    public mutating func sort<Value: Comparable>(by keyPath: KeyPath<Element, Value>) {
        self = self.sorted(by: keyPath)
    }
}
