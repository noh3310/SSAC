//
//  MelonBottmView.swift
//  SeSac_Week12
//
//  Created by 노건호 on 2021/12/14.
//

import UIKit
import SnapKit

class MelonBottomView: UIView {
    
    // 플레이리스트 버튼
    let playlistButton: UIButton = {
        let button = UIButton()
        
        button.setImage(UIImage(systemName: "music.note.list"), for: .normal)
        button.tintColor = .white
        
        return button
    }()
    
    // 뒤로 버튼
    let backwardButton: UIButton = {
        let button = UIButton()
        
        button.setImage(UIImage(systemName: "backward.end.fill"), for: .normal)
        button.tintColor = .white
        
        return button
    }()
    
    let stopAndPlayButton: UIButton = {
        let button = UIButton()
        
        // 클릭하면 변하게 할 계획
        // pause.fill
        button.setImage(UIImage(systemName: "play.fill"), for: .normal)
        button.tintColor = .white
        // 터치 이벤트 설정
        button.addTarget(self, action: #selector(stopAndPlayButtonClicked(_:)), for: .touchUpInside)
        
        return button
    }()
    
    let forwardButton: UIButton = {
        let button = UIButton()
        
        button.setImage(UIImage(systemName: "forward.end.fill"), for: .normal)
        button.tintColor = .white
        
        return button
    }()
    
    let eqButton: UIButton = {
        let button = UIButton()
        
        button.setImage(UIImage(systemName: "infinity"), for: .normal)
        button.tintColor = .white
        
        return button
    }()
    
    // play버튼 클릭했을때 버튼 이미지 toggle해줌(우선은 그냥 이렇게만 만듬)
    @objc
    func stopAndPlayButtonClicked(_ button: UIButton) {
        if button.currentImage! == UIImage(systemName: "play.fill") {
            button.setImage(UIImage(systemName: "pause.fill"), for: .normal)
        } else {
            button.setImage(UIImage(systemName: "play.fill"), for: .normal)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addSubview(playlistButton)
        self.addSubview(backwardButton)
        self.addSubview(stopAndPlayButton)
        self.addSubview(forwardButton)
        self.addSubview(eqButton)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
