//
//  PointTests.swift
//
//  Advent of Code tools
//

import Testing
import AoCTools

@Suite
struct Point3Tests {

    @Test func testPoint() throws {
        let zero = Point3.zero
        #expect(zero.x == 0)
        #expect(zero.y == 0)
        #expect(zero.z == 0)

        let one = Point3(1, 1, 1)
        #expect(one.x == 1)
        #expect(one.y == 1)
        #expect(one.z == 1)

        let sum = zero + one
        #expect(sum == one)

        let two = one + one
        #expect(two.x == 2)
        #expect(two.y == 2)
        #expect(two.z == 2)

        let three = one * 3
        #expect(three.x == 3)
        #expect(three.y == 3)
        #expect(three.z == 3)
    }

    @Test func testDistance() throws {
        #expect(Point3(0, 5, 0).distance() == 5)
        #expect(Point3(5, 0, 0).distance() == 5)

        #expect(Point3(1, 5, 0).distance() == 6)
        #expect(Point3(5, 1, 0).distance() == 6)

        #expect(Point3(0, 5, 0).distance(to: Point3(0, 4, 0)) == 1)
        #expect(Point3(5, 0, 0).distance(to: Point3(10, 0, 0)) == 5)

        #expect(Point3(0, 5, 1).distance() == 6)
        #expect(Point3(5, 0, 1).distance() == 6)

        #expect(Point3(1, 5, 1).distance() == 7)
        #expect(Point3(5, 1, 1).distance() == 7)

        #expect(Point3(0, 5, 1).distance(to: Point3(0, 4, 2)) == 2)
        #expect(Point3(5, 0, 1).distance(to: Point3(10, 0, 2)) == 6)
    }

    @Test func testNeighbors() throws {
        let zero = Point3.zero

        #expect(zero.neighbors(adjacency: .all).count == 26)
        #expect(Set(zero.neighbors(adjacency: .all)).count == 26)

        #expect(zero.neighbors(adjacency: .cardinal).count == 6)
        #expect(zero.neighbors(adjacency: .ordinal).count == 20)

        for n in zero.neighbors(adjacency: .orthogonal) {
            #expect(n.distance(to: .zero) == 1)
        }

        for n in zero.neighbors(adjacency: .all) {
            #expect(n.chebyshevDistance(to: .zero) == 1)
        }

        var d2 = 0
        var d3 = 0
        for n in zero.neighbors(adjacency: .ordinal) {
            let distance = n.distance(to: .zero)
            if distance == 2 { d2 += 1 }
            if distance == 3 { d3 += 1 }
        }
        #expect(d2 == 12)
        #expect(d3 == 8)
    }
}
