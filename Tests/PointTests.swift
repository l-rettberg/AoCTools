//
//  PointTests.swift
//  
//  Advent of Code tools
//

import Testing
import AoCTools

@Suite
struct PointTests {

    @Test func testPoint() throws {
        let zero = Point.zero
        #expect(zero.x == 0)
        #expect(zero.y == 0)

        let one = Point(1, 1)
        #expect(one.x == 1)
        #expect(one.y == 1)

        let sum = zero + one
        #expect(sum == one)

        let two = one + one
        #expect(two.x == 2)
        #expect(two.y == 2)

        let three = one * 3
        #expect(three.x == 3)
        #expect(three.y == 3)
    }

    @Test func testDistance() throws {
        #expect(Point(0, 5).distance() == 5)
        #expect(Point(5, 0).distance() == 5)

        #expect(Point(1, 5).distance() == 6)
        #expect(Point(5, 1).distance() == 6)

        #expect(Point(0, 5).distance(to: Point(0, 4)) == 1)
        #expect(Point(5, 0).distance(to: Point(10, 0)) == 5)
    }

    @Test func testNeighbors() throws {
        let zero = Point.zero

        #expect(zero.neighbors(adjacency: .all).count == 8)
        #expect(zero.neighbors(adjacency: .cardinal).count == 4)
        #expect(zero.neighbors(adjacency: .ordinal).count == 4)

        for n in zero.neighbors(adjacency: .cardinal) {
            #expect(n.distance(to: .zero) == 1)
        }

        for n in zero.neighbors(adjacency: .ordinal) {
            #expect(n.distance(to: .zero) == 2)
        }
    }

    @Test func testOppositeDirection() throws {
        let zero = Point.zero

        for direction in Direction.allCases {
            #expect(zero + direction.offset + direction.opposite.offset == zero)
        }

    }

    @Test func testTurns() throws {
        var turned = Set<Direction>()

        for direction in Direction.allCases {
            turned.insert(direction.turned(.clockwise, by: 90))
        }
        #expect(Direction.allCases.count == turned.count)

        turned.removeAll()
        for direction in Direction.allCases {
            turned.insert(direction.turned(.clockwise, by: 45))
        }
        #expect(Direction.allCases.count == turned.count)

        turned.removeAll()
        for direction in Direction.allCases {
            turned.insert(direction.turned(.counterclockwise, by: 90))
        }
        #expect(Direction.allCases.count == turned.count)

        turned.removeAll()
        for direction in Direction.allCases {
            turned.insert(direction.turned(.counterclockwise, by: 45))
        }
        #expect(Direction.allCases.count == turned.count)
    }

    @Test func testMoves() throws {
        #expect(Point.zero.moved(to: .n) == Point(0, -1))
        #expect(Point.zero.moved(to: .up) == Point(0, -1))

        #expect(Point.zero.moved(to: .s) == Point(0, 1))
        #expect(Point.zero.moved(to: .down) == Point(0, 1))

        #expect(Point.zero.moved(to: .w) == Point(-1, 0))
        #expect(Point.zero.moved(to: .left) == Point(-1, 0))

        #expect(Point.zero.moved(to: .e) == Point(1, 0))
        #expect(Point.zero.moved(to: .right) == Point(1, 0))
    }
}
