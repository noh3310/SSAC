//
//  SceneDelegate.swift
//  SeSac_Week12
//
//  Created by 노건호 on 2021/12/13.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        print(#function)
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        // 윈도우씬을 받아옴
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        // 여기서 하나씩 설정을 해보면 된다.
        // 윈도우씬에서 윈도우를 할당
        self.window = UIWindow(windowScene: windowScene)
        
        
        // 1. Storyboard: 컨트롤러 및 관련된 뷰를 정의할 때는 뷰컨트롤러 클래스를 직접 초기화 할 수 없기 때문에 instantiateViewController(withIdentifier: )를 통해 프로그래밍 방식으로 인스턴스화 합니다.
//        let sb = UIStoryboard(name: "Main", bundle: nil)
//        let vc = sb.instantiateViewController(withIdentifier: "vc") as! SnapDetailViewController
        
        // 2. xib 파일로 뷰컨트롤러를 대응할 때 생성할 수 있는 방법
//        let bundle = Bundle(for: SettingViewController.self) // Swift Meta Type
//        let vc = SettingViewController(nibName: "SettingViewController", bundle: bundle)
        
        // 3. 코드로 다루는 방법
//        let vc = SnapDetailViewController()

        let vc = MelonSnapViewController()
        let nav = UINavigationController(rootViewController: vc)
        // 루트뷰 컨트롤러 설정
//        window?.rootViewController = TabBarController()
        window?.rootViewController = vc
        // iOS 13에서 생긴 메서드
        window?.makeKeyAndVisible()
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        print(#function)
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        print(#function)
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        print(#function)
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        print(#function)
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
        
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
        // 알림센터에 해당하는 부분을 제거할 수 있다.
        UNUserNotificationCenter.current().removeAllDeliveredNotifications()
        // 특정 Identifier로 실행되었던 부분들을 처리해줄 수 있다.
//        UNUserNotificationCenter.current().removeDeliveredNotifications(withIdentifiers: <#T##[String]#>)
        UIApplication.shared.applicationIconBadgeNumber = 0
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        print(#function)
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }


}

