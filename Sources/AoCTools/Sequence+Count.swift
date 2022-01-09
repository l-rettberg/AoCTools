//
//  Sequence+Count.swift
//  
//
//  Created by Gereon Steffens on 09.01.22.
//

extension Sequence {
    public func count(where condition: (Element) -> Bool) -> Int {
        reduce(0) {
            $0 + (condition($1) ? 1 : 0)
        }
    }
}
