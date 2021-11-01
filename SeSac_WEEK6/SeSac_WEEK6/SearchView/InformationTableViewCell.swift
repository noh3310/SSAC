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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
