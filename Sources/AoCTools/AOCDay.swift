//
//  AOCDay.swift
//
//  Advent of Code Tools
//

protocol Runnable {
    init(rawInput: String?)
    func run()
}

protocol AOCDay: Runnable {
    var day: String { get }
    static var rawInput: String { get }

    associatedtype Solution1
    func part1() -> Solution1

    associatedtype Solution2
    func part2() -> Solution2
}

extension AOCDay {
    static var rawInput: String { "" }
    var day: String { String("\(Self.self)".suffix(2)) }

    func run() {
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
