//
//  Pixels.swift
//
//  Advent of Code Tools
//

public struct Pixels<Value: Drawable> {
    public let points: [Point: Value]
    public let maxX: Int
    public let maxY: Int

    public static func parse(_ data: [String]) -> Pixels {
        var points = [Point: Value]()

        for (y, line) in data.enumerated() {
            for (x, ch) in line.enumerated() {
                let point = Point(x, y)
                points[point] = Value.value(for: String(ch))
            }
        }

        return Pixels(points: points, maxX: data[0].count - 1, maxY: data.count - 1)
    }

    public func draw() {
        points.draw(xRange: 0...maxX, yRange: 0...maxY)
    }
}
