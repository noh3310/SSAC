//
//  HomeTableViewCell.swift
//  SeSac_WEEK6
//
//  Created by 노건호 on 2021/11/08.
//

import UIKit

class HomeTableViewCell: UITableViewCell {
    
    static let identifier = "HomeTableViewCell"
    
    var data = [String]() {
        didSet {
            // 콜렉션뷰가 나갈 때 새롭게 갱신하도록 해주면 됨
            collectionView.reloadData()
            categoryLabel.text = "\(data.count) 개"
        }
    }
    
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        // 페이지가 정확하게 딱 나올 수 있도록 하고 싶을 때
        collectionView.isPagingEnabled = true
        
        categoryLabel.backgroundColor = .yellow
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}

// 컬렉션뷰 관련 익스텐션
extension HomeTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeCollectionViewCell.identifier, for: indexPath) as? HomeCollectionViewCell else {
            print("aa")
            return UICollectionViewCell()
        }

        cell.imageView.backgroundColor = .brown
        
        // arrya[collectionView.tag] -> ["a", "a", "a", "a", ......]
        cell.contentLabel.text = data[indexPath.item]
//        cell.contentLabel.text = array[indexPath.section][indexPath.item]

        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        // 테이블뷰 셀의 인덱스패스를 어떻게 가지고 와야 할까?
//        if collectionView.tag == 0 {
//            return CGSize(width: UIScreen.main.bounds.width, height: 100)
//        } else {
//            return CGSize(width: 150, height: 150)
//        }
        return CGSize(width: 20, height: 20)
    }

    // 여백을 얼마나 줄 것인지
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {

        if collectionView.tag == 0 {
            return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        } else {
            return UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 0)
        }
    }

    // 셀 간의 간격을 설정하고 싶을 떄 사용하는 메서드
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return collectionView.tag == 0 ? 0 : 10
    }
}
