//
//  BeerParingView.swift
//  BeersJson
//
//  Created by 노건호 on 2021/12/21.
//

import UIKit

class BeerParingView: UIView {
    
    let paringLabel: UILabel = {
        let label = UILabel()
        
        label.font = .boldSystemFont(ofSize: 30)
        
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addSubview(paringLabel)
//        paringLabel
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
