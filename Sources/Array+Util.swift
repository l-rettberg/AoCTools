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

// return all adjacent pairs, ie. [1,2,3,4] will return [(1,2), (2,3), (3,4)]
extension Array {
    @inlinable
    public func adjacentPairs() -> [(Element, Element)] {
        zip(self, self.dropFirst()).map { ($0, $1) }
    }
}
