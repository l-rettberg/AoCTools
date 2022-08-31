//
//  AStarTests.swift
//  
//
//  Created by Gereon Steffens on 10.01.22.
//

import XCTest
import AoCTools

class AStarTests: XCTestCase {
    struct Map: Pathfinding {
        let grid: Grid<Bool>
        let adjacency: Point.Adjacency

        init(_ data: [String], adjacency: Point.Adjacency = .orthogonal) {
            grid = Grid.parse(data)
            self.adjacency = adjacency
        }

        func draw() {
            grid.draw()
        }

        func neighbors(for point: Point) -> [Point] {
            point.neighbors(adjacency: adjacency).filter {
                $0.x >= 0 && $0.x <= grid.maxX && $0.y >= 0 && $0.y <= grid.maxY
            }.filter {
                grid.points[$0] == false
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
        let map = Map([
            "..........",
            "..........",
            "#########.",
            "..........",
            ".........."
        ])

        map.draw()

        let pathfinder = AStarPathfinder(map: map)
        let path = pathfinder.shortestPath(from: .zero, to: Point(9, 4))

        XCTAssertEqual(path.count, 13)
        XCTAssertFalse(path.contains(.zero))
        XCTAssertTrue(path.contains(Point(9,4)))
        XCTAssertTrue(path.contains(Point(9,2)))
    }

    func testPathfindingDiagonal() throws {
        let map = Map([
            "...........",
            "...........",
            "##########.",
            "...........",
            "..........."
        ], adjacency: .diagonal)

        let pathfinder = AStarPathfinder(map: map)
        let path = pathfinder.shortestPath(from: .zero, to: Point(10, 4))

        XCTAssertEqual(path.count, 12)
        XCTAssertFalse(path.contains(.zero))
        XCTAssertTrue(path.contains(Point(1,1)))
        XCTAssertTrue(path.contains(Point(2,0)))
        XCTAssertTrue(path.contains(Point(9,3)))
        XCTAssertTrue(path.contains(Point(10,2)))
        XCTAssertTrue(path.contains(Point(10,4)))

        XCTAssertFalse(path.contains(Point(1,0)))
        XCTAssertFalse(path.contains(Point(0,1)))
    }

    func testPathfindingSnake() throws {
        let map = Map([
            "..........",
            "#########.",
            "..........",
            ".#########",
            ".........."
        ])

        map.draw()

        let pathfinder = AStarPathfinder(map: map)
        let path = pathfinder.shortestPath(from: .zero, to: Point(9, 4))

        XCTAssertEqual(path.count, 31)
        XCTAssertFalse(path.contains(.zero))
        XCTAssertTrue(path.contains(Point(9,4)))
        XCTAssertTrue(path.contains(Point(9,2)))
        XCTAssertTrue(path.contains(Point(0,3)))
    }

    func testPathfindingBlocked() throws {
        let map = Map([
            "..........",
            "..........",
            "..........",
            "........##",
            "........#."
        ])

        let pathfinder = AStarPathfinder(map: map)
        let path = pathfinder.shortestPath(from: .zero, to: Point(9, 4))

        XCTAssertEqual(path.count, 0)
    }
}
