//
//  SummaryTableViewCell.swift
//  TrendMedia
//
//  Created by 노건호 on 2021/10/19.
//

import UIKit

class SummaryTableViewCell: UITableViewCell {
    
    static let identifier = "SummaryTableViewCell"

    @IBOutlet weak var summaryTextLabel: UILabel!
    
    @IBOutlet weak var sizeButton: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
