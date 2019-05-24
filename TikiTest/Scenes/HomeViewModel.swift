//
//  HomeViewModel.swift
//  TikiTest
//
//  Created by Ngoc Vu on 5/22/19.
//  Copyright © 2019 Ngoc Vu. All rights reserved.
//

import RxSwift
class HomeViewModel: BaseViewModel<HomeIntent, HomeResult, HomeViewState> {
    
    private let getHomeKeywordsUseCase: GetHomeKeywordsUsecase
    private let keywordsBackgroundColor: [Int] = [0x16702e, 0x005a51, 0x996c00, 0x5c0a6b, 0x006d90, 0x974e06, 0x99272e, 0x89221f, 0x00345d]
    
    fileprivate init(getHomeKeywordsUseCase: GetHomeKeywordsUsecase) {
        self.getHomeKeywordsUseCase = getHomeKeywordsUseCase
        super.init(initializeState: HomeViewState())
    }
    
    override func dispatcher(intent: HomeIntent) -> Observable<HomeResult> {
        switch intent {
        case .initialize:
            return getKeyWordsResult()
        }

    }
    
    override func reducer(previousState: HomeViewState, result: HomeResult) -> HomeViewState {
        switch result {
        case .error(errorMessage: let errorMessage):
            return previousState.copy(copy: { state in
                state.action = .error(message: errorMessage)
            })
        case .loaded(entity: let entity):
            return previousState.copy(copy: { state in
                state.action = .loaded
                state.keywords = handleLoadedState(entity: entity)
            })
        case .loading:
            return previousState.copy(copy: { state in
                state.action = .loading
            })
            
        }
    }
}

extension HomeViewModel {
    private func getKeyWordsResult() -> Observable<HomeResult> {
        return getHomeKeywordsUseCase.execute(parram: GetHomeKeywordsUsecaseParrams()).map { reponse -> HomeResult in
            HomeResult.loaded(entity: reponse.keywordsEntity)
            }.catchError({ error -> Observable<HomeResult> in
                Observable.just(HomeResult.error(errorMessage: error.localizedDescription))
            }).startWith(HomeResult.loading)
    }
    
    private func handleLoadedState(entity: [HomeKeywordEntity]) -> [HomeKeywordUIModel] {
        return entity.enumerated().map{
            let colorIndex = keywordsBackgroundColor[exist: $0.offset] == nil ? ($0.offset % keywordsBackgroundColor.count ) : $0.offset
            return HomeKeywordUIModel(keyword: $0.element.keyword.splitSentenceToModel(), url: $0.element.icon, backgroundColor: keywordsBackgroundColor[colorIndex])
        }
    }
    
}

extension HomeViewModel {
    static func newInstance(getHomeKeywordsUseCase: GetHomeKeywordsUsecase = GetHomeKeywordsUsecase.newInstance()) -> HomeViewModel {
        return HomeViewModel(getHomeKeywordsUseCase: getHomeKeywordsUseCase)
    }
}
