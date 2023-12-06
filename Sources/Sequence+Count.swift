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

    public func productOf(_ keyPath: KeyPath<Element, Int>) -> Int {
        reduce(1) { $0 * $1[keyPath: keyPath]}
    }
}

extension Sequence where Element == Int {
    public func sum() -> Int { reduce(0, +) }
    public func product() -> Int { reduce(1, *) }
}
