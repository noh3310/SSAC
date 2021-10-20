//
//  MyMediaCollectionViewCell.swift
//  TrendMedia
//
//  Created by 노건호 on 2021/10/20.
//

import UIKit

class MyMediaCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "MyMediaCollectionViewCell"

    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var movieRateLabel: UILabel!
    @IBOutlet weak var moviePosterImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
