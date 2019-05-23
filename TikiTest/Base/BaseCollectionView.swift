//
//  BaseCollectionView.swift
//  TikiTest
//
//  Created by Ngoc Vu on 5/22/19.
//  Copyright © 2019 Ngoc Vu. All rights reserved.
//

import Foundation
import UIKit

protocol IpaCellModel {
    
}

protocol BaseCollectionViewDelegate: class {
    func collectionView(collectionView: UICollectionView, contentSizeDidChanged size: CGSize)
}

class BaseCollectionView<C: UICollectionViewCell, M: IpaCellModel>: UICollectionView, UICollectionViewDataSource {
    weak var layoutDelegate : BaseCollectionViewDelegate?
    private var datas = [M]()
    
//    open override var contentSize: CGSize {
//        didSet {
//            self.layoutDelegate?.collectionView(collectionView: self, contentSizeDidChanged: self.collectionViewLayout.collectionViewContentSize)
//            invalidateIntrinsicContentSize()
//        }
//    }
//    override var intrinsicContentSize: CGSize {
//        get {
//            return collectionViewLayout.collectionViewContentSize
//        }
//    }
    
    func populate(items: [M]) {
        self.datas.removeAll()
        self.datas.append(contentsOf: items)
        self.reloadData()
    }
    
    func get(index: Int) -> M {
        return datas[index]
    }
    func getNumberItems() -> Int {
        return datas.count
    }
    
    func registerCells() {
    }
    
    func createCell(collectionView: UICollectionView, indexPath: IndexPath,with item: M) -> C {
        fatalError()
    }
    func bindCell(cell: C, item: M) -> C {
        fatalError()
    }
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    func commonInit() {
        self.dataSource = self
        self.registerCells()
        self.setup()
    }
    func setup() {}
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return datas.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = createCell(collectionView: collectionView, indexPath: indexPath,with: self.datas[indexPath.row])
        return bindCell(cell: cell, item: self.datas[indexPath.row])
    }
}

