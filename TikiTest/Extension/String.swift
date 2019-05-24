//
//  String.swift
//  TikiTest
//
//  Created by Ngoc Vu on 5/23/19.
//  Copyright © 2019 Ngoc Vu. All rights reserved.
//

import UIKit
extension String {
    func height(withConstrainedWidth width: CGFloat, font: UIFont) -> CGFloat {
        guard !self.isEmpty else {
            return 0.0
        }
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [.font: font], context: nil)
        return ceil(boundingBox.height)
    }
    
    func width(withConstrainedHeight height: CGFloat, font: UIFont) -> CGFloat {
        guard !self.isEmpty else {
            return 0.0
        }
        let constraintRect = CGSize(width: .greatestFiniteMagnitude, height: height)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [.font: font], context: nil)
        
        return ceil(boundingBox.width)
    }
    
    func splitSentenceToModel() -> String {
        
        let newArr = components(separatedBy: ["(", ")"])
        var finalArr = [String]()
        for (index, value) in newArr.enumerated() {
            if (index + 1) % 2 == 1 {
                finalArr.append(contentsOf: value.components(separatedBy: " ").filter { $0 != "" })
            }
            else {
                finalArr.append(value)
            }
        }
        
        if finalArr.count > 1 {
            finalArr[(finalArr.count - 1) / 2].append(contentsOf: "\n")
            return finalArr.joined(separator: " ")
        } else {
            return finalArr.joined(separator: " ")
        }
    }
}
