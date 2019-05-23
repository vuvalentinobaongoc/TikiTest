//
//  HomeViewController.swift
//  TikiTest
//
//  Created by Ngoc Vu on 5/22/19.
//  Copyright © 2019 Ngoc Vu. All rights reserved.
//

import UIKit
import RxSwift

class HomeViewController: BaseViewController<HomeIntent, HomeResult, HomeViewState,HomeViewModel> {
    
    private lazy var loadingIndicator: UIActivityIndicatorView = {
        let ld = UIActivityIndicatorView()
        ld.translatesAutoresizingMaskIntoConstraints = false
        ld.hidesWhenStopped = true
        ld.color = .green
        return ld
    }()
    
    @IBOutlet weak var collectionViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var collectionViewKeywords: HomeCollectionView!
    
    override func loadView() {
        super.loadView()
        view.addSubview(loadingIndicator)
        NSLayoutConstraint.activate([
            loadingIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loadingIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            loadingIndicator.widthAnchor.constraint(equalToConstant: 100.0),
            loadingIndicator.heightAnchor.constraint(equalToConstant: 100.0)
            ])
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionViewKeywords.backgroundColor = UIColor.black
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionViewHeightConstraint.constant = collectionViewKeywords.collectionViewLayout.collectionViewContentSize.height
    }
    
    override func intents() -> Observable<HomeIntent> {
        return Observable.just(.initialize)
    }
    
    override func render(state: HomeViewState) {
        switch state.action {
        case .idle:
            break
        case .loading:
            renderLoading()
        case .loaded:
            renderLoaded(state: state)
        case .error:
            renderError(state: state)
        }
    }
}

extension HomeViewController {
    
    private func renderLoading() {
        loadingIndicator.startAnimating()
    }
    
    private func renderLoaded(state: HomeViewState) {
        loadingIndicator.stopAnimating()
        collectionViewKeywords.items = state.keywords
        
    }
    
    private func renderError(state: HomeViewState) {
        loadingIndicator.stopAnimating()
        if !loadingIndicator.isAnimating {
            
        }
    }
}

extension HomeViewController {
    static func newInstance(viewModel: HomeViewModel) -> HomeViewController {
        let storyBoard = UIStoryboard(name: "Home", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
        vc.viewModel = viewModel
        return vc
    }
}

