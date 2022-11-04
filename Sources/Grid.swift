//
//  Grid.swift
//
//  Advent of Code Tools
//

public struct Grid<Value: Drawable> {
    public let points: [Point: Value]
    public let minX: Int
    public let maxX: Int
    public let minY: Int
    public let maxY: Int

    public init(points: [Point: Value]) {
        let minX = points.keys.min { $0.x < $1.x }!.x
        let maxX = points.keys.max { $0.x < $1.x }!.x
        let minY = points.keys.min { $0.y < $1.y }!.y
        let maxY = points.keys.max { $0.y < $1.y }!.y
        self.init(points: points, minX: minX, maxX: maxX, minY: minY, maxY: maxY)
    }

    public init(points: [Point: Value], minX: Int, maxX: Int, minY: Int, maxY: Int) {
        self.points = points
        self.minX = minX
        self.maxX = maxX
        self.minY = minY
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

        return Grid(points: points,
                    minX: 0, maxX: data[0].count - 1,
                    minY: 0, maxY: data.count - 1)
    }

    public func draw() {
        points.draw(xRange: minX...maxX, yRange: minY...maxY)
    }
}

extension Grid: Equatable where Value: Equatable { }

extension Grid: Hashable where Value: Hashable { }
