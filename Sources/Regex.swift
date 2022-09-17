//
//  Regex.swift
//
//  Advent of Code Tools
//

import Foundation

public struct Regex {
    let regex: NSRegularExpression

    public init(pattern: String) {
        regex = try! NSRegularExpression(pattern: pattern)
    }

    public func matches(in string: String) -> [String] {
        let range = NSRange(location: 0, length: string.count)
        let matches = regex.matches(in: string, options: [], range: range)

        guard let match = matches.last else { return [] }

        return (1..<match.numberOfRanges)
            .compactMap { Range(match.range(at: $0), in: string) }
            .map { String(string[$0]) }
            .filter { !$0.isEmpty }
    }
}
