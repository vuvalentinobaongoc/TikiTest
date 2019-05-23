//
//  Collection.swift
//  TikiTest
//
//  Created by Ngoc Vu on 5/23/19.
//  Copyright © 2019 Ngoc Vu. All rights reserved.
//

import Foundation
extension Collection where Indices.Iterator.Element == Index {
    subscript (exist index: Index) -> Iterator.Element? {
        return indices.contains(index) ? self[index] : nil
    }
}
