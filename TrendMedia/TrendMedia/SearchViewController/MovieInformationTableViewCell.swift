//
//  MovieInformationTableViewCell.swift
//  TrendMedia
//
//  Created by 노건호 on 2021/10/18.
//

import UIKit

class MovieInformationTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var releaseDate: UILabel!
    @IBOutlet weak var Overview: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        
        // 이미지 크기에 맞춤
        setPosterImageView()
    }
    
    func setPosterImageView() {
        posterImageView.contentMode = .scaleAspectFill
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
