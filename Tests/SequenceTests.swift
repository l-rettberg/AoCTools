//
//  SequenceTests.swift
//  
//  Advent of Code tools
//

import Testing
import Algorithms
import AoCTools

@Suite
struct SequenceTests {
    @Test func testCount() throws {
        let array = [1, 2, 3, 4]
        #expect(array.count(where: { $0 == 1 }) == 1)
        #expect(array.count(where: { $0.isMultiple(of: 2)}) == 2)
    }

    @Test func testMinMax() throws {
        let (min, max) = try #require([1, 2, 3, 4, 5].shuffled().minAndMax())
        #expect(max == 5)
        #expect(min == 1)

        let points = [Point.zero, Point(1, 100), Point(2, 200)]
        let (minX, maxX) = try #require(points.shuffled().minAndMax(of: \.x))
        #expect(maxX == 2)
        #expect(minX == 0)

        let (minY, maxY) = try #require(points.shuffled().minAndMax(of: \.y))
        #expect(maxY == 200)
        #expect(minY == 0)
    }

    @Test func testSum() throws {
        #expect([1, 2, 3, 4].sum() == 10)
        #expect([1, 2, 3, 4].product() == 24)

        struct Foo {
            let bar: Int
            init(_ bar: Int) { self.bar = bar }
        }

        #expect([Foo(1), Foo(2)].sumOf(\.bar) == 3)
        #expect([Foo(3), Foo(4)].productOf(\.bar) == 12)
    }
}
