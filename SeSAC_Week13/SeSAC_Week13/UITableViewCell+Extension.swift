//
//  UITableViewCell_Extension.swift
//  SeSAC_Week13
//
//  Created by 노건호 on 2021/12/21.
//

import UIKit

protocol ReusableView {
    static var reuseIdentifier: String { get }
}

extension UITableViewCell: ReusableView {
    static var reuseIdentifier: String {
        // 클래스 이름을 String으로 변경
        return String(describing: self)
    }
}
