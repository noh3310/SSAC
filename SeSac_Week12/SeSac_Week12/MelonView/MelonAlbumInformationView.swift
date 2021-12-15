//
//  MelonAlbumView.swift
//  SeSac_Week12
//
//  Created by 노건호 on 2021/12/15.
//

import UIKit

class MelonAlbumInformationView: UIView {
    
    // 좋아요 버튼
    let favoriteButton: UIButton = {
        let button = UIButton()
        
        // heart.fill
        button.setImage(UIImage(systemName: "heart"), for: .normal)
        button.addTarget(self, action: #selector(favoriteButtonClicked(_:)), for: .touchUpInside)
        button.tintColor = .white
        
        return button
    }()
    
    let favoriteCountLabel: UILabel = {
        let label = UILabel()
        
        label.text = "999,999"
        label.textColor = .white
        
        return label
    }()
    
    let similarMusicButton: UIButton = {
        let button = UIButton()
        
        button.setTitle("유사곡", for: .normal)
        
        button.titleLabel?.font = .systemFont(ofSize: 15)
        button.setTitleColor(.black, for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.white.cgColor
        button.layer.cornerRadius = 10
        
        return button
    }()
    
    let instagramButton: UIButton = {
        let button = UIButton()
        
        button.setImage(UIImage(named: "Instagram_Logo"), for: .normal)
        
        return button
    }()
    
    @objc
    func favoriteButtonClicked(_ button: UIButton) {
        if button.currentImage! == UIImage(systemName: "heart") {
            button.setImage(UIImage(systemName: "heart.fill"), for: .normal)
            favoriteCountLabel.text = "1,000,000"
        } else {
            button.setImage(UIImage(systemName: "heart"), for: .normal)
            favoriteCountLabel.text = "999,999"
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        favoriteButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
        }
        
        self.addSubview(favoriteButton)
        self.addSubview(favoriteCountLabel)
        self.addSubview(similarMusicButton)
        self.addSubview(instagramButton)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
