//
//  GetHomeKeywordsUsecase.swift
//  TikiTest
//
//  Created by Ngoc Vu on 5/22/19.
//  Copyright © 2019 Ngoc Vu. All rights reserved.
//

import Foundation
import RxSwift

class GetHomeKeywordsUsecase: BaseUseCase {
    typealias P = GetHomeKeywordsUsecaseParrams
    typealias R = GetHomeKeywordsUsecaseResponse
    private let repository: HomeProvider
    
    fileprivate init(repository: HomeProvider) {
        self.repository = repository
    }
    func buildUseCase(parram: GetHomeKeywordsUsecaseParrams?) -> Observable<GetHomeKeywordsUsecaseResponse> {
        return repository.getKeywords().map({ entity -> GetHomeKeywordsUsecaseResponse in
            GetHomeKeywordsUsecaseResponse(keywordsEntity: entity)
        })
    }
    
}

extension GetHomeKeywordsUsecase {
    static func newInstance(repository: HomeProvider = HomeRepository.newInstance()) -> GetHomeKeywordsUsecase {
        return GetHomeKeywordsUsecase(repository: repository)
    }
}

struct GetHomeKeywordsUsecaseParrams: BaseUseCaseParram {
}

struct GetHomeKeywordsUsecaseResponse: BaseUseResponse {
    let keywordsEntity: [HomeKeywordEntity]
}
