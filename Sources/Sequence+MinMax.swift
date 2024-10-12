//
//  Sequence+MinMax.swift
//  
//  Advent of Code Tools
//

extension Sequence {
    public func min<Value: Comparable>(of keyPath: KeyPath<Element, Value>) -> Value? {
        let element = self.min(by: { $0[keyPath: keyPath] < $1[keyPath: keyPath] })
        return element?[keyPath: keyPath]
    }

    public func max<Value: Comparable>(of keyPath: KeyPath<Element, Value>) -> Value? {
        let element = self.max(by: { $0[keyPath: keyPath] < $1[keyPath: keyPath] })
        return element?[keyPath: keyPath]
    }
}

extension Sequence where Element: Comparable {
    public func minAndMax<Value: Comparable>(of keyPath: KeyPath<Element, Value>) -> (Value, Value)? {
        var iter = makeIterator()
        guard let first = iter.next() else { return nil }

        var min = first[keyPath: keyPath]
        var max = min
        while let elem = iter.next() {
            let value = elem[keyPath: keyPath]
            if value < min { min = value }
            if value > max { max = value }
        }
        return (min, max)
    }
}
