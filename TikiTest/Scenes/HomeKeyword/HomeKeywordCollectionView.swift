//
//  HomeKeywordCollectionView.swift
//  TikiTest
//
//  Created by Ngoc Vu on 5/22/19.
//  Copyright © 2019 Ngoc Vu. All rights reserved.
//

import Foundation
import UIKit
//class HomeKeywordCollectionView: BaseCollectionView<HomeKeywordCollectionViewCell,HomeKeywordUIModel>,UICollectionViewDelegateFlowLayout {
//
//    override func setup() {
//        delegate = self
//    }
//
//    override func registerCells() {
//        registerNib(HomeKeywordCollectionViewCell.self)
//    }
//
//    override func createCell(collectionView: UICollectionView, indexPath: IndexPath, with item: HomeKeywordUIModel) -> HomeKeywordCollectionViewCell {
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeKeywordCollectionViewCell", for: indexPath) as! HomeKeywordCollectionViewCell
//        return cell
//    }
//
//    override func bindCell(cell: HomeKeywordCollectionViewCell, item: HomeKeywordUIModel) -> HomeKeywordCollectionViewCell {
//        cell.item = item
//        invalidateIntrinsicContentSize()
//        return cell
//    }
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        return CGSize(width: 400, height: 400)
//    }
//
//
//}
class HomeCollectionView: UICollectionView,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    
//    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
//        super.init(frame: frame, collectionViewLayout: layout)
//        commonInit()
//    }
//
//    required init?(coder aDecoder: NSCoder) {
//        super.init(coder: aDecoder)
//        commonInit()
//    }
    
    private func commonInit() {
        
        delegate = self
        dataSource = self
        registerNib(HomeKeywordCollectionViewCell.self)
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        commonInit()
    }
    var items: [HomeKeywordUIModel]? {
        didSet {
            config()
        }
    }
    
    private func config() {
        reloadData()
        invalidateIntrinsicContentSize()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeKeywordCollectionViewCell", for: indexPath) as! HomeKeywordCollectionViewCell
        cell.item = items?[indexPath.row]
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 400, height: 400)
    }
    
    override var contentSize: CGSize {
        didSet {
            
            invalidateIntrinsicContentSize()
        }
    }
    override var intrinsicContentSize: CGSize {
        return contentSize
    }
}
