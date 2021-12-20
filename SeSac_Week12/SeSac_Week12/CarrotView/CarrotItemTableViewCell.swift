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
    
    // 중고거래 위치
    let itemLocation: UILabel = {
        let label = UILabel()
        
        return label
    }()
    
    // 중고거래 위치
    let itemPrice: UILabel = {
        let label = UILabel()
        
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.addSubview(itemTitle)
        self.addSubview(itemImageView)
        self.addSubview(itemLocation)
        self.addSubview(itemPrice)
        
        itemImageView.snp.makeConstraints { make in
//            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(20)
            make.top.equalToSuperview().inset(20)
            make.bottom.equalToSuperview().inset(20)
            // 1:1 비율로 이미지 설정
            make.width.equalTo(itemImageView.snp.height).multipliedBy(1.0 / 1.0)
        }
        
        itemTitle.text = "뭘"
        itemTitle.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalTo(itemImageView.snp.right).offset(20)
        }
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
