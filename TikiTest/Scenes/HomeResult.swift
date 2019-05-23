//
//  HomeResult.swift
//  TikiTest
//
//  Created by Ngoc Vu on 5/22/19.
//  Copyright © 2019 Ngoc Vu. All rights reserved.
//

import Foundation
enum HomeResult: BaseViewResult {
    case error(errorMessage: String)
    case loading
    case loaded(entity: [HomeKeywordEntity])
}
