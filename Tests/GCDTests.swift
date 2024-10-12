//
//  GCDTests.swift
//  
//  Advent of Code tools
//

import Testing
import AoCTools

@Suite
struct GCDTests {
    @Test func testGCD() throws {
        #expect(gcd(10, 9) == 1)
        #expect(gcd(9, 6) == 3)
        #expect(gcd(12, 6) == 6)
        #expect(gcd(16, 8) == 8)
        #expect(gcd(10, 8) == 2)
    }

    @Test func testLCM() throws {
        #expect(lcm(10, 9) == 90)
        #expect(lcm(10, 2) == 10)
        #expect(lcm(12, 3) == 12)
        #expect(lcm(5, 7) == 35)
        #expect(lcm(12, 8) == 24)
    }
}
