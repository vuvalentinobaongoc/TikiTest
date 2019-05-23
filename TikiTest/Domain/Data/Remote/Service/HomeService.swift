//
//  HomeService.swift
//  TikiTest
//
//  Created by Ngoc Vu on 5/22/19.
//  Copyright © 2019 Ngoc Vu. All rights reserved.
//

import Gloss
import RxSwift

struct HomeApiResponse: JSONDecodable {
    let keyword: String?
    let icon: String?
    init?(json: JSON) {
        self.keyword = "keyword" <~~ json
        self.icon = "icon" <~~ json
    }
}

class HomeService: BaseApiService {
    fileprivate override init() {}
    
    func getKeyWords(requestModel: HomeApiRequestModel) -> Observable<HomeListKeyWordApiModel?> {
        let urlRequest = ApiRouter.getKeywords
        return execute(urlRequest: urlRequest)
    }
}

extension HomeService {
    static func newInstance() -> HomeService {
        return HomeService()
    }
}
