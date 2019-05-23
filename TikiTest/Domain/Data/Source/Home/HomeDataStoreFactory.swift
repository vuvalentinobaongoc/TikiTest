//
//  HomeDataStoreFactory.swift
//  TikiTest
//
//  Created by Ngoc Vu on 5/22/19.
//  Copyright © 2019 Ngoc Vu. All rights reserved.
//

import Foundation

class HomeDataStoreFactory: BaseDataStoreFactory<HomeDataStore, HomeRemoteDataStore, HomeCacheDataStore> {
    
}
extension HomeDataStoreFactory {
    static func newInstance(cache: HomeCacheDataStore = HomeCacheDataStore(),remote: HomeRemoteDataStore = HomeRemoteDataStore.newInstance()) -> HomeDataStoreFactory {
        return HomeDataStoreFactory(cache: cache, remote: remote)
        
    }
}
