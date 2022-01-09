//
//  File.swift
//  
//
//  Created by Gereon Steffens on 09.01.22.
//

protocol Drawable {
    var draw: String { get }
    static var unset: String { get }
}

extension Drawable {
    static var unset: String { "." }
}

extension Bool: Drawable {
    var draw: String { self ? "#" : Self.unset }
}

extension Dictionary where Key == Point, Value: Drawable {
    func draw(yRange: Range<Int>, xRange: Range<Int>) {
        for y in yRange {
            let chars = xRange.map { self[Point($0, y)]?.draw ?? Value.unset }
            print(chars.joined())
        }
    }
}
