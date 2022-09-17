//
//  AOCDay.swift
//
//  Advent of Code Tools
//

public protocol Runnable {
    init(rawInput: String?)
    func run()
}

public protocol AOCDay: Runnable {
    var day: String { get }
    static var rawInput: String { get }

    associatedtype Solution1
    func part1() -> Solution1

    associatedtype Solution2
    func part2() -> Solution2
}

extension AOCDay {
    public static var rawInput: String { "" }
    public var day: String { String("\(Self.self)".suffix(2)) }

    public func run() {
        run(part: 1, part1)
        run(part: 2, part2)
    }

    private func run<T>(part: Int, _ fun: () -> T) {
        let timer = Timer(day, fun: "part \(part)")
        let solution = fun()
        timer.show()
        print("Solution for day \(day) part \(part): \(solution)")
    }
}
