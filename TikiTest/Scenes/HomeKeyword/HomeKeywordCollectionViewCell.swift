//
//  HomeKeywordCollectionViewCell.swift
//  TikiTest
//
//  Created by Ngoc Vu on 5/22/19.
//  Copyright © 2019 Ngoc Vu. All rights reserved.
//

import UIKit
import Kingfisher

class HomeKeywordCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var labelKeyword: UIPaddingLabel!
    @IBOutlet weak var imageViewKeyword: UIImageView!
    
    var item: HomeKeywordUIModel? {
        didSet {
            updateView()
        }
    }
    
    private func updateView() {
        if let item = item {
            let paragraph = NSMutableParagraphStyle()
            paragraph.alignment = .center
            labelKeyword.attributedText = NSAttributedString(string: item.keyword, attributes: [NSAttributedString.Key.paragraphStyle : paragraph])
            labelKeyword.layer.backgroundColor = UIColor(rgb: item.backgroundColor).cgColor
            imageViewKeyword.setBestImage(url: URL(string: item.url)!)
        }
    }
}
