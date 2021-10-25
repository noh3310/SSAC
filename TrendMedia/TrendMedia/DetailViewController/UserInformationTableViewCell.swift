//
//  UserInformationTableViewCell.swift
//  TrendMedia
//
//  Created by 노건호 on 2021/10/17.
//

import UIKit

class UserInformationTableViewCell: UITableViewCell {
    
    static let identifier = "UserInformationTableViewCell"

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var castImageView: UIImageView!
    // 극중 이름
    @IBOutlet weak var roleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
