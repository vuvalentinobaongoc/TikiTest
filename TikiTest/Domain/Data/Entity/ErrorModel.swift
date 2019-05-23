//
//  ErrorModel.swift
//  TikiTest
//
//  Created by Ngoc Vu on 5/22/19.
//  Copyright © 2019 Ngoc Vu. All rights reserved.
//

import Foundation
import Gloss
struct ErrorModel: JSONDecodable {
    let errorCode: Int?
    let error: String?
    let message: String?
    init?(json: JSON) {
        self.errorCode = "statusCode" <~~ json
        self.error = "error" <~~ json
        self.message = "message" <~~ json
    }
    init(statusCode : Int ,message : String, error : String){
        self.error = error
        self.errorCode = statusCode
        self.message = message
    }
}
