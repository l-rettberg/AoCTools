//
//  Array+Median.swift
//
//  Advent of Code Tools
//

// we need two implementations because there is no common protocol for numerics that supports division

extension Array where Element: BinaryInteger {
    public func median() -> Element {
        if count.isMultiple(of: 2) {
            let v1 = self[count / 2]
            let v2 = self[count / 2 - 1]
            return (v1 + v2) / 2
        } else {
            return self[count / 2]
        }
    }
}

extension Array where Element: FloatingPoint {
    public func median() -> Element {
        if count.isMultiple(of: 2) {
            let v1 = self[count / 2]
            let v2 = self[count / 2 - 1]
            return (v1 + v2) / 2
        } else {
            return self[count / 2]
        }
    }
}
