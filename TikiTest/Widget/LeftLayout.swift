//
//  LeftLayout.swift
//  TikiTest
//
//  Created by Ngoc Vu on 5/23/19.
//  Copyright © 2019 Ngoc Vu. All rights reserved.
//

import UIKit

protocol EMGCollectionViewLeftLayoutDelegate: class {
    func minimumWidth(_ emgCollectionViewLeftLayout: EMGCollectionViewLeftLayout) -> CGSize
}

class EMGCollectionViewLeftLayout: UICollectionViewFlowLayout {
    @IBInspectable var minimumItemSpacing:CGFloat = 10.0 {
        didSet {
            self.minimumInteritemSpacing = minimumItemSpacing
        }
    }
    @IBInspectable var lineSpacing:CGFloat = 10.0 {
        didSet {
            self.minimumLineSpacing = lineSpacing
        }
    }
    var isAutomaticSize: Bool?{
        didSet {
            setAutomaticSize()
        }
    }
    @IBInspectable var leftInset:CGFloat = 10.0
    @IBInspectable var rightInset:CGFloat = 10.0
    @IBInspectable var bottomInset:CGFloat = 10.0
    @IBInspectable var topInset:CGFloat = 10.0
    
    weak var leftLayoutDelegate: EMGCollectionViewLeftLayoutDelegate?
    var delegate: UICollectionViewDelegateFlowLayout? {
        return self.collectionView?.delegate as? UICollectionViewDelegateFlowLayout
    }
    
    override init() {
        super.init()
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    private func setAutomaticSize() {
        if let isAuto = isAutomaticSize,isAuto  {
            self.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        }
    }
    private func commonInit() {
        self.minimumInteritemSpacing = minimumItemSpacing
        self.minimumLineSpacing = lineSpacing
        self.sectionInset = UIEdgeInsets(top: topInset, left: leftInset, bottom: bottomInset, right: rightInset)
        setAutomaticSize()
    }
    
    override open func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        guard let attributesCollection = super.layoutAttributesForElements(in: rect) else {
            return nil
        }
        
        var updatedAttributes = [UICollectionViewLayoutAttributes]()
        attributesCollection.forEach({ (originalAttributes) in
            guard originalAttributes.representedElementKind == nil else {
                updatedAttributes.append(originalAttributes)
                return
            }
            
            if let updatedAttribute = self.layoutAttributesForItem(at: originalAttributes.indexPath) {
                updatedAttributes.append(updatedAttribute)
            }
        })
        
        return updatedAttributes
    }
    
    override open func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        guard let attributes = super.layoutAttributesForItem(at: indexPath)?.copy() as? UICollectionViewLayoutAttributes else {
            return nil
        }
        
        guard let collectionView = self.collectionView else {
            return attributes
        }
        
        let firstInSection: Bool = indexPath.item == 0
        guard !firstInSection else {
            let section = attributes.indexPath.section
            let x = self.delegate?.collectionView?(collectionView, layout: self, insetForSectionAt: section).left ?? self.sectionInset.left
            attributes.frame.origin.x = x
            return attributes
        }
        
        let previousAttributes = self.layoutAttributesForItem(at: IndexPath(item: indexPath.item - 1, section: indexPath.section))
        let previousFrame: CGRect = previousAttributes?.frame ?? CGRect()
        let firstInRow = previousAttributes?.center.y != attributes.center.y
        
        guard !firstInRow else {
            let section = attributes.indexPath.section
            let x = self.delegate?.collectionView?(collectionView, layout: self, insetForSectionAt: section).left ?? self.sectionInset.left
            attributes.frame.origin.x = x
            return attributes
        }
        
        let interItemSpacing: CGFloat = (collectionView.delegate as? UICollectionViewDelegateFlowLayout)?
            .collectionView?(collectionView, layout: self, minimumInteritemSpacingForSectionAt: indexPath.section) ?? self.minimumInteritemSpacing
        let x = previousFrame.origin.x + previousFrame.width + interItemSpacing
        if leftLayoutDelegate?.minimumWidth(self) == nil {
            attributes.frame = CGRect(x: x,
                                      y: attributes.frame.origin.y,
                                      width: attributes.frame.width,
                                      height: attributes.frame.height)
            return attributes
        } else {
            let minimumSize = leftLayoutDelegate?.minimumWidth(self) ?? CGSize.zero
            let width = max(minimumSize.width, attributes.frame.width)
            attributes.frame = CGRect(x: x,
                                      y: attributes.frame.origin.y,
                                      width: width,
                                      height: attributes.frame.height)
            return attributes
            
        }
        
    }
}
