//
//  Draw.swift
//
//  Advent of Code Tools
//

public protocol Drawable {
    var draw: String { get }
    static func value(for str: String) -> Self
}

extension Drawable where Self: RawRepresentable, Self.RawValue == String {
    static func value(for str: String) -> Self {
        Self(rawValue: str)!
    }

    var draw: String { rawValue }
}

extension Drawable where Self: RawRepresentable, Self.RawValue == Character {
    static func value(for str: Character) -> Self {
        Self(rawValue: str)!
    }

    var draw: String { String(rawValue) }
}

public extension Drawable where Self == Bool {
    static var off: String { "." }
    static var on: String { "#" }
}

extension Bool: Drawable {
    public var draw: String { self ? Self.on : Self.off }
    public static func value(for str: String) -> Self {
        str == Self.on
    }
}

extension Dictionary where Key == Point, Value: Drawable {
    public func draw(xRange: ClosedRange<Int>, yRange: ClosedRange<Int>, default: String = ".") {
        for y in yRange {
            let chars = xRange.map { self[Point($0, y)]?.draw ?? `default` }
            print(chars.joined())
        }
    }
}
