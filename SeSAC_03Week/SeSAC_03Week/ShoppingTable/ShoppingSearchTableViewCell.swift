//
//  ShoppingTableViewCell.swift
//  SeSAC_03Week
//
//  Created by 노건호 on 2021/10/13.
//

import UIKit

class ShoppingSearchTableViewCell: UITableViewCell {

    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var searchButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // 버튼 설정
        setButton()
        
        self.backgroundColor = UIColor(red: 242/255, green: 242/255, blue: 247/255, alpha: 1)
        
        searchTextField.backgroundColor = .clear
        searchTextField.borderStyle = .none
        searchTextField.placeholder = "무엇을 구매하실 건가요?"
    }
    
    // 버튼 설정(텍스트, 색상, 테두리)
    func setButton() {
        searchButton.setTitle("추가", for: .normal)
        searchButton.tintColor = .black
        searchButton.backgroundColor = UIColor(red: 229/255, green: 229/255, blue: 234/255, alpha: 1)
        searchButton.layer.cornerRadius = 5
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }


}
