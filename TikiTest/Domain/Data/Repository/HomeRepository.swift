//
//  HomeRepository.swift
//  TikiTest
//
//  Created by Ngoc Vu on 5/22/19.
//  Copyright © 2019 Ngoc Vu. All rights reserved.
//

import RxSwift

class HomeRepository: HomeProvider {
    private let homeFactory: HomeDataStoreFactory
    fileprivate init(homeFactory: HomeDataStoreFactory) {
        self.homeFactory = homeFactory
    }
    func getKeywords() -> Observable<[HomeKeywordEntity]> {
        return homeFactory.getDataStore(isCache: false).getKeyWords()
    }
}
extension HomeRepository {
    static func newInstance(homeFactory: HomeDataStoreFactory = HomeDataStoreFactory.newInstance()) -> HomeRepository {
        return HomeRepository(homeFactory: homeFactory)
    }
}

