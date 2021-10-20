//
//  MyMediaViewController.swift
//  TrendMedia
//
//  Created by 노건호 on 2021/10/20.
//

import UIKit

class MyMediaViewController: UIViewController {
    
    static let identifier = "MyMediaViewController"
    
    let tvShowList = Sample.tvShow
    
    @IBOutlet weak var movieCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 커스텀셀 등록
        setCustomCell()
        
        // 권한 위임
        setAuthority()
        
        // 콜렉션뷰 레이아웃 설정
        setupCollectionViewLayout()
    }
    
    // 커스텀셀 등록
    func setCustomCell() {
        let nibName = UINib(nibName: MyMediaCollectionViewCell.identifier, bundle: nil)
        movieCollectionView.register(nibName, forCellWithReuseIdentifier: MyMediaCollectionViewCell.identifier)
    }
    
    // 권한 위임
    func setAuthority() {
        movieCollectionView.delegate = self
        movieCollectionView.dataSource = self
    }
    
    func setupCollectionViewLayout() {
        let layout = UICollectionViewFlowLayout()
        let spacing: CGFloat = 5
        let width = UIScreen.main.bounds.width - (spacing * 4)
        // 아이템 크기
        layout.itemSize = CGSize(width: width / 2, height: width / 2)
        // 레이아웃이 상하좌우 여백
        layout.sectionInset = UIEdgeInsets(top: spacing, left: spacing, bottom: 0, right: spacing)
        layout.minimumInteritemSpacing = spacing
        layout.minimumLineSpacing = spacing
        layout.scrollDirection = .vertical

        movieCollectionView.collectionViewLayout = layout
    }

}

extension MyMediaViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tvShowList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = movieCollectionView.dequeueReusableCell(withReuseIdentifier: MyMediaCollectionViewCell.identifier, for: indexPath) as! MyMediaCollectionViewCell
        
        cell.backgroundColor = UIColor(red: .random(in: 0...1), green: .random(in: 0...1), blue: .random(in: 0...1), alpha: 1)
        
        cell.movieTitleLabel.text = tvShowList[indexPath.item].title
        cell.movieRateLabel.text = String(tvShowList[indexPath.item].rate)
        
        cell.moviePosterImageView.backgroundColor = .black
        
        cell.contentView.layer.cornerRadius = 10
        cell.layer.masksToBounds = true
        
        return cell
    }
    
    
}
    
