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
    
    @IBOutlet weak var rateTextLabel: UILabel!
    var delegate: CellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setPosterImageView()
        
        rateTextLabel.backgroundColor = .orange
        rateTextLabel.layer.borderColor = UIColor.black.cgColor
        rateTextLabel.layer.borderWidth = 1
        
        rateLabel.backgroundColor = .white
        rateLabel.layer.borderColor = UIColor.black.cgColor
        rateLabel.layer.borderWidth = 1
        // Initialization code
    }
    
    func setPosterImageView() {
        posterImageView.contentMode = .scaleAspectFill
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
