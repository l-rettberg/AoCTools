//
//  Array+Permutations.swift
//  
//  AoCTools
//

// see https://en.wikipedia.org/wiki/Heap%27s_algorithm

extension Array {
    /// generate all permutations of the values of `self` and call the
    /// given closure with each one.
    ///
    /// for example, given the array `[1,2,3]`, closure will be called with these values:
    /// `[1,2,3]`, `[1,3,2]`, `[2,1,3]`, `[2,3,1]`, `[3,2,1]`, `[3,1,2]`
    /// - Parameter closure: called with each permutation
    func permutations(closure: ([Element]) -> Void) {
        var data = self
        generate(n: data.count, data: &data, closure: closure)
    }

    private func generate(n: Int, data: inout [Element], closure: ([Element]) -> Void) {
        if n == 1 {
            closure(data)
        } else {
            for i in 0 ..< n {
                generate(n: n - 1, data: &data, closure: closure)
                if n % 2 == 0 {
                    data.swapAt(i, n - 1)
                } else {
                    data.swapAt(0, n - 1)
                }
            }
        }
    }
}
