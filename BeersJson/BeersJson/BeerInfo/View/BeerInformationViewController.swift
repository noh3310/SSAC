//
//  BeerInformationViewController.swift
//  BeersJson
//
//  Created by 노건호 on 2021/12/20.
//

import UIKit

class BeerInformationViewController: UIViewController {
    
    static let identifier = "BeerInformationViewController"
    
    var beerInformation: Beer?
    
    let mainView = BeerView()
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchInformation()
        
        view.backgroundColor = .white
        
        let navigationBar = self.navigationController?.navigationBar
        navigationBar?.backgroundColor = .clear
    }
    
    
    func fetchInformation() {
        if let beer = beerInformation {
            // 이미지 주소 받아옴
            let url = URL(string: beer.imageURL)
            DispatchQueue.global().async {
                let data = try? Data(contentsOf: url!)
                DispatchQueue.main.async {  // UI변경은 메인스레드에서 함
                    self.mainView.beerBackgroundImageView.image = UIImage(data: data!)
                }
            }

            mainView.beerInfoView.beerTitleLabel.text = beer.name
            mainView.beerInfoView.taglineLabel.text = beer.tagline
            mainView.beerInfoView.descriptionLabel.text = beer.beerDescription

            var paringText = ""
            beer.foodPairing.forEach { string in
                paringText += string
                paringText += "\n"
            }
            mainView.paringLabel.text = paringText
        }
    }
    
}
