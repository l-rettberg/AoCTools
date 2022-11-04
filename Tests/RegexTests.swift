//
//  RegexTests.swift
//  
//
//  Created by Gereon Steffens on 04.08.22.
//

import XCTest
import AoCTools

class RegexTests: XCTestCase {

    func testRegex1() throws {
        let regex = Regex(pattern: #"abc (\d*) def"#)
        let matches = regex.matches(in: "abc 123 def")
        XCTAssertEqual(matches, ["123"])
    }

    func testRegex2() throws {
        let regex = Regex(pattern: #"(.*) \((\d*)\)( -> (.*))?"#)

        let matches = regex.matches(in: "jfrda (3994) -> lnpuarm, oahfm, nsfjyfr")
        XCTAssertEqual(matches, ["jfrda", "3994", " -> lnpuarm, oahfm, nsfjyfr", "lnpuarm, oahfm, nsfjyfr"])

        let matches2 = regex.matches(in: "oahfm (3994)")
        XCTAssertEqual(matches2, ["oahfm", "3994"])
    }

    func testRegex3() throws {
        let regex = Regex(pattern: #"(.*) \((\d*)\)( -> )?(.*)?"#)

        let matches = regex.matches(in: "jfrda (3994) -> lnpuarm, oahfm, nsfjyfr")
        XCTAssertEqual(matches, ["jfrda", "3994", " -> ", "lnpuarm, oahfm, nsfjyfr"])

        let matches2 = regex.matches(in: "oahfm (3994)")
        XCTAssertEqual(matches2, ["oahfm", "3994"])
    }


    func testRegex4() throws {
        let regex = Regex(pattern: #"(.*) (.*) (-?\d*) if (.*) (.*) (-?\d*)"#)
        let matches = regex.matches(in: "b inc 5 if a > 1")
        XCTAssertEqual(matches, ["b", "inc", "5", "a", ">", "1" ])
    }
}
