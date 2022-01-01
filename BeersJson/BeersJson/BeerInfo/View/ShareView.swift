//
//  ShareView.swift
//  BeersJson
//
//  Created by 노건호 on 2021/12/21.
//

import UIKit
import SnapKit

class ShareView: UIView {
    
    let refreshButton: UIButton = {
        let button = UIButton()
        
        button.layer.borderColor = UIColor.systemMint.cgColor
        button.layer.borderWidth = 10
        button.layer.cornerRadius = 20
        button.setImage(UIImage(systemName: "arrow.clockwise"), for: .normal)
        
        return button
    }()
    
    let shareButton: UIButton = {
        let button = UIButton()
        
        button.setTitle("SHARE", for: .normal)
        button.layer.borderColor = UIColor.systemMint.cgColor
        button.layer.borderWidth = 10
        button.layer.cornerRadius = 20
        button.backgroundColor = .systemMint
        
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .white
        
        self.addSubview(refreshButton)
        self.addSubview(shareButton)
        
        refreshButton.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(10)
            $0.top.bottom.equalToSuperview().inset(10)
            $0.width.equalTo(refreshButton.snp.height).multipliedBy(1/1)
        }
        
        shareButton.snp.makeConstraints {
            $0.top.bottom.trailing.equalToSuperview().inset(10)
            $0.leading.equalTo(refreshButton.snp.trailing).offset(10)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
