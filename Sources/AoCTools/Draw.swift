//
//  Draw.swift
//
//  Advent of Code Tools
//

public protocol Drawable {
    var draw: String { get }
    static func value(for str: String) -> Self
    static var on: String { get }
    static var off: String { get }
}

public extension Drawable {
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
    public func draw(xRange: ClosedRange<Int>, yRange: ClosedRange<Int>) {
        for y in yRange {
            let chars = xRange.map { self[Point($0, y)]?.draw ?? Value.off }
            print(chars.joined())
        }
    }
}
