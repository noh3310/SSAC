//
//  MoviePreviewTableViewCell.swift
//  TrendMedia
//
//  Created by 노건호 on 2021/10/18.
//

import UIKit

class MoviePreviewTableViewCell: UITableViewCell {
    
    static let identifier = "MoviePreviewTableViewCell"

    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var genreLabel: UILabel!
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var rateLabel: UILabel!
    @IBOutlet weak var actorListLabel: UILabel!
    
    var delegate: CellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func linkButtonClicked(_ sender: UIButton) {
        self.delegate?.clickedButton()
//        let storyboard = UIStoryboard(name: "Main", bundle: nil)
//
//        let vc = storyboard.instantiateViewController(withIdentifier: "PopUpViewViewController") as! PopUpViewViewController
//
////        self.present(vc, animated: true, completion: nil)
    }
}
