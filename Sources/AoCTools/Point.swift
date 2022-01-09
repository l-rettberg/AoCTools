//
//  Point.swift
//
//  Advent of Code Tools
//

struct Point: Hashable {
    let x, y: Int

    init(_ x: Int, _ y: Int) {
        self.x = x
        self.y = y
    }

    func add(_ point: Point) -> Point {
        Point(self.x + point.x, self.y + point.y)
    }

    static func +(_ lhs: Point, _ rhs: Point) -> Point {
        lhs.add(rhs)
    }

    static func *(_ lhs: Point, _ rhs: Int) -> Point {
        Point(lhs.x * rhs, lhs.y * rhs)
    }

    func distance(to: Point) -> Int {
        abs(to.x - self.x) + abs(to.y - self.y)
    }
}

// MARK: - rotation
extension Point {
    func rotated(by degrees: Int) -> Point {
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
    enum Adjacency {
        case orthogonal, diagonal, all
    }

    func neighbors(adjacency: Adjacency = .orthogonal) -> [Point] {
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
    var description: String {
        "\(x),\(y)"
    }
}
