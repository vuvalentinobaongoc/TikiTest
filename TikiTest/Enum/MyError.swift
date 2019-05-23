//
//  MyError.swift
//  TikiTest
//
//  Created by Ngoc Vu on 5/22/19.
//  Copyright © 2019 Ngoc Vu. All rights reserved.
//

import Foundation
enum MyError: Error {
    case DataError(ErrorModel)
    case DataEmpty
    case NetworkError
}
