//
//  GridTests.swift
//  
//  Advent of Code tools
//

import XCTest
import AoCTools

final class GridTests: XCTestCase {

    func testParseBool() throws {
        let input = """
            ###
            #.#
            ###
            """
        let grid = Grid<Bool>.parse(input)

        XCTAssertEqual(grid.points.count { !$0.value }, 1)
        XCTAssertEqual(grid.points.count { $0.value }, 8)
        XCTAssertEqual(grid.minX, 0)
        XCTAssertEqual(grid.maxX, 2)
        XCTAssertEqual(grid.minY, 0)
        XCTAssertEqual(grid.maxY, 2)

        let s = grid.points.draw(xRange: grid.xRange, yRange: grid.yRange)
        XCTAssertEqual(s.joined(separator: "\n"), input)
    }

    func testParseCustom() throws {
        enum Tile: Character, Drawable {
            case wall = "#"
            case floor = "."
            case door = ":"
        }

        let input = """
            ###
            :.:
            ###
            """
        let grid = Grid<Tile>.parse(input)

        XCTAssertEqual(grid.points.count { $0.value == .floor }, 1)
        XCTAssertEqual(grid.points.count { $0.value == .wall }, 6)
        XCTAssertEqual(grid.points.count { $0.value == .door }, 2)
        XCTAssertEqual(grid.minX, 0)
        XCTAssertEqual(grid.maxX, 2)
        XCTAssertEqual(grid.minY, 0)
        XCTAssertEqual(grid.maxY, 2)

        let s = grid.points.draw(xRange: grid.xRange, yRange: grid.yRange)
        XCTAssertEqual(s.joined(separator: "\n"), input)
    }

    func testGridNotAtOrigin() throws {
        let input = """
            ###
            #.#
            ###
            """
        let grid1 = Grid<Bool>.parse(input)

        let offset = Point(5, 5)
        let offsetGrid = Dictionary(uniqueKeysWithValues: grid1.points.map { ($0.key + offset, $0.value) })

        let grid = Grid(points: offsetGrid)
        XCTAssertEqual(grid.minX, 5)
        XCTAssertEqual(grid.maxX, 7)
        XCTAssertEqual(grid.minY, 5)
        XCTAssertEqual(grid.maxY, 7)

        let s = grid.points.draw(xRange: grid.xRange, yRange: grid.yRange)
        XCTAssertEqual(s.joined(separator: "\n"), input)
    }

    func testGridSparse() throws {
        let input = """
            ###
            ...
            ###
            """
        let grid1 = Grid<Bool>.parse(input)
        var points = grid1.points
        points[Point(0, 1)] = nil
        points[Point(1, 1)] = nil
        points[Point(2, 1)] = nil

        let grid = Grid(points: points)

        XCTAssertEqual(grid.points.count { !$0.value }, 0)
        XCTAssertEqual(grid.points.count { $0.value }, 6)
        XCTAssertEqual(grid.minX, 0)
        XCTAssertEqual(grid.maxX, 2)
        XCTAssertEqual(grid.minY, 0)
        XCTAssertEqual(grid.maxY, 2)

        let s = grid.points.draw(xRange: grid.xRange, yRange: grid.yRange)
        XCTAssertEqual(s.joined(separator: "\n"), input)
    }
}
