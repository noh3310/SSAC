//
//  MyChatView.swift
//  SeSACWeek16
//
//  Created by 노건호 on 2022/01/13.
//

import UIKit
import SnapKit

class MyChatView: UITableViewCell {
    
    static let identifier = "MyChatView"
    
    let userNameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20)
        label.tintColor = .black
        label.text = "나"
        return label
    }()
    
    let chatLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.tintColor = .black
        return label
    }()
    
    let view : UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray6
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
    
//    override func updateConfiguration(using state: UICellConfigurationState) {
//        super.updateConfiguration(using: state)
//        
//        var contentConfig = defaultContentConfiguration().updated(for: state)
//        contentConfig.text = "Hello World"
//        contentConfig.image = UIImage(systemName: "bell")
//
//        var backgroundConfig = backgroundConfiguration?.updated(for: state)
//        backgroundConfig?.backgroundColor = .purple
//
//        if state.isHighlighted || state.isSelected {
//            backgroundConfig?.backgroundColor = .orange
//            contentConfig.textProperties.color = .red
//            contentConfig.imageProperties.tintColor = .yellow
//        }
//
//        contentConfiguration = contentConfig
//        backgroundConfiguration = backgroundConfig
//    }
    
    func setViews() {
        view.addSubview(chatLabel)
//        view.addSubview(userNameLabel)
        self.addSubview(view)
        
//        userNameLabel.snp.makeConstraints {
//            $0.top.trailing.equalToSuperview().offset(20)
//        }
        
        view.snp.makeConstraints {
//            $0.top.equalTo(userNameLabel.snp.bottom).inset(10)
            $0.top.equalToSuperview().inset(20)
            $0.bottom.equalToSuperview().inset(20)
            $0.width.equalToSuperview().multipliedBy(0.7)
            $0.trailing.equalToSuperview().inset(20)
        }
        
        chatLabel.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(20)
        }
    }
    
}
