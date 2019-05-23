//
//  HomeKeywordCollectionViewCell.swift
//  TikiTest
//
//  Created by Ngoc Vu on 5/22/19.
//  Copyright © 2019 Ngoc Vu. All rights reserved.
//

import UIKit

class HomeKeywordCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var labelKeyword: UILabel!
    @IBOutlet weak var imageViewKeyword: UIImageView!
    
    var item: HomeKeywordUIModel? {
        didSet {
            updateView()
        }
    }
    
    private func updateView() {
        if let item = item {
            labelKeyword.text = item.keyword
            labelKeyword.layer.backgroundColor = UIColor(rgb: item.backgroundColor).cgColor
        }
    }
}
