//
//  ShoppingListTableViewCell.swift
//  SeSAC_03Week
//
//  Created by 노건호 on 2021/10/13.
//

import UIKit

class ShoppingListTableViewCell: UITableViewCell {
    
    @IBOutlet weak var checkboxButton: UIButton!
    @IBOutlet weak var favoriteButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // 체크박스 초기화
        setCheckBox()
        
        // 셀 배경색 설정
        setBackground()
        
        // 즐겨찾기 버튼 초기화
        setFavoriteButton()
        
    }
    
    // 체크박스 초기화
    func setCheckBox() {
        // checkmark.square - 체크박스 비어있는것
        // checkmark.square.fill - 체크박스 차있는거
        checkboxButton.setImage(UIImage(systemName: "checkmark.square"), for: .normal)
        checkboxButton.tintColor = .black
        checkboxButton.setTitle("", for: .normal)
    }
    
    // 셀 배경 설정
    func setBackground() {
        self.backgroundColor = UIColor(red: 242/255, green: 242/255, blue: 247/255, alpha: 1)
    }
    
    // 즐겨찾기 버튼 초기화
    func setFavoriteButton() {
        // star - 비어있는 별
        // star.fill - 차있는 별
        favoriteButton.setImage(UIImage(systemName: "star"), for: .normal)
        favoriteButton.tintColor = .black
        favoriteButton.setTitle("", for: .normal)
    }
    
    // 일단은 다른것들은 없고 그냥 누르면 이미지 변경됨
    @IBAction func checkboxClicked(_ sender: UIButton) {
        
        if sender.currentImage == UIImage(systemName: "checkmark.square") {
            sender.setImage(UIImage(systemName: "checkmark.square.fill"), for: .normal)
        }
        else {
            sender.setImage(UIImage(systemName: "checkmark.square"), for: .normal)
        }
    }
    
    // 일단은 이미지 변경만 구현
    @IBAction func favoriteButtonClicked(_ sender: UIButton) {
        if sender.currentImage == UIImage(systemName: "star") {
            sender.setImage(UIImage(systemName: "star.fill"), for: .normal)
        }
        else {
            sender.setImage(UIImage(systemName: "star"), for: .normal)
        }
    }
    
    

}
