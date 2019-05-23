//
//  BaseDataStoreFactory.swift
//  TikiTest
//
//  Created by Ngoc Vu on 5/22/19.
//  Copyright © 2019 Ngoc Vu. All rights reserved.
//

import Foundation

class BaseDataStoreFactory<D,R,C> : DataStoreFactory {
    typealias DataStore = D
    typealias Remote = R
    typealias Cache = C
    
    private let cacheDataStore: C
    private let remoteDataStore: R
    
    init(cache: C, remote: R) {
        self.cacheDataStore = cache
        self.remoteDataStore = remote
    }
    func getDataStore(isCache: Bool) -> D {
        if isCache {
            return cacheDataStore as! D
        }
        return remoteDataStore as! D
    }
    
    func getCacheDataStore() -> C {
        return cacheDataStore
    }
    
    func getRemoteDataStore() -> R {
        return remoteDataStore
    }
}
protocol DataStoreFactory {
    associatedtype DataStore
    associatedtype Cache
    associatedtype Remote
    func getDataStore(isCache: Bool) ->  DataStore
    func getCacheDataStore() -> Cache
    func getRemoteDataStore() -> Remote
}
