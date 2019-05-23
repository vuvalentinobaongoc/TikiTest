//
//  HomeDataRemote.swift
//  TikiTest
//
//  Created by Ngoc Vu on 5/22/19.
//  Copyright © 2019 Ngoc Vu. All rights reserved.
//

import RxSwift

class HomeDataRemote: HomeRemote {
    private let homeService: HomeService
    fileprivate init(homeService: HomeService) {
        self.homeService = homeService
    }
    func getKeyWords() -> Observable<HomeListKeyWordApiModel?> {
        return homeService.getKeyWords(requestModel: HomeApiRequestModel())
    }
}
extension HomeDataRemote {
    static func newInstance(homeService: HomeService = HomeService.newInstance()) -> HomeDataRemote {
        return HomeDataRemote(homeService: homeService)
    }
}
