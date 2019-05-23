//
//  HomeViewState.swift
//  TikiTest
//
//  Created by Ngoc Vu on 5/22/19.
//  Copyright © 2019 Ngoc Vu. All rights reserved.
//

import Foundation
import UIKit

struct HomeViewState: BaseViewState,Copy{
    var action: HomeAction
    var keywords: [HomeKeywordUIModel]
    
    init() {
        self.action = .idle
        self.keywords = []
    }
    
    enum HomeAction {
        case idle
        case loading
        case loaded
        case error(message: String)
    }
}

struct HomeKeywordUIModel: IpaCellModel {
    let keyword: String
    let url: String
    let backgroundColor: Int
}
