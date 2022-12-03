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
