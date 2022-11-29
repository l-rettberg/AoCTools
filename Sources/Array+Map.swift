//
//  Array+Map.swift
//
//  Advent of Code Tools
//

extension Array {
    public func mapped<Value>(by keyPath: KeyPath<Element, Value>) -> [Value: Element] {
        let keys = self.map { $0[keyPath: keyPath] }
        return Dictionary(uniqueKeysWithValues: zip(keys, self))
    }
}
