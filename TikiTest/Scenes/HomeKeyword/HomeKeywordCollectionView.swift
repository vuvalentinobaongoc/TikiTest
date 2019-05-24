//
//  HomeKeywordCollectionView.swift
//  TikiTest
//
//  Created by Ngoc Vu on 5/22/19.
//  Copyright © 2019 Ngoc Vu. All rights reserved.
//

import Foundation
import UIKit
class HomeKeywordCollectionView: BaseCollectionView<HomeKeywordCollectionViewCell,HomeKeywordUIModel>,UICollectionViewDelegateFlowLayout {
    
    override func setup() {
        delegate = self
    }
    
    override func registerCells() {
        registerNib(HomeKeywordCollectionViewCell.self)
    }
    
    override func createCell(collectionView: UICollectionView, indexPath: IndexPath, with item: HomeKeywordUIModel) -> HomeKeywordCollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeKeywordCollectionViewCell", for: indexPath) as! HomeKeywordCollectionViewCell
        return cell
    }
    
    override func bindCell(cell: HomeKeywordCollectionViewCell, item: HomeKeywordUIModel) -> HomeKeywordCollectionViewCell {
        cell.item = item
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let keywordModel = get(index: indexPath.row)
        let heightOfKeyword = keywordModel.keyword.contains("\n") ? UIFont.systemFont(ofSize: 14.0).pointSize * 2 + 10 : UIFont.systemFont(ofSize: 14.0).pointSize
        let keywordLabelPading = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        let labelLayoutPadding:CGFloat = 32
        let keyWordLength = keywordModel.keyword.width(withConstrainedHeight: heightOfKeyword, font: UIFont.systemFont(ofSize: 14.0))
        return CGSize(width: keyWordLength + labelLayoutPadding + keywordLabelPading.left + keywordLabelPading.right, height: self.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
         return 100
    }

}
