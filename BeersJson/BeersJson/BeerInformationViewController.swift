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
        
        scrollView.backgroundColor = .clear
        
        return scrollView
    }()
    
    // 스크롤뷰 컨텐츠뷰
    let contentView = UIView()
    
    let beerBackgroundImageView: UIImageView = {
        let image = UIImageView()
        
        image.backgroundColor = .systemMint
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
        
        label.text = "Spicy chicken tikka masala\nGrilled chicken quesadilla\nCaramel toffee cake\nGrilled chicken quesadilla\nCaramel toffee cake\nGrilled chicken quesadilla\nCaramel toffee cake\nGrilled chicken quesadilla\nCaramel toffee cake\nGrilled chicken quesadilla\nCaramel toffee cake\nGrilled chicken quesadilla\nCaramel toffee cake\nGrilled chicken quesadilla\nCaramel toffee cake\nGrilled chicken quesadilla\nCaramel toffee cake\nGrilled chicken quesadilla\nCaramel toffee cake\nGrilled chicken quesadilla\nCaramel toffee cake\nGrilled chicken quesadilla\nCaramel toffee cake\nGrilled chicken quesadilla\nCaramel toffee cake\nGrilled chicken quesadilla\nCaramel toffee cake\nGrilled chicken quesadilla\nCaramel toffee cake\nGrilled chicken quesadilla\nCaramel toffee cake"
        label.font = .boldSystemFont(ofSize: 20)
        label.numberOfLines = 0
        
        return label
    }()
    
    let shareView: ShareView = {
        let share = ShareView()
        
        return share
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        let navigationBar = self.navigationController?.navigationBar
        navigationBar?.backgroundColor = .clear
        
        // 공유 뷰(최하단 설정)
        view.addSubview(shareView)
        shareView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
            $0.height.equalTo(70)
        }
        
        // 스크롤뷰 설정
        view.addSubview(scrollView)
        scrollView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(shareView.snp.top)
        }
        
        // 스크롤뷰에 이미지뷰 넣음(레이아웃잡기)
        scrollView.addSubview(beerBackgroundImageView)
        beerBackgroundImageView.snp.makeConstraints {
//            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(beerBackgroundImageView.snp.width).multipliedBy(0.7)
        }
        
        // 컨텐츠뷰는 이미지뷰 아래에 설정
        scrollView.addSubview(contentView)
        contentView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.edges.equalToSuperview()
            $0.top.equalTo(beerBackgroundImageView.snp.bottom)
        }
        
        contentView.addSubview(beerImageView)
        beerImageView.snp.makeConstraints {
//            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.top.leading.trailing.equalToSuperview()
            $0.height.equalTo(UIScreen.main.bounds.height / 5)
        }
        
        contentView.addSubview(paringView)
        
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
        
        paringView.snp.makeConstraints {
            $0.top.equalTo(beerImageView.snp.bottom)
            $0.leading.trailing.equalToSuperview()
//            $0.height.equalTo(500)
            $0.bottom.equalTo(paringLabel.snp.bottom).offset(20)
            $0.bottom.equalToSuperview()
        }
        
        

    }
    
}
