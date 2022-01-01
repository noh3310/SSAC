//
//  BeerView.swift
//  BeersJson
//
//  Created by 노건호 on 2021/12/29.
//

import UIKit

class BeerView: UIView {
    
    let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        
        scrollView.backgroundColor = .clear
        
        return scrollView
    }()
    
    // 스크롤뷰 컨텐츠뷰
    let contentView: UIView = {
        let view = UIView()
        
        view.backgroundColor = .clear
        
        return view
    }()
    
    let beerBackgroundImageView: UIImageView = {
        let image = UIImageView()
        
        image.backgroundColor = .systemMint
        image.contentMode = .scaleAspectFit
        
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

        label.textAlignment = .center
        label.font = .boldSystemFont(ofSize: 20)
        label.numberOfLines = 0
        
        return label
    }()
    
    let shareView: ShareView = {
        let share = ShareView()
        
        return share
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        // 공유 뷰(최하단 설정)
        self.addSubview(shareView)
        shareView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
//            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
            $0.bottom.equalToSuperview()
            $0.height.equalTo(70)
        }
        
        self.addSubview(scrollView)
        scrollView.addSubview(beerBackgroundImageView)
        scrollView.addSubview(contentView)
        
        // 스크롤뷰 설정
        scrollView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(shareView.snp.top)
        }
        
        // 전체크기, 중앙정렬
        contentView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.edges.equalToSuperview()
        }
        
        // top은 view와 같게, 하단은 contentView + 100과 같게 설정
        // 좌우는 동일하게 설정
        beerBackgroundImageView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(contentView.snp.top).offset(200)
//            $0.height.equalTo(100)
        }
        
        contentView.addSubview(paringView)
        contentView.addSubview(beerInfoView)
        // 맥주 타이틀 정보
        // 슈퍼뷰보다 조금더 위로 보이게 설정
        // 좌우로 inset 20씩
        beerInfoView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(160)
            $0.leading.trailing.equalToSuperview().inset(20)
        }
        
        paringView.addSubview(paringLabel)
        // top은 equal과 같음
        paringLabel.snp.makeConstraints {
            $0.top.equalTo(beerInfoView.snp.bottom).offset(20)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.centerX.equalToSuperview()
        }

        paringView.snp.makeConstraints {
            $0.top.equalTo(contentView.snp.top).offset(200)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(paringLabel.snp.bottom).offset(20)
            $0.bottom.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
