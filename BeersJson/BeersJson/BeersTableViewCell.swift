//
//  BeersTableViewCell.swift
//  BeersJson
//
//  Created by 노건호 on 2021/12/20.
//

import UIKit
import SnapKit

class BeersTableViewCell: UITableViewCell {
    
    static let identifier = "BeersTableViewCell"
    
    let beerImage: UIImageView = {
        let imageView = UIImageView()
        
        imageView.layer.cornerRadius = 10
        imageView.image = UIImage(systemName: "star")
        
        return imageView
    }()
    
    let beerName: UILabel = {
        let label = UILabel()
        
        label.text = "맥주!"
        
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.addSubview(beerImage)
        beerImage.snp.makeConstraints {
            $0.top.equalToSuperview().inset(5)
            $0.bottom.equalToSuperview().inset(5)
            $0.left.equalToSuperview().inset(5)
            // 1:1 비율로 이미지 설정
            $0.width.equalTo(beerImage.snp.height).multipliedBy(1.0 / 1.0)
        }
        
        self.addSubview(beerName)
        beerName.snp.makeConstraints {
            $0.left.equalTo(beerImage.snp.right).offset(10)
            $0.centerY.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setCell(_ beer: Beer) {
        // 이미지 주소 받아옴
        let url = URL(string: beer.imageURL)
        DispatchQueue.global().async {
            let data = try? Data(contentsOf: url!)
            DispatchQueue.main.async {  // UI변경은 메인스레드에서 함
                self.beerImage.image = UIImage(data: data!)
            }
        }
        
        // 텍스트 변경
        beerName.text = beer.name
    }
}
