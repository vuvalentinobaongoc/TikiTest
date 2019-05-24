//
//  TikiTestTests.swift
//  TikiTestTests
//
//  Created by Ngoc Vu on 5/22/19.
//  Copyright © 2019 Ngoc Vu. All rights reserved.
//

import XCTest
import Quick
import Nimble
import RxSwift
import RxTest
import RxBlocking

@testable import TikiTest

class TikiTestTests: QuickSpec {
    
    override func spec() {
        
        describe("pinyin entries already loading") {
            
            let viewModel = HomeViewModel.newInstance(getHomeKeywordsUseCase: GetHomeKeywordsUsecase.newInstance())
            let scheduler = TestScheduler(initialClock: 0)
            let results = scheduler.createObserver(HomeViewState.self)
            
            let _ = viewModel.states().subscribe(results)
            viewModel.processIntents(intents: Observable.just(HomeIntent.initialize))
            scheduler.start()
            
            it("should show loading") {
                expect(results.events[0].value.element?.action).to(equal(HomeViewState.HomeAction.idle))
                expect(results.events[1].value.element?.action).to(equal(HomeViewState.HomeAction.loading))
            }
        }
    }
}



