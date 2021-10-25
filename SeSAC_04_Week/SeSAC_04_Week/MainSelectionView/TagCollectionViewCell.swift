//
//  TagCollectionViewCell.swift
//  SeSAC_04_Week
//
//  Created by 노건호 on 2021/10/19.
//

import UIKit

class TagCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "TagCollectionViewCell"

    @IBOutlet weak var taglabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
