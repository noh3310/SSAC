//
//  BoxOfficeTableViewCell.swift
//  SeSAC_03Week
//
//  Created by 노건호 on 2021/10/13.
//

import UIKit

class BoxOfficeTableViewCell: UITableViewCell {

    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var overviewLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        posterImageView.backgroundColor = .red
        titleLabel.text = "7번방의 선물"
        releaseDateLabel.text = "2012.02.02"
        overviewLabel.text = "영화 줄거리, 영화 줄거리, 영화 줄거리, 영화 줄거리, 영화 줄거리, 영화 줄거리, 영화 줄거리, 영화 줄거리, 영화 줄거리, 영화 줄거리, 영화 줄거리, 영화 줄거리, 영화 줄거리, 영화 줄거리, 영화 줄거리, 영화 줄거리, 영화 줄거리, 영화 줄거리, 영화 줄거리, 영화 줄거리, 영화 줄거리, 영화 줄거리, 영화 줄거리, 영화 줄거리, 영화 줄거리, 영화 줄거리, 영화 줄거리, 영화 줄거리, 영화 줄거리, 영화 줄거리, 영화 줄거리, 영화 줄거리, 영화 줄거리, 영화 줄거리, 영화 줄거리, 영화 줄거리, 영화 줄거리, 영화 줄거리, 영화 줄거리, 영화 줄거리"
        overviewLabel.numberOfLines = 0
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
