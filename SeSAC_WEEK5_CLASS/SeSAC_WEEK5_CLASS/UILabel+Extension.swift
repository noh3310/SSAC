//
//  UIView+Extension.swift
//  SeSAC_WEEK5_CLASS
//
//  Created by 노건호 on 2021/10/29.
//

import UIKit

extension UILabel {
    func setBorderStyle() {
        self.backgroundColor = .blue
        self.clipsToBounds = true
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.black.cgColor
    }
    
}
