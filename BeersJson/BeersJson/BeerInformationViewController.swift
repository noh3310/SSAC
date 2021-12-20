//
//  BeerInformationViewController.swift
//  BeersJson
//
//  Created by 노건호 on 2021/12/20.
//

import UIKit

class BeerInformationViewController: UIViewController {
    
    static let identifier = "BeerInformationViewController"
    
    let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        
        scrollView.backgroundColor = .systemPink
        
        return scrollView
    }()
    
    // 스크롤뷰 컨텐츠뷰
    let contentView = UIView()
    
    // imageView
    let beerImageView: UIImageView = {
        let image = UIImageView()
        
        // 원본비율이미지 그대로 유지
        image.contentMode = .scaleAspectFit
        let url = URL(string: "https://images.punkapi.com/v2/keg.png")
        do {
            let data = try Data(contentsOf: url!)
            image.image = UIImage(data: data)
        } catch {
            print("error")
        }
        
        return image
    }()
    
    let beerInfoView: BeerInfoView = {
        let view = BeerInfoView()
        
        view.backgroundColor = .white
        view.layer.cornerRadius = 10
        view.layer.shadowOffset = CGSize(width: 0, height: 0)
        view.layer.shadowRadius = 5
        view.layer.shadowOpacity = 0.5
        view.layer.shadowColor = UIColor.black.cgColor
        
        return view
    }()
    
    let paringView: UIView = {
        let view = UIView()
        
        view.backgroundColor = .white
        
        return view
    }()
    
    let foodPairingLabel: UILabel = {
        let label = UILabel()
        
        label.font = .systemFont(ofSize: 20)
        
        return label
    }()
    
    let paringLabel: UILabel = {
        let label = UILabel()
        
        label.text = "Spicy chicken tikka masala\nGrilled chicken quesadilla\nCaramel toffee cake"
        label.font = .boldSystemFont(ofSize: 20)
        label.numberOfLines = 0
        
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .gray
        
        let navigationBar = self.navigationController?.navigationBar
        navigationBar?.backgroundColor = .clear
//        navigationBar?.barTintColor = .clear
        
//        self.navigationController?.navigationBar.tintColor = .clear
        
//        view.addSubview(beerTitleLabel)
////        beerTitleLabel.snp.makeConstraints {
////
////        }
//
//        view.addSubview(taglineLabel)
//        view.addSubview(descriptionLabel)
//        view.addSubview(foodPairingLabel)
        
//        scrollView.addSubview(beerInfoView)
//        beerInfoView.snp.makeConstraints {
//            $0.top.equalToSuperview().inset(20)
//            $0.leading.equalToSuperview().inset(20)
//            $0.trailing.equalToSuperview().inset(20)
////            $0.height.equalTo(100)
//            $0.bottom.equalToSuperview()
////             $0.edges.equalToSuperview().inset(20)
//        }
        
        view.addSubview(scrollView)
        scrollView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        scrollView.addSubview(contentView)
        contentView.snp.makeConstraints {
//            $0.width.equalToSuperview()
            $0.centerX.top.bottom.equalToSuperview()
            $0.edges.equalToSuperview()
        }
        
        contentView.addSubview(beerImageView)
        beerImageView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.height.equalTo(UIScreen.main.bounds.height / 5)
        }
        
        contentView.addSubview(paringView)
        paringView.snp.makeConstraints {
            $0.top.equalTo(beerImageView.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(500)
            $0.bottom.equalToSuperview()
        }
        
//        paringView.snp.updateConstraints {
//            $0.height.equalTo(300)
//        }
        
        contentView.addSubview(beerInfoView)
        beerInfoView.snp.makeConstraints {
            $0.top.equalTo(beerImageView.snp.bottom).inset(40)
            $0.leading.trailing.equalToSuperview().inset(20)
//            $0.height.equalTo(300)
            // contnetView의 마지막부분을 정해줌
//            $0.bottom.equalToSuperview()
        }
        
        paringView.addSubview(paringLabel)
        paringLabel.snp.makeConstraints {
            $0.top.equalTo(beerInfoView.snp.bottom).offset(20)
            $0.centerX.equalToSuperview()
        }

    }
    
}
