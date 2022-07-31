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
        Point(x + point.x, y + point.y)
    }

    public static func +(_ lhs: Point, _ rhs: Point) -> Point {
        lhs.add(rhs)
    }

    public static func *(_ lhs: Point, _ rhs: Int) -> Point {
        Point(lhs.x * rhs, lhs.y * rhs)
    }

    public func distance(to point: Point = .zero) -> Int {
        abs(x - point.x) + abs(y - point.y)
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

    public enum Turn {
        case clockwise // "right"
        case counterclockwise // "left"
    }

    public enum Direction: String, CaseIterable {
        case n, w, s, e
        case nw, ne, sw, se

        public static let orthogonal: [Direction] = [ .n, .w, .s, .e ]
        public static let diagonal: [Direction] = [ .nw, .ne, .sw, .se ]

        public var offset: Point {
            switch self {
            case .n: return Point(0, -1)
            case .w: return Point(-1, 0)
            case .s: return Point(0, 1)
            case .e: return Point(1, 0)
            case .nw: return Point(-1, -1)
            case .ne: return Point(1, -1)
            case .sw: return Point(-1, 1)
            case .se: return Point(1, 1)
            }
        }

        public var opposite: Direction {
            switch self {
            case .n: return .s
            case .s: return .n
            case .w: return .e
            case .e: return .w
            case .ne: return .sw
            case .nw: return .se
            case .se: return .nw
            case .sw: return .ne
            }
        }

        public func turned(_ turn: Turn, by degrees: Int = 90) -> Direction {
            switch (turn, degrees) {
            case (.clockwise, 90):
                switch self {
                case .n: return .e
                case .e: return .s
                case .s: return .w
                case .w: return .n
                case .ne: return .se
                case .nw: return .ne
                case .se: return .sw
                case .sw: return .nw
                }
            case (.clockwise, 45):
                switch self {
                case .n: return .ne
                case .e: return .se
                case .s: return .sw
                case .w: return .nw
                case .ne: return .e
                case .nw: return .n
                case .se: return .s
                case .sw: return .w
                }
            case (.counterclockwise, 90):
                switch self {
                case .n: return .w
                case .e: return .n
                case .s: return .e
                case .w: return .s
                case .ne: return .nw
                case .nw: return .sw
                case .se: return .ne
                case .sw: return .se
                }
            case (.counterclockwise, 45):
                switch self {
                case .n: return .nw
                case .e: return .ne
                case .s: return .se
                case .w: return .sw
                case .ne: return .n
                case .nw: return .w
                case .se: return .e
                case .sw: return .s
                }
            default:
                fatalError("unsupported turn degrees \(degrees)")
            }
        }
    }

    public func neighbors(adjacency: Adjacency = .orthogonal) -> [Point] {
        let offsets: [Direction]
        switch adjacency {
        case .orthogonal: offsets = Direction.orthogonal
        case .diagonal: offsets = Direction.diagonal
        case .all: offsets = Direction.allCases
        }

        return offsets.map { add($0.offset) }
    }
}

extension Point: CustomStringConvertible {
    public var description: String {
        "\(x),\(y)"
    }
}
