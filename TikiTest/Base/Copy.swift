//
//  Copy.swift
//  TikiTest
//
//  Created by Ngoc Vu on 5/22/19.
//  Copyright © 2019 Ngoc Vu. All rights reserved.
//


protocol Copy {
}

extension Copy {
    func copy(copy: (inout Self) -> Void) -> Self {
        var value = self
        copy(&value)
        return value
    }
}
