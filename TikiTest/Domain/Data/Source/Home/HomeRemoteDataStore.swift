//
//  HomeDataStore.swift
//  TikiTest
//
//  Created by Ngoc Vu on 5/22/19.
//  Copyright © 2019 Ngoc Vu. All rights reserved.
//

import RxSwift
class HomeRemoteDataStore: HomeDataStore {
    private let homeRemote: HomeRemote
    
    fileprivate init(homeRemote: HomeRemote) {
        self.homeRemote = homeRemote
    }
    func getKeyWords() -> Observable<[HomeKeywordEntity]> {
        return homeRemote.getKeyWords().map{$0?.listKeyWord}.map({ apiModel  in
            apiModel?.map({ model -> HomeKeywordEntity  in
                HomeKeywordEntity(keyword: model.keyword ?? "", icon: model.icon ?? "")
            }) ?? []
        })
    }
}
extension HomeRemoteDataStore {
    static func newInstance(homeRemote: HomeRemote = HomeDataRemote.newInstance()) -> HomeRemoteDataStore {
        return HomeRemoteDataStore(homeRemote: homeRemote)
    }
}
