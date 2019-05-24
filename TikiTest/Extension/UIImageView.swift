//
//  UIImageView.swift
//  TikiTest
//
//  Created by Ngoc Vu on 5/24/19.
//  Copyright © 2019 Ngoc Vu. All rights reserved.
//

import UIKit
import Kingfisher

extension UIImageView {
    func setBestImage(url: URL,placeHolder: String = "no_image", loadingImage: String? = "no_image") {
        let size = (bounds.size.width > 0 || bounds.size.height > 0) ? bounds.size : CGSize(width: 300, height: 300)
        var kf = self.kf
        kf.indicatorType = .activity
        kf.setImage(
            with: url,
            placeholder: UIImage(named: placeHolder),
            options: [
                .processor(DownsamplingImageProcessor(size: size)),
                .scaleFactor(UIScreen.main.scale),
                .cacheOriginalImage
            ])
    }
}

