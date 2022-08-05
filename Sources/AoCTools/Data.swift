//
//  Data.swift
//  
//  Advent of Code Tools
//

import Foundation

extension UInt8 {
    public var hex: String {
        String(format: "%02hhx", self)
    }
}

extension Array where Element == UInt8 {
    public var hex: String {
        map { $0.hex }.joined(separator: "")
    }
}

extension Data {
    public var hex: String {
        map { $0.hex }.joined(separator: "")
    }
}
