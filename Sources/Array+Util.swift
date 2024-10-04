//
//  Array+Map.swift
//
//  Advent of Code Tools
//

// make a set
extension Array where Element: Hashable {
    @inlinable
    public func makeSet() -> Set<Element> {
        Set(self)
    }
}
