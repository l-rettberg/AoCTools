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

    public func substring(_ start: Int, _ len: Int) -> String {
        let end = index(startIndex, offsetBy: start + len)
        let start = index(startIndex, offsetBy: start)
        return String(self[start..<end])
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

// subscripts
extension String {
    public subscript(index: Int) -> String {
        get { charAt(index) }
    }

    public subscript(range: ClosedRange<Int>) -> String {
        get { substring(range.lowerBound, range.upperBound - range.lowerBound + 1) }
    }

    public subscript(range: Range<Int>) -> String {
        get { substring(range.lowerBound, range.upperBound - range.lowerBound)  }
    }
}

// splitting
extension String {
    var lines: [String] {
        components(separatedBy: "\n")
    }

    func asInts(separator: String = ",") -> [Int] {
        tokenized(separator: separator).map { Int($0)! }
    }

    func tokenized(separator: String = " ") -> [String] {
        self.components(separatedBy: separator).map { String($0) }
    }
}
