//
//  CarrotItemTableViewCell.swift
//  SeSac_Week12
//
//  Created by 노건호 on 2021/12/15.
//

import UIKit
import SnapKit

class CarrotItemTableViewCell: UITableViewCell {
    
    static let identifier = "CustomCell"
    
    let itemImageView: UIImageView = {
        let imageView = UIImageView()
        let image = UIImage(systemName: "star.fill")!
        imageView.image = image
//        imageView.setContentHuggingPriority(.required, for: .horizontal)
//        imageView.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        return imageView
    }()
    
    let itemTitle: UILabel = {
        let label = UILabel()
        
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.addSubview(itemTitle)
        self.addSubview(itemImageView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
