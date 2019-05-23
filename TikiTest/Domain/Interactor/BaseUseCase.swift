//
//  BaseUseCase.swift
//  TikiTest
//
//  Created by Ngoc Vu on 5/22/19.
//  Copyright © 2019 Ngoc Vu. All rights reserved.
//

import Foundation
import RxSwift

protocol BaseUseCaseParram {
    
}

protocol BaseUseResponse {
    
}


protocol BaseUseCase {
    associatedtype P: BaseUseCaseParram
    associatedtype R: BaseUseResponse
    func buildUseCase(parram: P?) -> Observable<R>
}
extension BaseUseCase {
    func execute(parram: P? = nil) -> Observable<R> {
        return buildUseCase(parram: parram)
            .subscribeOn(ConcurrentDispatchQueueScheduler(qos: .background))
            .observeOn(MainScheduler.instance)
    }
}

