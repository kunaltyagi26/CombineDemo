//
//  ViewController.swift
//  CombineDemo
//
//  Created by Kunal Tyagi on 17/10/20.
//

import UIKit
import Combine

enum MyError: Error {
    case subscriberError
}

struct School {
    let name: String
    let numberOfStudents: CurrentValueSubject<Int, Never>
    
    init(name: String, numberOfStudents: Int) {
        self.name = name
        self.numberOfStudents = CurrentValueSubject(numberOfStudents)
    }
}

class StringSubscriber: Subscriber {
    func receive(subscription: Subscription) {
        print("Received subscription.")
        subscription.request(.max(2))
    }
    
    func receive(_ input: String) -> Subscribers.Demand {
        print("Received value: ", input)
        return .none
    }
    
    func receive(completion: Subscribers.Completion<MyError>) {
        print("Completed")
    }
    
    typealias Input = String
    typealias Failure = MyError
}

struct Point {
    let x: Int
    let y: Int
}

class ViewController: UIViewController {

    var cancellable: AnyCancellable?
    var cancellable2: AnyCancellable?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // NotificationCentre
        
        /*let notification = Notification.Name(rawValue: "myNotification")
        let publisher = NotificationCenter.default.publisher(for: notification)
        let subscription = publisher.sink { (_) in
            print("Notification received.")
        }
        
        NotificationCenter.default.post(name: notification, object: nil)
        
        subscription.cancel()*/
        
        // Subscription
        
        /*let publisher = ["A", "B", "C", "D", "E", "F"].publisher
        
        let subscriber = StringSubscriber()
        publisher.subscribe(subscriber)*/
        
        // Subject
        
        /*let subject = PassthroughSubject<String, MyError>()
        let subscriber = StringSubscriber()
        subject.subscribe(subscriber)
        
        let subscription = subject.sink { (completion) in
            print("Received completion from sink.")
        } receiveValue: { (value) in
            print("Received value from sink.")
        }

        
        subject.send("A")
        subject.send("B")*/
        
        
        // Collect
        
        //["A", "B", "C", "D", "E", "F"].publisher.collect(3).sink { print($0) }
        
        // Map
        
        /*let formatter = NumberFormatter()
        formatter.numberStyle = .spellOut
        
        [123, 45, 67].publisher.map {
            formatter.string(from: NSNumber(integerLiteral: $0)) ?? ""
        }.sink {
            print($0)
        }*/
        
        /*let publisher = PassthroughSubject<Point, Never>()
        cancellable = publisher.map(\.x, \.y).sink { x, y in
            print("X is \(x) and Y is \(y)")
        }
        
        publisher.send(Point(x: 2, y: 3))*/
        
        // FlatMap
        
        /*let citySchool = School(name: "ABC", numberOfStudents: 100)
        let school = CurrentValueSubject<School, Never>(citySchool)
        
        cancellable = school.flatMap {
            $0.numberOfStudents
        }.sink {
            print($0)
        }
        
        citySchool.numberOfStudents.value += 20*/
        
        // ReplaceNil
        
        /*["A", "B", nil, "C"].publisher.replaceNil(with: "*").map {
            $0!
        }.sink { value in
            print(value)
        }*/
        
        // ReplaceEmpty
        
        /*let empty = Empty<Int, Never>()
        cancellable = empty.replaceEmpty(with: 1)
            .sink {
                print($0)
            }
        */
        
        // Scan
        
        /*let publisher = (1...10).publisher
        publisher.scan([]) { (numbers, value) -> [Int] in
            numbers + [value]
        }.sink {
            print($0)
        }*/
        
        // filter
        
        /*let numbers = (1...20).publisher
        cancellable = numbers.filter { $0 % 2 == 0 }.sink {
            print($0)
        }*/
        
        // removeDuplicates
        
        /*let words = "apple apple fruit apple mango watermelon apple".components(separatedBy: " ").publisher
        words.removeDuplicates().sink {
            print($0)
        }*/
        
        // compactMap
        
        /*let strings = ["a", "1.24", "b", "3.45", "6.7"].publisher.compactMap { Float($0) }
        strings.sink {
            print($0)
        }*/
        
        // ignoreOutput
        
        /*let numbers = (1...5000).publisher
        numbers.ignoreOutput().sink(receiveCompletion: { print($0) }, receiveValue: { print($0) })*/
        
        // first
        
        /*let numbers = (1...9).publisher
        numbers.first(where: { $0 % 2 == 0 }).sink {
            print($0)
        }*/
        
        // last
        
        /*let numbers = (1...9).publisher
        numbers.last(where: { $0 % 2 == 0 }).sink {
            print($0)
        }*/
        
        // dropFirst
        
        /*let numbers = (1...10).publisher
        numbers.dropFirst(5).sink {
            print($0)
        }*/
        
        // dropWhile
        
        /*let numbers = (1...10).publisher
        numbers.drop(while: { $0 % 3 != 0 }).sink {
            print($0)
        }*/
        
        // dropUntilOutputFrom
        
        /*let isReady = PassthroughSubject<Void, Never>()
        let taps = PassthroughSubject<Int, Never>()
        
        cancellable = taps.drop(untilOutputFrom: isReady).sink {
            print($0)
        }
        
        (1...10).forEach { (n) in
            taps.send(n)
            
            if n == 3 {
                isReady.send()
            }
        }*/
        
        // prefix
        
        /*let numbers = (1...10).publisher
        numbers.prefix(2).sink {
            print($0)
        }
        
        cancellable = numbers.prefix(while: { $0 < 3 }).sink {
            print($0)
        }*/
        
        // Challenge
        
        /*let numbers = (1...100).publisher
        numbers.dropFirst(50).prefix(20).filter({ $0 % 2 == 0 }).sink {
            print($0)
        }*/
        
        // prepend
        
        /*let numbers = (1...5).publisher
        let publisher2 = (500...510).publisher
        
        numbers.prepend(100, 101)
            .prepend(-1, -2)
            .prepend([45, 47])
            .prepend(publisher2)
            .sink {
                print($0)
            }*/
        
        // append
        
        /*let numbers = (1...10).publisher
        let publisher2 = (100...110).publisher
        numbers.append(11, 12)
        .append(publisher2)
            .sink {
            print($0)
        }*/
        
        // switchToLatest
        
        /*let publisher1 = PassthroughSubject<String, Never>()
        let publisher2 = PassthroughSubject<String, Never>()
        let publishers = PassthroughSubject<PassthroughSubject<String, Never>, Never>()
        
        cancellable = publishers.switchToLatest().sink {
            print($0)
        }
        
        publishers.send(publisher1)
        publisher1.send("Publisher 1 - Value 1")
        publisher1.send("Publisher 1 - Value 1")
        
        publishers.send(publisher2)
        publisher2.send("Publisher 2 - Value 1")*/
        
        
        /*let images = ["houston", "denver", "seattle"]
        var index = 0
        
        Future<UIImage?, Never> { promise in
            DispatchQueue.global().asyncAfter(deadline: .now() + 3.0) {
                promise(.success(UIImage(named: images[index])))
            }
        }.map { $0 }
        .receive(on: RunLoop.main)
        .eraseToAnyPublisher()
        
        let taps = PassthroughSubject<Void, Never>()
        taps.map {  }*/
        
        // merge
        
        /*let publisher1 = PassthroughSubject<Int, Never>()
        let publisher2 = PassthroughSubject<Int, Never>()
        
        cancellable = publisher1.merge(with: publisher2).sink {
            print($0)
        }
        
        publisher1.send(19)
        publisher2.send(10)*/
        
        // combineToLatest
        
        /*let publisher1 = PassthroughSubject<Int, Never>()
        let publisher2 = PassthroughSubject<String, Never>()
        
        cancellable = publisher1.combineLatest(publisher2).sink {
            print("P1: \($0), P2: \($1)")
        }
        
        publisher1.send(1)
        publisher2.send("A")
        publisher2.send("B")*/
        
        // zip
        
        /*let publisher1 = PassthroughSubject<Int, Never>()
        let publisher2 = PassthroughSubject<String, Never>()
        
        cancellable = publisher1.zip(publisher2).sink {
            print("P1: \($0), P2: \($1)")
        }
        
        publisher1.send(1)
        publisher1.send(2)
        publisher2.send("3")
        publisher2.send("4")*/
        
        // min
        
        /*let publisher = [1, -45, 3, 4].publisher
        cancellable = publisher.min().sink {
            print($0)
        }
        
        // max
         
        cancellable = publisher.max().sink {
            print($0)
        }*/
        
        // first
        
        /*let publisher = [1, -45, 3, 4].publisher
        cancellable = publisher.first().sink {
            print($0)
        }
        
        cancellable = publisher.first(where: { $0 < 0 }).sink {
            print($0)
        }*/
        
        //last
        /*let publisher = [1, -45, 3, 4].publisher
        cancellable = publisher.last().sink {
            print($0)
        }*/
        
        //output
        
        /*let publisher = ["A", "B", "C", "D"].publisher
        cancellable = publisher.output(at: 2).sink {
            print($0)
        }
        
        cancellable = publisher.output(in: (0...2)).sink {
            print($0)
        }*/
        
        /*let publisher = ["A", "B", "C", "D"].publisher
        let publisher1 = PassthroughSubject<Int, Never>()
        
        cancellable = publisher.count().sink {
            print($0)
        }
        
        cancellable = publisher1.count().sink {
            print($0)
        }
        
        publisher1.send(10)
        publisher1.send(completion: .finished)*/
        
        // contains
        
        /*let publisher = ["A", "B", "C", "D"].publisher
        
        cancellable = publisher.contains("C").sink {
            print($0)
        }*/
        
        // allSatisfy
        
        /*let publisher = [1, 2, 3, 4, 5, 6].publisher
        cancellable = publisher.allSatisfy { $0 % 2 == 0 }.sink {
            print($0)
        }*/
        
        // reduce
        
        /*let publisher = [1, 2, 3, 4, 5, 6].publisher
        cancellable = publisher.reduce(0, { $0 + $1 }).sink {
            print($0)
        }*/
        
        // print
        
        /*let publisher = [1, 2, 3, 4, 5, 6].publisher
        cancellable = publisher.print("Debugging").sink {
            print($0)
        }*/
        
        /*guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts") else {
            fatalError("Invalid URL")
        }
        
        let request = URLSession.shared.dataTaskPublisher(for: url)
        
        cancellable = request.sink(receiveCompletion: { print($0) }, receiveValue: { data, response in
            print(String(data: data, encoding: .utf8))
        })*/
        
        // debugger
        
        /*let publisher = (1...10).publisher
        cancellable = publisher
            .breakpoint(receiveOutput: { value in
                return value > 9
            })
            .sink {
                print($0)
            }*/
        
        // timers
        
        /*let runloop = RunLoop.main
        let subscription = runloop.schedule(after: runloop.now, interval: .seconds(2), tolerance: .milliseconds(100)) {
            print("Timer fired.")
        }
        
        runloop.schedule(after: .init(Date(timeIntervalSinceNow: 3.0))) {
            subscription.cancel()
        }
        
        runloop.run()*/
        
        // Timers
        
        /*let subscription = Timer.publish(every: 1.0, on: .main, in: .common)
            .autoconnect()
            .scan(0) { counter, _ in
                counter + 1
                
            }
            .sink {
                print($0)
            }
        
        RunLoop.current.run()*/
        
        // DispatchQueue
        
        /*let queue = DispatchQueue.main
        let source = PassthroughSubject<Int, Never>()
        var counter = 0
        
        let cancellable = queue.schedule(after: queue.now, interval: .seconds(1)) {
            source.send(counter)
            counter += 1
        }
        
        let subscription = source.sink {
            print($0)
        }
        
        RunLoop.current.run()*/
        
        // share
        
        /*guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts") else {
            fatalError("Invalid URL")
        }
        let request = URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .print()
            .share()
        
        cancellable = request.sink(receiveCompletion: { _ in }, receiveValue: {
            print($0)
        })
        
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            self.cancellable2 = request.sink(receiveCompletion: { _ in }, receiveValue: {
                print($0)
            })
        }*/
        
        // multi-cast
        
        /*guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts") else {
            fatalError("Invalid URL")
        }
        let subject = PassthroughSubject<Data, URLError>()
        let request = URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .print()
            .multicast(subject: subject)
        
        cancellable = request.sink(receiveCompletion: { _ in }, receiveValue: {
            print($0)
        })
        
        cancellable2 = request.sink(receiveCompletion: { _ in }, receiveValue: {
            print($0)
        })
        
        request.connect()
        subject.send(Data())*/
    }
}
