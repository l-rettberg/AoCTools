//
//  Regex.swift
//
//  Advent of Code Tools
//

// swiftlint:disable force_try

public extension Regex where Output == AnyRegexOutput {

    init(pattern: String) {
        try! self.init(pattern)
    }

    func matches(in string: String) -> [String] {
        guard let matches = try! self.wholeMatch(in: string) else {
            return []
        }

        return (1..<matches.count)
            .compactMap { matches[$0].value as? Substring }
            .map { String($0) }
            .filter { !$0.isEmpty }
    }
}
