//
//  TabBarController.swift
//  SeSac_Week12
//
//  Created by 노건호 on 2021/12/15.
//

import UIKit

// navigationController, TabBarController 크게 다르지 않다.
// 탭바만 해보고, 네비게이션은 여러분이 해보세요
// tabBar, TabBarItem(title, image, selectImage), tintColor이 있다.
// iOS 13: UITabBarApperance라는 개념이 생겼다.(버전에 따른 분기처리 필요)
// UITabBarApperance는 배경 컬러를 사용하는거라서 충분히 대응이 되는지를 확인해야한다.

class TabBarController: UITabBarController, UITabBarControllerDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let firstVc = SettingViewController(nibName: "SettingViewController", bundle: nil)
        firstVc.tabBarItem.title = "설정"
        firstVc.tabBarItem.image = UIImage(systemName: "star")
        firstVc.tabBarItem.selectedImage = UIImage(systemName: "star.fill")
        let secondVc = SnapDetailViewController()
        secondVc.tabBarItem = UITabBarItem(title: "스냅킷", image: UIImage(systemName: "trash"), selectedImage: UIImage(systemName: "trash.fill"))
        let thirdVc = DetailViewController()
//        thirdVc.tabBarItem.title = "설정"
//        thirdVc.tabBarItem.image = UIImage(systemName: "pencil")
        thirdVc.tabBarItem.selectedImage = UIImage(systemName: "person.fill")
        thirdVc.tabBarItem.image = UIImage(systemName: "person")
        thirdVc.tabBarItem.title = "디테일뷰"
        let thirdNav = UINavigationController(rootViewController: thirdVc)
        
        // 인스턴스에 뷰컨트롤러를 배열로 담아주면 알아서 해줌
        setViewControllers([firstVc, secondVc, thirdNav], animated: true)
        
        let apperance = UITabBarAppearance()
        // 탭바 아무것도 안보이게 하는것
        apperance.configureWithOpaqueBackground()
        apperance.backgroundColor = .systemGray6
        
        tabBar.standardAppearance = apperance
        tabBar.scrollEdgeAppearance = apperance
        tabBar.tintColor = .black
    }
    
}
