import XCTest
import AoCTools

final class ArrayTests: XCTestCase {
    func testPermutations() throws {
        let array = [1,2,3]
        var result = Set<[Int]>()

        array.permutations {
            result.insert($0)
        }

        XCTAssertEqual(result.count, 6)
        XCTAssertEqual(result, [[1,2,3], [1,3,2], [2,1,3], [2,3,1], [3,2,1], [3,1,2]])
    }

    func testChunkSize() throws {
        XCTAssertEqual([1,2,3].chunked(2), [[1,2], [3]])
        XCTAssertEqual([1,2,3,4].chunked(2), [[1,2], [3,4]])
        XCTAssertEqual([1,2,3,4,5].chunked(2), [[1,2], [3,4], [5]])
    }

    func testChunkBy() throws {
        var numbers = [10, 20, 30, 10, 40, 40, 10, 20]
        var chunks = numbers.chunked(by: { $0 <= $1 })
        XCTAssertEqual(chunks, [[10, 20, 30], [10, 40, 40], [10, 20]])

        numbers = [10, 20, 30]
        chunks = numbers.chunked(by: { $0 <= $1 })
        XCTAssertEqual(chunks, [[10, 20, 30]])

        numbers = [30, 20, 10]
        chunks = numbers.chunked(by: { $0 <= $1 })
        XCTAssertEqual(chunks, [[30], [20], [10]])

        numbers = [10, 40, 40, 10]
        chunks = numbers.chunked(by: { $0 <= $1 })
        XCTAssertEqual(chunks, [[10, 40, 40], [10]])
    }
}
