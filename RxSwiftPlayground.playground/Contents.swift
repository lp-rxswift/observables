import Foundation
import RxSwift

example(of: "just, of, from") {
  let one = 1
  let two = 2
  let three = 3

  let observable = Observable<Int>.just(one)
  let observable2 = Observable.of(one, two, three)
  let observable3 = Observable.of([one, two, three])
  let observable4 = Observable.from([one, two, three])
}

example(of: "subscribe") {
  let one = 1
  let two = 2
  let three = 3
  let observable = Observable.of(one, two, three)
  observable.subscribe(onNext: { element in
    print(element)
  })
}

example(of: "Empty") {
  let observable = Observable<Void>.empty()
  observable.subscribe(onNext: { element in
    print(element)
  }, onCompleted: {
    print("completed")
  })
}

example(of: "Never") {
  let observable = Observable<Void>.never()
  observable.subscribe(onNext: { element in
    print(element)
  }, onCompleted: {
    print("completed")
  })
}

example(of: "range") {
  let observable = Observable<Int>.range(start: 1, count: 10)
  observable.subscribe(onNext: { i in
    let n = Double(i)
    let fibonacci = Int(
      ((pow(1.61803, n) - pow(0.61803, n)) /
      2.23606).rounded()
    )
    print(fibonacci)
  })
}

example(of: "dispose") {
  let observable = Observable.of("A", "B", "C")
  let subscription = observable.subscribe { event in
    print(event)
  }
  subscription.dispose()
}

example(of: "Dispose Bag") {
  let disposeBag = DisposeBag()
  Observable.of("A", "B", "C")
    .subscribe { print($0) }
    .disposed(by: disposeBag)
}

example(of: "Create") {

  enum MyError: Error {
    case anError
  }

  let disposeBag = DisposeBag()
  Observable<String>.create { observer in
    observer.onNext("1")
    //observer.onError(MyError.anError)
    //observer.onCompleted()
    observer.onNext("?")
    return Disposables.create()
  }.subscribe(onNext: { print($0) },
              onError: { print($0) },
              onCompleted: { print("Completed") },
              onDisposed: { print("Disposed") })
    .disposed(by: disposeBag)
}
