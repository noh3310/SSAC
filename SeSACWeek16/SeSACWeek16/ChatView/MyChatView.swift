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
    
    func setViews() {
        view.addSubview(chatLabel)
        self.addSubview(view)
        
        view.snp.makeConstraints {
            $0.top.bottom.equalToSuperview().inset(20)
            $0.width.equalToSuperview().multipliedBy(0.7)
            $0.trailing.equalToSuperview().inset(20)
        }
        
        chatLabel.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(20)
        }
    }
    
}
