//
//  Int+GCD.swift
//  
//  Advent of Code Tools
//

/// Greatest Common Divisor
/// - Parameters:
///   - m: Int
///   - n: Int
/// - Returns: the greatest common divisor of `m` and `n`
public func gcd(_ m: Int, _ n: Int) -> Int {
    let r = m % n
    if r != 0 {
        return gcd(n, r)
    } else {
        return n
    }
}

/// Lowest Common Multiple
/// - Parameters:
///   - m: Int
///   - n: Int
/// - Returns: the lowest common multiple of `m` and `n`
public func lcm(_ m: Int, _ n: Int) -> Int {
    m / gcd(m, n) * n
}
