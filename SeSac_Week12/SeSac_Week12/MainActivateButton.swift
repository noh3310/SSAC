//
//  MainActivateButton.swift
//  SeSac_Week12
//
//  Created by 노건호 on 2021/12/13.
//

import UIKit

@IBDesignable
class MainActivateButton: UIButton {
    
    // 이렇게 설정하면 실행하지 않고 알 수 있음
    @IBInspectable var cornerRadius: CGFloat {
        get {
            return self.layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
        }
    }
    
    @IBInspectable var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }
    
    @IBInspectable var borderColor: UIColor {
        get {
            return UIColor(cgColor: layer.borderColor!)
        }
        set {
            layer.borderColor = newValue.cgColor
        }
    }
}
