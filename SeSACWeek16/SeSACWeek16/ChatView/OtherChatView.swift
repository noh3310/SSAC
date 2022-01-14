//
//  OtherChatView.swift
//  SeSACWeek16
//
//  Created by 노건호 on 2022/01/13.
//

import UIKit
import SnapKit

class OtherChatView: UITableViewCell {
    
    static let identifier = "OtherChatView"
    
    let userNameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20)
        label.tintColor = .white
        return label
    }()
    
    let chatLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.tintColor = .white
        return label
    }()
    
    let view : UIView = {
        let view = UIView()
        view.backgroundColor = .systemBlue
        view.layer.cornerRadius = 20
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setViews() {
        view.addSubview(chatLabel)
//        view.addSubview(userNameLabel)
        self.addSubview(view)
        
//        userNameLabel.snp.makeConstraints {
//            $0.top.leading.equalToSuperview().offset(20)
//        }
        
        view.snp.makeConstraints {
//            $0.top.equalTo(userNameLabel.snp.bottom).inset(10)
            $0.top.equalToSuperview().inset(20)
            $0.bottom.equalToSuperview().inset(20)
            $0.width.equalToSuperview().multipliedBy(0.7)
            $0.leading.equalToSuperview().inset(20)
        }
        
        chatLabel.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(20)
        }
    }
    
}

