//
//  ApiRouter.swift
//  TikiTest
//
//  Created by Ngoc Vu on 5/22/19.
//  Copyright © 2019 Ngoc Vu. All rights reserved.
//

import Alamofire

enum ApiRouter: URLRequestConvertible {
    static let baseURL = "https://tiki-mobile.s3-ap-southeast-1.amazonaws.com"
    
    case getKeywords
    var method: Alamofire.HTTPMethod {
        switch self {
        case .getKeywords:
            return .get
        }
    }
    var path: String {
        switch self {
        case .getKeywords:
            return "/ios/keywords.json"
        }
    }
    
    func asURLRequest() throws -> URLRequest {
        let url = URL(string: ApiRouter.baseURL)!
        var urlRequest = URLRequest(url: url.appendingPathComponent(path))
        urlRequest.httpMethod = method.rawValue
        urlRequest.cachePolicy = .reloadIgnoringLocalCacheData
        
        switch self {
        default:
            return urlRequest
        }
    }
}
