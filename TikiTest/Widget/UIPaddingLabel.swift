//
//  UIPaddingLabel.swift
//  TikiTest
//
//  Created by Ngoc Vu on 5/24/19.
//  Copyright © 2019 Ngoc Vu. All rights reserved.
//

import UIKit
@IBDesignable class UIPaddingLabel: UILabel {
    
    @IBInspectable var topInset: CGFloat = 10
    @IBInspectable var bottomInset: CGFloat = 10
    @IBInspectable var leftInset: CGFloat = 10
    @IBInspectable var rightInset: CGFloat = 10
    
    override func drawText(in rect: CGRect) {
        let insets = UIEdgeInsets.init(top: topInset, left: leftInset, bottom: bottomInset, right: rightInset)
        super.drawText(in: rect.inset(by: insets))
    }
    
    override var intrinsicContentSize: CGSize {
        let size = super.intrinsicContentSize
        return CGSize(width: size.width + leftInset + rightInset,
                      height: size.height + topInset + bottomInset)
    }
}
