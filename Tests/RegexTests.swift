//
//  RegexTests.swift
//  
//  Advent of Code tools
//

import Testing
import AoCTools

@Suite
struct RegexTests {

    @Test func testRegex1() throws {
        let regex = Regex(pattern: #"abc (\d*) def"#)
        let matches = regex.matches(in: "abc 123 def")
        #expect(matches == ["123"])
    }

    @Test func testRegex2() throws {
        let regex = Regex(pattern: #"(.*) \((\d*)\)( -> (.*))?"#)

        let matches = regex.matches(in: "jfrda (3994) -> lnpuarm, oahfm, nsfjyfr")
        #expect(matches == ["jfrda", "3994", " -> lnpuarm, oahfm, nsfjyfr", "lnpuarm, oahfm, nsfjyfr"])

        let matches2 = regex.matches(in: "oahfm (3994)")
        #expect(matches2 == ["oahfm", "3994"])
    }

    @Test func testRegex3() throws {
        let regex = Regex(pattern: #"(.*) \((\d*)\)( -> )?(.*)?"#)

        let matches = regex.matches(in: "jfrda (3994) -> lnpuarm, oahfm, nsfjyfr")
        #expect(matches == ["jfrda", "3994", " -> ", "lnpuarm, oahfm, nsfjyfr"])

        let matches2 = regex.matches(in: "oahfm (3994)")
        #expect(matches2 == ["oahfm", "3994"])
    }

    @Test func testRegex4() throws {
        let regex = Regex(pattern: #"(.*) (.*) (-?\d*) if (.*) (.*) (-?\d*)"#)
        let matches = regex.matches(in: "b inc 5 if a > 1")
        #expect(matches == ["b", "inc", "5", "a", ">", "1" ])
    }
}
