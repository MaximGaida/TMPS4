  

  # Acest cod exemplifică modul în care putem utiliza aceste pattern-uri de design(Observer, Strategy, Command și Iterator) pentru a obține o arhitectură mai modulară, flexibilă și ușor de întreținut în aplicațiile noastre Swift.
  ### În cadrul pattern-ului Observer, avem protocolul Observer care definește o metodă "_update()_". Clasa "_Subject_" menține o listă de observatori și oferă metode pentru adăugarea, eliminarea și notificarea observatorilor atunci când se întâmplă o anumită acțiune. Clasa "_ConcreteObserver_" implementează protocolul și afișează un mesaj de notificare.
#
  
## 1.Observer Pattern: 
#### Pattern-ul Observer este util atunci când aveți nevoie să stabiliți o relație de tip unu-la-mulți între obiecte, în cazul în care schimbarea într-un obiect declanșează actualizări în mai multe obiecte dependente. 
#### În exemplul dat, clasa **'Subject'** menține o listă de observatori și îi notifică atunci când apare o anumită acțiune.

    
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




 ## 2.Strategy Pattern: 
 ### Pattern-ul Strategy este implementat prin protocolul _"Strategy"_ și clasele _"Context"_, _"ConcreteStrategyA"_ și _"ConcreteStrategyB"_. Clasa _"Context"_ are o referință la un obiect de strategie și oferă metode pentru setarea și executarea strategiei. Clasele _"ConcreteStrategyA"_ și _"ConcreteStrategyB"_ implementează protocolul _"Strategy"_ și definesc algoritmi specifici care pot fi utilizați în contextul dat.
 
 
 #
#### Pattern-ul Strategy vă permite să încapsulați o familie de algoritmi interschimbabili și să-i utilizați la rulare în mod interșanjabile. 
#### Promovează conceptul de "preferați compunerea în loc de moștenire" prin încapsularea comportamentelor în clase de strategie separate. Clasa **'Context'** delegă execuția unei strategii specifice obiectului de strategie pe care îl deține.

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




## 3.Command Pattern: 
### Pattern-ul Command este implementat prin protocolul _"Command"_ și clasele _"Receiver"_, _"ConcreteCommand"_ și _"Invoker"_. Clasa _"Receiver"_ definește acțiunea ce trebuie executată, iar clasa ConcreteCommand implementează protocolul _"Command" _și realizează legătura între _"Receiver"_ și invocarea acțiunii. Clasa _"Invoker"_ deține o referință la un obiect de comandă și permite executarea comenzii.


#
#### Pattern-ul Command separă expeditorul unei solicitări de obiectul care efectuează acțiunea. Încapsulează o solicitare ca obiect, permițând astfel parametrizarea clienților cu diferite solicitări, încolăcirea sau înregistrarea solicitărilorși ####  suportul pentru operații care pot fi anulate.
#### În exemplul dat, obiectul Invoker deține o referință către un obiect **'Command'** și poate executa comanda fără a cunoaște detaliile acțiunii sau receptorul.

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
#



## 4.Iterator Pattern:
### Pattern-ul Iterator este implementat prin clasa _"Iterator"_. Aceasta primește o colecție de elemente în constructor și oferă metode pentru verificarea existenței unui element următor și obținerea următorului element într-o iterație.

#
#### Pattern-ul Iterator furnizează o modalitate uniformă de a accesa elementele unei colecții fără a expune structura sa subiacentă.
#### Decuplează codul client de implementarea colecției și permite iterarea prin elementele utilizând o interfață comună. În exemplul dat, clasa **'Iterator'** încapsulează logica de iterare, permițând accesul secvențial la elementele unui șir.

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






#

## Exemplul de utilizare al acestor pattern-uri este prezentat în ultima parte a codului.
### Sunt create instanțe ale claselor respective și se demonstrează cum pot fi utilizate. De exemplu, se adaugă un observator la un subiect și se realizează o acțiune care notifică observatorul. De asemenea, se creează un context cu o anumită strategie și se execută strategia, se creează un obiect de comandă și un invocator care îl execută, și se iterează prin elementele unei liste utilizând un iterator.



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
