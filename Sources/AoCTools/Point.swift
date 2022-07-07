//
//  Point.swift
//
//  Advent of Code Tools
//

/// A point in a 2d coordinate system.
public struct Point: Hashable {
    public let x, y: Int

    public static let zero = Point(0, 0)

    public init(_ x: Int, _ y: Int) {
        self.x = x
        self.y = y
    }

    public func add(_ point: Point) -> Point {
        Point(self.x + point.x, self.y + point.y)
    }

    public static func +(_ lhs: Point, _ rhs: Point) -> Point {
        lhs.add(rhs)
    }

    public static func *(_ lhs: Point, _ rhs: Int) -> Point {
        Point(lhs.x * rhs, lhs.y * rhs)
    }

    public func distance(to: Point = .zero) -> Int {
        abs(to.x - self.x) + abs(to.y - self.y)
    }
}

// MARK: - rotation
extension Point {
    public func rotated(by degrees: Int) -> Point {
        switch degrees {
        case 0, 360: return self
        case 90: return Point(-y, x)
        case 180: return Point(-x, -y)
        case 270: return Point(y, -x)
        default: fatalError("invalid angle \(degrees)")
        }
    }
}

// MARK: - neighbors
extension Point {
    public enum Adjacency {
        case orthogonal, diagonal, all
    }

    public func neighbors(adjacency: Adjacency = .orthogonal) -> [Point] {
        let orthogonal = [ Point(0, -1), Point(-1, 0), Point(1, 0), Point(0, 1) ]
        let diagonal = [ Point(1, 1), Point(-1, -1), Point(1, -1), Point(-1, 1) ]

        let offsets: [Point]
        switch adjacency {
        case .orthogonal: offsets = orthogonal
        case .diagonal: offsets = diagonal
        case .all: offsets = orthogonal + diagonal
        }

        return offsets.map { add($0) }
    }
}

extension Point: CustomStringConvertible {
    public var description: String {
        "\(x),\(y)"
    }
}
