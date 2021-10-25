//
//  MainCollectionViewController.swift
//  SeSAC_04_Week
//
//  Created by 노건호 on 2021/10/19.
//

import UIKit

// 테이블뷰에서 컬렉션뷰의 차이
// tableview -> CollectionView
// row -> Item
class MainCollectionViewController: UIViewController {
    
    // 1. CollectionView 아웃렛 연결
    @IBOutlet weak var mainCollectionView: UICollectionView!
    @IBOutlet weak var tagCollectionView: UICollectionView!
    
    var mainArray = Array(repeating: false, count: 100)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainCollectionView.tag = 100
        tagCollectionView.tag = 200
        
        // 3. Delegate
        mainCollectionView.delegate = self
        mainCollectionView.dataSource = self
        
        tagCollectionView.delegate = self
        tagCollectionView.dataSource = self
        
        // 4. xib
        var nibName = UINib(nibName: MainCollectionViewCell.identifier, bundle: nil)
        mainCollectionView.register(nibName, forCellWithReuseIdentifier: MainCollectionViewCell.identifier)
        nibName = UINib(nibName: TagCollectionViewCell.identifier, bundle: nil)
        tagCollectionView.register(nibName, forCellWithReuseIdentifier: TagCollectionViewCell.identifier)
        
        let layout = UICollectionViewFlowLayout()
        let spacing: CGFloat = 20
        let width = UIScreen.main.bounds.width - (spacing * 4)
        layout.itemSize = CGSize(width: width / 3, height: (width / 3) * 1.2)
        // 레이아웃이 상하좌우 여백
        layout.sectionInset = UIEdgeInsets(top: spacing, left: spacing, bottom: 0, right: spacing)
        layout.minimumInteritemSpacing = spacing
        layout.minimumLineSpacing = spacing
        layout.scrollDirection = .vertical
        
        let tagLayout = UICollectionViewFlowLayout()
        let tagSpacing: CGFloat = 8
        tagLayout.scrollDirection = .horizontal
        tagLayout.itemSize = CGSize(width: 100, height: 40)
        tagLayout.minimumInteritemSpacing = tagSpacing
        tagLayout.sectionInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        tagCollectionView.collectionViewLayout = tagLayout
        
        
        mainCollectionView.collectionViewLayout = layout
        mainCollectionView.backgroundColor = .gray
    }
    
    @objc func heartButtonClicked(_ selectButton: UIButton) {
        print("\(selectButton.tag) 버튼 클릭")
        
        mainArray[selectButton.tag] = !mainArray[selectButton.tag]
        mainCollectionView.reloadItems(at: [IndexPath.init(item: selectButton.tag, section: 0)])
    }

}

// 2. CollectionView Protocol
extension MainCollectionViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView.tag == 200 {
            return 10
        } else {
            return mainArray.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == tagCollectionView {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TagCollectionViewCell.identifier, for: indexPath) as? TagCollectionViewCell else { return UICollectionViewCell() }
            
            cell.taglabel.text = "aa"
            cell.layer.borderColor = UIColor.black.cgColor
            cell.layer.borderWidth = 1
            cell.layer.cornerRadius = 5
            
            return cell
        }
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MainCollectionViewCell.identifier, for: indexPath) as? MainCollectionViewCell else { return UICollectionViewCell() }
        
        let item = mainArray[indexPath.item]
        
        if #available(iOS 13.0, *) {
            let image = (item == true) ? UIImage(systemName: "heart.fill") : UIImage(systemName: "heart")
            cell.heartButton.setImage(image, for: .normal)
        } else {
            // Fallback on earlier versions
        }
        
        
        cell.mainImageView.backgroundColor = .blue
        cell.heartButton.tag = indexPath.item
        cell.heartButton.addTarget(heartButtonClicked, action: #selector(heartButtonClicked), for: .touchUpInside)
        
        return cell
    }
}
