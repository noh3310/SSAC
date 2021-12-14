//
//  MelonPlayView.swift
//  SeSac_Week12
//
//  Created by 노건호 on 2021/12/15.
//

import UIKit

class MelonPlayView: UIView {
    
    let cycleButton: UIButton = {
        let button = UIButton()
        
        // repeat.1
        // 처음에는 gray색, 그다음에는 흰색, 그다음에는 repeat.1
        button.setImage(UIImage(systemName: "repeat"), for: .normal)
        button.tintColor = .systemGray
        
        button.addTarget(self, action: #selector(cycleButtonClicked(_:)), for: .touchUpInside)
        
        return button
    }()
    
    let shuffleButton: UIButton = {
        let button = UIButton()
        
        button.setImage(UIImage(systemName: "shuffle"), for: .normal)
        button.tintColor = .white
        
        return button
    }()
    
    let statusView: UIProgressView = {
        let view = UIProgressView()
        // 끝이 둥글게 만들어짐
        view.progressViewStyle = .default
        // tint color 녹색(나중에 멜론색 따던지 해야할듯)
        view.progressTintColor = .green
        // 기본 색상
        view.trackTintColor = .lightGray
        // 얼마나 채울것인지 설정(초기값은 0으로 설정)
        view.progress = 0
        
        return view
    }()
    
    let totalTime: UILabel = {
        let label = UILabel()
        
        label.text = "1:00"
        label.textColor = .white
        label.font = .systemFont(ofSize: 13)
        
        return label
    }()
    
    let currentTime: UILabel = {
        let label = UILabel()
        
        label.text = "0:00"
        label.textColor = .green
        label.font = .systemFont(ofSize: 13)
        
        return label
    }()
    
    @objc
    func cycleButtonClicked(_ button: UIButton) {
        if button.currentImage! == UIImage(systemName: "repeat") && button.tintColor == .systemGray {
            button.tintColor = .white
        } else if button.currentImage! == UIImage(systemName: "repeat") && button.tintColor == .white {
            button.setImage(UIImage(systemName: "repeat.1"), for: .normal)
        } else {
            button.setImage(UIImage(systemName: "repeat"), for: .normal)
            button.tintColor = .systemGray
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addSubview(cycleButton)
        self.addSubview(shuffleButton)
        self.addSubview(statusView)
        self.addSubview(currentTime)
        self.addSubview(totalTime)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
