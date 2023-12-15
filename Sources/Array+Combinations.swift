//
//  Array+Combinations.swift
//  
//  AoCTools
//

import Foundation

extension Array {
    private func combinations(of elements: ArraySlice<Element>, count: Int) -> [[Element]] {
        // swiftlint:disable:next empty_count
        guard count > 0 else { return [[]] }
        guard let first = elements.first else { return [] }

        let head = [first]
        let combos = combinations(of: elements.dropFirst(), count: count - 1)
        let withHead = combos.map { head + $0 }
        return withHead + combinations(of: elements.dropFirst(), count: count)
    }

    /// generate all N-combinatons of the values of `self`
    ///
    /// for example, given the array `[1,2,3]`, and `count` 2, the return value will be
    /// `[1,2]`, `[1,3]`, `[2,3]`
    ///
    /// - Parameter count: the number of elements to combine
    public func combinations(of count: Int) -> [[Element]] {
        return combinations(of: ArraySlice(self), count: count)
    }
}
