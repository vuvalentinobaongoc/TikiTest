//
//  BaseViewController.swift
//  TikiTest
//
//  Created by Ngoc Vu on 5/22/19.
//  Copyright © 2019 Ngoc Vu. All rights reserved.
//
import UIKit
import RxSwift

class BaseViewController<I: BaseIntent, R: BaseViewResult,VS: BaseViewState,VM: BaseViewModel<I,R,VS>>: UIViewController {
    
    private let disposedBag = DisposeBag()
    var viewModel: VM!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let navigationVC = navigationController {
            navigationVC.setNavigationBarHidden(true, animated: false)
        }
        
        self.viewModel.states().observeOn(MainScheduler.instance).subscribe(onNext: {[weak self] viewState in
            self?.render(state: viewState)
        }).disposed(by: disposedBag)
        self.viewModel.processIntents(intents: self.intents())
    }
    
    
    func intents() -> Observable<I> {
        fatalError("Not Implement")
    }
    func render(state: VS) {
        fatalError("Not Implement")
    }
    
    deinit {
        print("\(String(describing: self)) is being deinitialized")
    }
    
}
