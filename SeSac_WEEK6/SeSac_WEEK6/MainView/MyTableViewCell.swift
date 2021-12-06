//
//  MyTableViewCell.swift
//  SeSac_WEEK6
//
//  Created by 노건호 on 2021/11/09.
//

import UIKit

class MyTableViewCell: UITableViewCell {
    
    static let identifier = "MyTableViewCell"

    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
//        collectionView.dataSource = self
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
