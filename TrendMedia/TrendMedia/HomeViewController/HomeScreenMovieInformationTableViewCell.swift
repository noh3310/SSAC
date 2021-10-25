//
//  HomeScreenMovieInformationTableViewCell.swift
//  TrendMedia
//
//  Created by 노건호 on 2021/10/22.
//

import UIKit

class HomeScreenMovieInformationTableViewCell: UITableViewCell {
    
    // static으로 identifier 선언
    static let identifier = "HomeScreenMovieInformationTableViewCell"
    
    // 출시일자, 장르
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var genreLabel: UILabel!
    
    // UILabel에 있는 것들
    @IBOutlet weak var movieInformationUiView: UIView!
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var rateTextLabel: UILabel!
    @IBOutlet weak var rateLabel: UILabel!
    @IBOutlet weak var linkButton: UIButton!
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var actorListLabel: UILabel!
    
    @IBOutlet weak var detailLabel: UILabel!
    @IBOutlet weak var detailButtonStyleLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
