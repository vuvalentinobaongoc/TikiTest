
//
//  BaseViewModel.swift
//  TikiTest
//
//  Created by Ngoc Vu on 5/22/19.
//  Copyright © 2019 Ngoc Vu. All rights reserved.
//

import RxSwift
import RxCocoa

class BaseViewModel<I: BaseIntent, R: BaseViewResult, VS: BaseViewState> {
    private let intentsSubject: PublishSubject<I> = PublishSubject()
    private let initializeState: VS
    private var lastestIntent: I? = nil
    internal let disposable = CompositeDisposable()
    
    lazy var statesSubject: BehaviorSubject<VS> = BehaviorSubject(value: initializeState)
    private lazy var statesObservable: Observable<VS> = {
        return intentsSubject.flatMap{ [unowned self] intent -> Observable<I> in
            self.lastestIntent = intent
            return Observable.just(intent)
            }.flatMap{ [unowned self] intent in
                self.dispatcher(intent: intent)
            }.scan(initializeState, accumulator: {[unowned self] (previousState, result) in
                return self.reducer(previousState: previousState, result: result)
            }).replay(1).autoconnect()
    }()
    
    init(initializeState: VS) {
        self.initializeState = initializeState
        _ = disposable.insert(statesObservable.bind(to: statesSubject))
    }
    
    func states() -> BehaviorSubject<VS> {
        return statesSubject
    }
    
    func processIntents(intents: Observable<I>) {
        _ = disposable.insert(intents.share().subscribe(intentsSubject))
    }
    
    func publish(intent: I) {
        intentsSubject.onNext(intent)
    }
    
    func dispatcher(intent: I) -> Observable<R> {
        fatalError("not implement")
    }
    func reducer(previousState: VS, result: R) -> VS {
        fatalError("not implement")
    }
    
    deinit {
        print("\(String(describing: self)) is being deinitialized")
    }
    
}
