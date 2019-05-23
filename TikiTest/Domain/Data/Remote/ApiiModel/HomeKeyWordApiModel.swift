//
//  HomeApiModel.swift
//  TikiTest
//
//  Created by Ngoc Vu on 5/22/19.
//  Copyright © 2019 Ngoc Vu. All rights reserved.
//

import Gloss
struct HomeListKeyWordApiModel: JSONDecodable {
    let listKeyWord: [HomeKeyWordApiModel]?
    
    init?(json: JSON) {
        self.listKeyWord = "keywords" <~~ json
    }
}

struct HomeKeyWordApiModel: JSONDecodable {
    let keyword: String?
    let icon: String?
    
    init?(json: JSON) {
        self.keyword = "keyword" <~~ json
        self.icon = "icon" <~~ json
    }
    
}


