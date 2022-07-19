//
//  HexPoint.swift
//
//  Advent of Code Tools
//
//  see https://www.redblobgames.com/grids/hexagons/

public protocol HexDirection {
    var offset: Hex.Point { get }
}

public enum Hex {
    public enum Orientation {
        case flat
        case pointy
    }

    public struct Point: Hashable, CustomStringConvertible {
        public let q, r, s: Int

        public init(_ q: Int, _ r: Int, _ s: Int) {
            self.q = q
            self.r = r
            self.s = s
        }

        public static let zero = Point(0, 0, 0)

        public func add(_ point: Point) -> Point {
            Point(q + point.q, r + point.r, s + point.s)
        }

        public static func +(_ lhs: Point, _ rhs: Point) -> Point {
            lhs.add(rhs)
        }

        public func move(to direction: HexDirection) -> Point {
            self + direction.offset
        }

        public func distance(to point: Point = .zero) -> Int {
            return (abs(q - point.q) + abs(r - point.r) + abs(s - point.s)) / 2
        }

        public var description: String {
            return "\(q),\(r),\(s)"
        }

        public func neighbors(orientation: Orientation) -> [Point] {
            switch orientation {
            case .flat:
                return FlatDirection.allCases.map { $0.offset }
            case .pointy:
                return PointyDirection.allCases.map { $0.offset }
            }
        }
    }

    // "Pointy" directions (the hex has corners pointing up and down)
    public enum PointyDirection: String, CaseIterable, HexDirection {
        case ne, e, se, sw, w, nw

        public var offset: Point {
            switch self {
            case .ne: return Point(1, -1, 0)
            case .e: return Point(1, 0, -1)
            case .se: return Point(0, 1, -1)
            case .sw: return Point(-1, 1, 0)
            case .w: return Point(-1, 0, 1)
            case .nw: return Point(0, -1, 1)
            }
        }
    }

    // "Flat" directions (the hex has flat sides pointing up and down)
    public enum FlatDirection: String, CaseIterable, HexDirection {
        case n, nw, sw, s, se, ne

        public var offset: Point {
            switch self {
            case .n: return Point(0, -1, 1)
            case .nw: return Point(-1, 0, 1)
            case .sw: return Point(-1, 1, 0)
            case .s: return Point(0, 1, -1)
            case .se: return Point(1, 0, -1)
            case .ne: return Point(1, -1, 0)
            }
        }
    }
}
