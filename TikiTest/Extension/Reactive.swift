//
//  Reactive.swift
//  TikiTest
//
//  Created by Ngoc Vu on 5/22/19.
//  Copyright © 2019 Ngoc Vu. All rights reserved.
//

import Alamofire
import RxSwift
import RxAlamofire
import Gloss
import UIKit
import RxCocoa

extension Reactive where Base: DataRequest {
    func validateSuccessfulResponse2() -> DataRequest {
        return self.base.validate(statusCode: 200 ..< 300)
    }
    public func jsonWithErrorData(options: JSONSerialization.ReadingOptions = .allowFragments) -> Observable<Any> {
        return resultWithErrorData(responseSerializer: Base.jsonResponseSerializer(options: options))
    }
    public func resultWithErrorData<T: DataResponseSerializerProtocol>(queue: DispatchQueue? = nil, responseSerializer: T) -> Observable<T.SerializedObject> {
        return Observable.create { observer in
            let dataRequest = self.validateSuccessfulResponse2()
                .response(queue: queue, responseSerializer: responseSerializer) { (packedResponse) -> Void in
                    #if DEBUG
                    print(packedResponse.request ?? "NO REQUEST")
                    #endif
                    switch packedResponse.result {
                    case .success(let result):
                        if let _ = packedResponse.response {
                            observer.on(.next(result))
                        }
                        else {
                            observer.on(.error(RxAlamofireUnknownError))
                        }
                        observer.on(.completed)
                    case .failure(_):
                        guard let statusCode = packedResponse.response?.statusCode else {
                            observer.on(.error(MyError.NetworkError))
                            return
                        }
                        if statusCode == 201 {
                            observer.on(.completed)
                            return
                        }
                        guard let bodyData = packedResponse.data else {
                            observer.on(.error(RxAlamofireUnknownError))
                            return
                        }
                        
                        let jsonErrorData = try? JSONSerialization.jsonObject(with: bodyData)
                        guard let jsonError = jsonErrorData as? JSON else {
                            observer.on(.error(RxAlamofireUnknownError))
                            return
                        }
                        guard let errorModel = ErrorModel(json: jsonError) else {
                            observer.on(.error(RxAlamofireUnknownError))
                            return
                        }
                        observer.on(.error(MyError.DataError(errorModel)))
                    }
            }
            return Disposables.create {
                dataRequest.cancel()
            }
        }
    }
}
