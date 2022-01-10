//
//  AStarTests.swift
//  
//
//  Created by Gereon Steffens on 10.01.22.
//

import XCTest
import AoCTools

class AStarTests: XCTestCase {
    struct Grid: Pathfinding {
        let pixels: Pixels<Bool>
        let adjacency: Point.Adjacency

        init(_ data: [String], adjacency: Point.Adjacency = .orthogonal) {
            pixels = Pixels.parse(data)
            self.adjacency = adjacency
        }

        func draw() {
            pixels.draw()
        }

        func neighbors(for point: Point) -> [Point] {
            point.neighbors(adjacency: adjacency).filter {
                $0.x >= 0 && $0.x <= pixels.maxX && $0.y >= 0 && $0.y <= pixels.maxY
            }.filter {
                pixels.points[$0] == false
            }
        }

        func costToMove(from: Point, to: Point) -> Int {
            1
        }

        func hScore(from: Point, to: Point) -> Int {
            from.distance(to: to)
        }
    }

    func testPathfinding() throws {
        let grid = Grid([
            "..........",
            "..........",
            "#########.",
            "..........",
            ".........."
        ])

        grid.draw()

        let pathfinder = AStarPathfinder(grid: grid)
        let path = pathfinder.shortestPathFrom(Point(0, 0), to: Point(9, 4))

        XCTAssertEqual(path.count, 14)
        XCTAssertTrue(path.contains(Point(0,0)))
        XCTAssertTrue(path.contains(Point(9,4)))
        XCTAssertTrue(path.contains(Point(9,2)))
    }

    func testPathfindingDiagonal() throws {
        let grid = Grid([
            "...........",
            "...........",
            "##########.",
            "...........",
            "..........."
        ], adjacency: .diagonal)

        let pathfinder = AStarPathfinder(grid: grid)
        let path = pathfinder.shortestPathFrom(Point(0, 0), to: Point(10, 4))

        XCTAssertEqual(path.count, 13)
        XCTAssertTrue(path.contains(Point(0,0)))
        XCTAssertTrue(path.contains(Point(1,1)))
        XCTAssertFalse(path.contains(Point(1,0)))
        XCTAssertFalse(path.contains(Point(0,1)))
        XCTAssertTrue(path.contains(Point(10,4)))
        XCTAssertTrue(path.contains(Point(10,2)))
    }

    func testPathfindingSnake() throws {
        let grid = Grid([
            "..........",
            "#########.",
            "..........",
            ".#########",
            ".........."
        ])

        grid.draw()

        let pathfinder = AStarPathfinder(grid: grid)
        let path = pathfinder.shortestPathFrom(Point(0, 0), to: Point(9, 4))

        XCTAssertEqual(path.count, 32)
        XCTAssertTrue(path.contains(Point(0,0)))
        XCTAssertTrue(path.contains(Point(9,4)))
        XCTAssertTrue(path.contains(Point(9,2)))
        XCTAssertTrue(path.contains(Point(0,3)))
    }

    func testPathfindingBlock() throws {
        let grid = Grid([
            "..........",
            "..........",
            "..........",
            "........##",
            "........#."
        ])

        let pathfinder = AStarPathfinder(grid: grid)
        let path = pathfinder.shortestPathFrom(Point(0, 0), to: Point(9, 4))

        XCTAssertEqual(path.count, 0)
    }
}
