//
//  String.swift
//
//  Advent of Code Tools
//

import Foundation

extension String {
    public func trimmed() -> String {
        trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
    }

    public mutating func trim() {
        self = self.trimmed()
    }

    public func charAt(_ offset: Int) -> String {
        let ch = self[index(startIndex, offsetBy: offset)]
        return String(ch)
    }

    public func indexOf(_ substr: String) -> Int? {
        guard let range = self.range(of: substr) else {
            return nil
        }

        return distance(from: startIndex, to: range.lowerBound)
    }

    public func indicesOf(_ substr: String) -> [Int] {
        var result = [Int]()
        var searchRange = startIndex..<endIndex
        while let r = self.range(of: substr, range: searchRange) {
            result.append(distance(from: startIndex, to: r.lowerBound))
            searchRange = index(r.lowerBound, offsetBy: 1)..<endIndex
        }
        return result
    }
}
