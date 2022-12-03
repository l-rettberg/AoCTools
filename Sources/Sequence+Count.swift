//
//  Sequence+Count.swift
//
//  Advent of Code Tools
//

extension Sequence {
    public func count(where condition: (Element) -> Bool) -> Int {
        reduce(0) {
            $0 + (condition($1) ? 1 : 0)
        }
    }
}

extension Sequence {
    public func sumOf(_ keyPath: KeyPath<Element, Int>) -> Int {
        reduce(0) { $0 + $1[keyPath: keyPath] }
    }
}
