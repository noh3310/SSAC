//
//  MainViewController.swift
//  SeSac_WEEK6
//
//  Created by 노건호 on 2021/11/01.
//

import UIKit

class MainViewController: UIViewController {
    
    static let identifier = "MainViewController"
    
    @IBOutlet weak var tableView: UITableView!
    
    let array = [
        Array(repeating: "a", count: 20),
        Array(repeating: "b", count: 20),
        Array(repeating: "c", count: 20),
        Array(repeating: "d", count: 20),
        Array(repeating: "e", count: 20)
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 모든 탭바 아이콘, 이름 설정
        setTabBar()
        
        // 내비게이션 타이틀 설정
        setNavigationBar()
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    // 모든 탭바 아이콘, 이름 설정
    func setTabBar() {
        // 이걸로 tabBarItem 전부다 설정해줌
        self.tabBarController?.viewControllers?[0].tabBarItem.title = "HOME"
        if #available(iOS 13.0, *) {
            self.tabBarController?.viewControllers?[0].tabBarItem.image = UIImage(systemName: "house")
        } else {
            // Fallback on earlier versions
        }
        self.tabBarController?.viewControllers?[1].tabBarItem.title = "검색"  // magnifyingglass
        if #available(iOS 13.0, *) {
            self.tabBarController?.viewControllers?[1].tabBarItem.image = UIImage(systemName: "magnifyingglass")
        } else {
            // Fallback on earlier versions
        }
        self.tabBarController?.viewControllers?[2].tabBarItem.title = "캘린더" // calendar
        if #available(iOS 13.0, *) {
            self.tabBarController?.viewControllers?[2].tabBarItem.image = UIImage(systemName: "calendar")
        } else {
            // Fallback on earlier versions
        }
        self.tabBarController?.viewControllers?[3].tabBarItem.title = "설정"  // person.crop.circle
        if #available(iOS 13.0, *) {
            self.tabBarController?.viewControllers?[3].tabBarItem.image = UIImage(systemName: "person.crop.circle")
        } else {
            // Fallback on earlier versions
        }
    }
    
    // 내비게이션 타이틀 설정
    func setNavigationBar() {
        self.navigationItem.title = "HOME"
        if #available(iOS 13.0, *) {
            self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .plain, target: self, action: #selector(addButtonClicked))
        } else {
            self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonClicked))
        }
    }
    
    // 더하기 버튼 누르면 화면전환
    @objc func addButtonClicked() {
        let storyboard = UIStoryboard(name: "DiaryStoryboard", bundle: nil)
        
        let vc = storyboard.instantiateViewController(withIdentifier: DiaryViewController.identifier)
        // 아래에서 위로 전체화면
        vc.modalPresentationStyle = .fullScreen
        
        self.present(vc, animated: true)
    }
}

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return array.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: HomeTableViewCell.identifier, for: indexPath) as? HomeTableViewCell else {
            return UITableViewCell()
        }
        
//        cell.collectionView.delegate = self
//        cell.collectionView.dataSource = self
        
        cell.backgroundColor = .blue
        cell.data = array[indexPath.row]
        cell.categoryLabel.text = "\(array[indexPath.row])"
        cell.collectionView.backgroundColor = .lightGray

        // 태그를 남김(하나의 섹션일 떄 유용한 방법)
        cell.collectionView.tag = indexPath.row
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return indexPath.row == 1 ? 300 : 170
    }
}

