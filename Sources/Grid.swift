//
//  Grid.swift
//
//  Advent of Code Tools
//

public struct Grid<Value: Drawable> {
    public let points: [Point: Value]
    public let maxX: Int
    public let maxY: Int

    public init(points: [Point: Value]) {
        let maxX = points.keys.max { $0.x < $1.x }!.x
        let maxY = points.keys.max { $0.y < $1.y }!.y
        self.init(points: points, maxX: maxX, maxY: maxY)
    }

    public init(points: [Point: Value], maxX: Int, maxY: Int) {
        self.points = points
        self.maxX = maxX
        self.maxY = maxY
    }

    public static func parse(_ string: String) -> Grid {
        parse(string.components(separatedBy: "\n"))
    }

    public static func parse(_ data: [String]) -> Grid {
        var points = [Point: Value]()

        for (y, line) in data.enumerated() {
            for (x, ch) in line.enumerated() {
                let point = Point(x, y)
                points[point] = Value.value(for: String(ch))
            }
        }

        return Grid(points: points, maxX: data[0].count - 1, maxY: data.count - 1)
    }

    public func draw() {
        points.draw(xRange: 0...maxX, yRange: 0...maxY)
    }
}

extension Grid: Equatable where Value: Equatable { }

extension Grid: Hashable where Value: Hashable { }
