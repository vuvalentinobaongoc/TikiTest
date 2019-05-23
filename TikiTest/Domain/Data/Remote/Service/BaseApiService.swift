//
//  BaseApiService.swift
//  TikiTest
//
//  Created by Ngoc Vu on 5/22/19.
//  Copyright © 2019 Ngoc Vu. All rights reserved.
//

import RxSwift
import RxAlamofire
import Gloss
import Alamofire

class BaseApiService {
    func executeList<T: JSONDecodable>(urlRequest: URLRequestConvertible) -> Observable<[T]> {
        return request(urlRequest).flatMap { request in
            return request.rx.jsonWithErrorData().map{ rs in
                guard let responseJson = rs as? [JSON] else {
                    return []
                }
                return [T].from(jsonArray: responseJson) ?? []
            }
        }
    }
    
    func execute<T: JSONDecodable>(urlRequest: URLRequestConvertible) -> Observable<T?> {
        return request(urlRequest).flatMap { request in
            return request.rx.jsonWithErrorData().map{ rs in
                guard let responseJson = rs as? JSON else {
                    return nil
                }
                return T(json: responseJson)
            }
        }
    }
}
