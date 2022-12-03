//
//  Array+Chunk.swift
//  
//  Advent of Code Tools
//

extension Array {
    public func chunked(_ size: Int) -> [[Element]] {
        stride(from: 0, to: count, by: size).map {
            Array(self[$0 ..< Swift.min($0 + size, count)])
        }
    }

    public func chunked(by condition: (Element, Element) -> Bool) -> [[Element]] {
        var result = [[Element]]()
        var tmp = [Element]()
        for index in 0 ..< self.count - 1 {
            tmp.append(self[index])
            if !condition(self[index], self[index + 1]) {
                result.append(tmp)
                tmp.removeAll()
            }
        }
        tmp.append(self[self.count - 1])
        result.append(tmp)

        return result
    }
}
