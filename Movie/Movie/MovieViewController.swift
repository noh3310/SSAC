//
//  MovieViewController.swift
//  Movie
//
//  Created by 노건호 on 2021/09/29.
//

import UIKit

class MovieViewController: UIViewController {
    
    static let posterList = [UIImage(named: "poster1"), UIImage(named: "poster2"), UIImage(named: "poster3"), UIImage(named: "poster4"), UIImage(named: "poster5"), UIImage(named: "poster6"), UIImage(named: "poster7"), UIImage(named: "poster8"), UIImage(named: "poster9"), UIImage(named: "poster10")]
    
    @IBOutlet var homeButton: UIButton!
    @IBOutlet var playButton: UIButton!
    
    @IBOutlet var mainPoster: UIImageView!
    @IBOutlet var preview1: UIImageView!
    @IBOutlet var preview2: UIImageView!
    @IBOutlet var preview3: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("     2: viewDidLoad")
        
        setRandomImageOf(mainPoster)
        setRandomImageOf(preview1)
        setRandomImageOf(preview2)
        setRandomImageOf(preview3)
        
        setPreviewCircleOf(preview1)
        setPreviewCircleOf(preview2)
        setPreviewCircleOf(preview3)

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print("     2: viewWillAppear")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        print("     2: viewDidAppear")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        print("     2: viewWillDisappear")
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        print("     2: viewDidDisappear")
    }
    
    func setPreviewCircleOf(_ preview: UIImageView) {
        preview.clipsToBounds = true
        preview.layer.cornerRadius = 65 // half of image frame size
        preview.layer.borderWidth = 3
        preview.layer.borderColor = UIColor.gray.cgColor // convert UIColor to CGColor
    }
    
    func setRandomImageOf(_ preview: UIImageView) {
        var randomNumber = Int.random(in: 0..<MovieViewController.posterList.count)
        
        while MovieViewController.posterList[randomNumber] == mainPoster.image ||
                MovieViewController.posterList[randomNumber] == preview1.image ||
                MovieViewController.posterList[randomNumber] == preview2.image ||
                MovieViewController.posterList[randomNumber] == preview3.image {
            randomNumber = Int.random(in: 0..<MovieViewController.posterList.count)
        }
        preview.image = MovieViewController.posterList[randomNumber]
    }
    
    @IBAction func changeRandomPreview(_ sender: UIButton) {
        setRandomImageOf(mainPoster)
        setRandomImageOf(preview1)
        setRandomImageOf(preview2)
        setRandomImageOf(preview3)
    }

    @IBAction func backButtonClicked(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
