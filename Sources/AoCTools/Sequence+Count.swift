//
//  Sequence+Count.swift
//  
//
//  Created by Gereon Steffens on 09.01.22.
//

extension Sequence {
    func count(where condition: (Element) -> Bool) -> Int {
        var cnt = 0
        self.forEach {
            if condition($0) { cnt += 1 }
        }
        return cnt
    }
}
