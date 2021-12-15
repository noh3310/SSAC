//
//  CarrotTabBarController.swift
//  SeSac_Week12
//
//  Created by 노건호 on 2021/12/15.
//

import UIKit

class CarrotTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let homeVc = CarrotHomeViewController()
        homeVc.tabBarItem = UITabBarItem(title: "홈", image: UIImage(systemName: "house"), selectedImage: UIImage(systemName: "house.fill"))
        let firstNav = UINavigationController(rootViewController: homeVc)
        let neighborVc = CarrotNeighborhoodLifeViewController()
        neighborVc.tabBarItem = UITabBarItem(title: "동네생활", image: UIImage(systemName: "newspaper"), selectedImage: UIImage(systemName: "newspaper.fill"))
        let neighborHoodVc = CarrotMyNeighborhoodViewController()
        neighborHoodVc.tabBarItem = UITabBarItem(title: "내 근처", image: UIImage(systemName: "mappin.circle"), selectedImage: UIImage(systemName: "mappin.circle.fill"))
        let chatVc = CarrotChatViewController()
        chatVc.tabBarItem = UITabBarItem(title: "채팅", image: UIImage(systemName: "message"), selectedImage: UIImage(systemName: "message.fill"))
        let myPageVc = CarrotMyPageViewController()
        myPageVc.tabBarItem = UITabBarItem(title: "내 당근", image: UIImage(systemName: "person"), selectedImage: UIImage(systemName: "person.fill"))
        
        // 탭바에 뷰컨트롤러 추가
        setViewControllers([firstNav, neighborVc, neighborHoodVc, chatVc, myPageVc], animated: true)
        
        let apperance = UITabBarAppearance()
        // 배경 완전히 불투명하게 설정
        apperance.configureWithOpaqueBackground()
        // 배경색 설정
        apperance.backgroundColor = .white
        
        tabBar.standardAppearance = apperance
        tabBar.scrollEdgeAppearance = apperance
        tabBar.tintColor = .black
    }
    
}
