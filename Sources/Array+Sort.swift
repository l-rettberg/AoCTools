//
//  Array+Sort.swift
//
//  Advent of Code Tools
//

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
    mutating public func sort<Value>(by keyPath: KeyPath<Element, Value>,
                                                 using valuesAreInIncreasingOrder: (Value, Value) throws -> Bool) rethrows {
        self = try self.sorted(by: keyPath, using: valuesAreInIncreasingOrder)
    }

    mutating public func sort<Value: Comparable>(by keyPath: KeyPath<Element, Value>) {
        self = self.sorted(by: keyPath)
    }
}
