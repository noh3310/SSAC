//
//  BeerInfoView.swift
//  BeersJson
//
//  Created by 노건호 on 2021/12/20.
//

import UIKit

class BeerInfoView: UIView {
    
    let beerTitleLabel: UILabel = {
        let label = UILabel()
        
//        label.font = .systemFont(ofSize: 30)
        label.font = .boldSystemFont(ofSize: 20)
        label.text = "Buzz"
        
        return label
    }()
    
    let taglineLabel: UILabel = {
        let label = UILabel()
        
        label.font = .systemFont(ofSize: 15)
        label.text = "A Real Bitter Experience."
        
        return label
    }()
    
    let descriptionLabel: UILabel = {
        let label = UILabel()
        
        // 일단은 4줄로 설정
        label.numberOfLines = 4
        label.font = .systemFont(ofSize: 13)
        label.text = "A light, crisp and bitter IPA brewed with English and American hops. A small batch brewed only once.A light, crisp and bitter IPA brewed with English and American hops. A small batch brewed only once.A light, crisp and bitter IPA brewed with English and American hops. A small batch brewed only once.A light, crisp and bitter IPA brewed with English and American hops. A small batch brewed only once.A light, crisp and bitter IPA brewed with English and American hops. A small batch brewed only once.A light, crisp and bitter IPA brewed with English and American hops. A small batch brewed only once."
        
        return label
    }()
    
    let moreButton: UIButton = {
        let button = UIButton()
        
        button.setTitle("", for: .normal)
        button.setImage(UIImage(systemName: "arrowtriangle.down.fill"), for: .normal)
        button.tintColor = .black
        
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        moreButton.addTarget(self, action: #selector(moreButtonClicked(_:)), for: .touchUpInside)
        
        self.addSubview(beerTitleLabel)
        beerTitleLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview().inset(20)
        }
        
        self.addSubview(taglineLabel)
        taglineLabel.snp.makeConstraints {
            $0.top.equalTo(beerTitleLabel.snp.bottom).offset(20)
            $0.centerX.equalToSuperview()
        }
        
        
        self.addSubview(moreButton)
        moreButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalToSuperview().inset(10)
        }
        
        
        self.addSubview(descriptionLabel)
        descriptionLabel.snp.makeConstraints {
            $0.top.equalTo(taglineLabel.snp.bottom).offset(20)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.bottom.equalTo(moreButton.snp.top).offset(-20)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc
    func moreButtonClicked(_ button: UIButton) {
        if button.currentImage == UIImage(systemName: "arrowtriangle.down.fill") {
            descriptionLabel.numberOfLines = 0
            button.setImage(UIImage(systemName: "arrowtriangle.up.fill"), for: .normal)
        } else {
            descriptionLabel.numberOfLines = 4
            button.setImage(UIImage(systemName: "arrowtriangle.down.fill"), for: .normal)
        }
    }
}
