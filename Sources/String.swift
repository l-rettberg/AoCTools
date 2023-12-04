//
//  String.swift
//
//  Advent of Code Tools
//

import RegexBuilder

extension String {
    public func trimmed() -> String {
        trimmingCharacters(in: .whitespacesAndNewlines)
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

    public func substring(after separator: String) -> String {
        guard let index = indexOf(separator) else { return self }
        let start = self.index(startIndex, offsetBy: index + 1)
        return String(self[start..<endIndex])
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

    public func lastIndexOf(_ substr: String) -> Int? {
        guard let range = self.range(of: substr, options: .backwards) else {
            return nil
        }

        return distance(from: startIndex, to: range.lowerBound)
    }
}

// subscripts
extension String {
    public subscript(index: Int) -> String {
        charAt(index)
    }

    public subscript(range: ClosedRange<Int>) -> String {
        substring(range.lowerBound, range.upperBound - range.lowerBound + 1)
    }

    public subscript(range: Range<Int>) -> String {
        substring(range.lowerBound, range.upperBound - range.lowerBound)
    }
}

// splitting
extension String {
    public var lines: [String] {
        split(whereSeparator: \.isNewline).map { String($0) }
    }

    public func asInts(separator: String = ",") -> [Int] {
        tokenized(separator: separator).map { Int($0)! }
    }

    public func tokenized(separator: String = " ") -> [String] {
        split(separator: separator).map { String($0).trimmed() }
    }

    private static let regex = Regex {
        Capture {
            Optionally("-")
            ZeroOrMore(.digit)
        }
    }

    public func allInts() -> [Int] {
        ranges(of: Self.regex).compactMap { Int(self[$0]) }
    }
}
