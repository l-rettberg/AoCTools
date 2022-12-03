//
//  Triple.swift
//  
//
//  Created by Gereon Steffens on 17.09.22.
//

import Foundation

public struct Triple<T, U, V> {
    public let first: T
    public let second: U
    public let third: V

    public init(_ first: T, _ second: U, _ third: V) {
        self.first = first
        self.second = second
        self.third = third
    }

    // swiftlint:disable large_tuple
    public init(_ value: (T, U, V)) {
        self.first = value.0
        self.second = value.1
        self.third = value.2
    }

    public var tuple: (T, U, V) { (first, second, third) }
}

extension Triple: Equatable where T: Equatable, U: Equatable, V: Equatable {}
extension Triple: Hashable where T: Hashable, U: Hashable, V: Hashable {}

extension Triple: Comparable where T: Comparable, U: Comparable, V: Comparable {
    public static func < (lhs: Triple, rhs: Triple) -> Bool {
        if lhs.first != rhs.first {
            return lhs.first < rhs.first
        }
        if lhs.second != rhs.second {
            return lhs.second < rhs.second
        }
        return lhs.third < rhs.third
    }
}

extension Triple: CustomStringConvertible {
    public var description: String {
        "\(first),\(second),\(third)"
    }
}

extension Triple where T == U, T == V {
    public var array: [T] {
        [first, second, third]
    }
}
