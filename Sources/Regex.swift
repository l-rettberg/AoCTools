//
//  Regex.swift
//
//  Advent of Code Tools
//

public extension Regex where Output == AnyRegexOutput {

    init(pattern: String) {
        // swiftlint:disable:next force_try
        try! self.init(pattern)
    }

    func matches(in string: String) -> [String] {
        // swiftlint:disable:next force_try
        guard let matches = try! self.wholeMatch(in: string) else {
            return []
        }

        return (1..<matches.count)
            .compactMap { matches[$0].value as? Substring }
            .map { String($0) }
            .filter { !$0.isEmpty }
    }
}
