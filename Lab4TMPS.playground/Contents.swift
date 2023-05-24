// Observer Pattern
protocol Observer: AnyObject {
    func update()
}

class Subject {
    private var observers = [Observer]()
    
    func addObserver(_ observer: Observer) {
        observers.append(observer)
    }
    
    func removeObserver(_ observer: Observer) {
        observers = observers.filter { $0 !== observer }
    }
    
    func notifyObservers() {
        for observer in observers {
            observer.update()
        }
    }
    
    func doSomething() {
        // Perform some actions
        notifyObservers()
    }
}

class ConcreteObserver: Observer {
    func update() {
        print("Observer notified")
    }
}

// Strategy Pattern
protocol Strategy {
    func execute()
}

class Context {
    private var strategy: Strategy
    
    init(strategy: Strategy) {
        self.strategy = strategy
    }
    
    func setStrategy(_ strategy: Strategy) {
        self.strategy = strategy
    }
    
    func executeStrategy() {
        strategy.execute()
    }
}

class ConcreteStrategyA: Strategy {
    func execute() {
        print("Executing strategy A")
    }
}

class ConcreteStrategyB: Strategy {
    func execute() {
        print("Executing strategy B")
    }
}

// Command Pattern
protocol Command {
    func execute()
}

class Receiver {
    func performAction() {
        print("Action performed")
    }
}

class ConcreteCommand: Command {
    private let receiver: Receiver
    
    init(receiver: Receiver) {
        self.receiver = receiver
    }
    
    func execute() {
        receiver.performAction()
    }
}

class Invoker {
    private var command: Command?
    
    func setCommand(_ command: Command) {
        self.command = command
    }
    
    func executeCommand() {
        command?.execute()
    }
}

// Iterator Pattern
class Iterator<T> {
    private let elements: [T]
    private var currentIndex = 0
    
    init(elements: [T]) {
        self.elements = elements
    }
    
    func hasNext() -> Bool {
        return currentIndex < elements.count
    }
    
    func next() -> T? {
        guard currentIndex < elements.count else {
            return nil
        }
        let element = elements[currentIndex]
        currentIndex += 1
        return element
    }
}

// Usage example
let observer = ConcreteObserver()
let subject = Subject()
subject.addObserver(observer)

let context = Context(strategy: ConcreteStrategyA())
context.executeStrategy()
context.setStrategy(ConcreteStrategyB())
context.executeStrategy()

let receiver = Receiver()
let command = ConcreteCommand(receiver: receiver)
let invoker = Invoker()
invoker.setCommand(command)
invoker.executeCommand()

let elements = [1, 2, 3, 4, 5]
let iterator = Iterator(elements: elements)
while iterator.hasNext() {
    if let element = iterator.next() {
        print("Element: \(element)")
    }
}
