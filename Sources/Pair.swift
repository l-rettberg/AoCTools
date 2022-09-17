//
//  Pair.swift
//  
//  Advent of Code Tools
//

struct Pair<T, U> {
    let first: T
    let second: U

    init(_ first: T, _ second: U) {
        self.first = first
        self.second = second
    }

    init(_ value: (T, U)) {
        self.first = value.0
        self.second = value.1
    }
}

extension Pair: Equatable where T: Equatable, U: Equatable {}
extension Pair: Hashable where T: Hashable, U: Hashable {}

extension Pair: CustomStringConvertible {
    var description: String {
        "\(first),\(second)"
    }
}

extension Pair where T == U {
    var array: [T] {
        [first, second]
    }
}

extension Dictionary {
    init(pairs: [Pair<Key, Value>]) {
        self.init(uniqueKeysWithValues: zip(pairs.map { $0.first }, pairs.map { $0.second }))
    }
}
