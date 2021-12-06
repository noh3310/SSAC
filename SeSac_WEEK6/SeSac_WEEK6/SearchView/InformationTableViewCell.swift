//
//  InformationTableViewCell.swift
//  SeSac_WEEK6
//
//  Created by 노건호 on 2021/11/02.
//

import UIKit

class InformationTableViewCell: UITableViewCell {
    
    static let identifier = "InformationTableViewCell"
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var contentsLabel: UILabel!
    @IBOutlet weak var imageLabel: UIImageView!
    
    func configureCell(row: UserDiary) {
//        let row = tasks[indexPath.row]
        titleLabel.text = row.diaryTitle
//        cell.dateLabel.text = "\(row.writeDate)"
        // 날짜형식 맞게 변환
        let format = DateFormatter()
        format.dateFormat = "yyyy년 MM월 dd일"
        dateLabel.text = format.string(from: row.writeDate)
        
        contentsLabel.text = row.content
        contentsLabel.numberOfLines = 0
        imageLabel.backgroundColor = .gray
//        imageLabel.image = loadImageFromDocumentDirectory(imageName: "\(row._id).jpg")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
