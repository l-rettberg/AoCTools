//
//  Pair.swift
//  
//  Advent of Code Tools
//

public struct Pair<T, U> {
    public let first: T
    public let second: U

    public init(_ first: T, _ second: U) {
        self.first = first
        self.second = second
    }

    public init(_ value: (T, U)) {
        self.first = value.0
        self.second = value.1
    }

    public var tuple: (T, U) { (first, second) }
}

extension Pair: Equatable where T: Equatable, U: Equatable {}
extension Pair: Hashable where T: Hashable, U: Hashable {}

extension Pair: Comparable where T: Comparable, U: Comparable {
    public static func < (lhs: Pair, rhs: Pair) -> Bool {
        if lhs.first != rhs.first {
            return lhs.first < rhs.first
        }
        return lhs.second < rhs.second
    }
}

extension Pair: CustomStringConvertible {
    public var description: String {
        "\(first),\(second)"
    }
}

extension Pair where T == U {
    public var array: [T] {
        [first, second]
    }
}

extension Dictionary {
    init(pairs: [Pair<Key, Value>]) {
        self.init(uniqueKeysWithValues: zip(pairs.map { $0.first }, pairs.map { $0.second }))
    }
}
