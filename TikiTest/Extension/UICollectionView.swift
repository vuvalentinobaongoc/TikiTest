//
//  UICollectionView.swift
//  TikiTest
//
//  Created by Ngoc Vu on 5/23/19.
//  Copyright © 2019 Ngoc Vu. All rights reserved.
//

import UIKit

protocol Reusable {
    static func reuseId() -> String
}

extension Reusable {
    static func reuseId() -> String {
        return String(describing: self)
    }
}

extension UIView: Reusable {
    
    static func fromNib<T: UIView>() -> T {
        guard let view = Bundle.main.loadNibNamed(reuseId(), owner: nil, options: nil)?.first as? T else {
            fatalError("Could not load view with identifier \(reuseId())")
        }
        return view
    }
    
}

extension UICollectionView {
    
    func registerCell<T: UICollectionViewCell>(_ cellType: T.Type) {
        register(T.self, forCellWithReuseIdentifier: cellType.reuseId())
    }
    
    func registerNib<T: UICollectionViewCell>(_ cellType: T.Type) {
        let nib = UINib(nibName: cellType.reuseId(), bundle: nil)
        register(nib, forCellWithReuseIdentifier: cellType.reuseId())
    }
}


