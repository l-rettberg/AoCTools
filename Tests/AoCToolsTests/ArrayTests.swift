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
}
