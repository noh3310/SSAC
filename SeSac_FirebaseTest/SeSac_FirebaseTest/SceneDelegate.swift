//
//  SceneDelegate.swift
//  SeSac_FirebaseTest
//
//  Created by 노건호 on 2021/12/06.
//

import UIKit
import Firebase
import AppTrackingTransparency

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        guard let _ = (scene as? UIWindowScene) else { return }
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
        
        // 화면이 불러진 이후 1초 뒤에서 실행할 수 있도록 한다.
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            // ATT Framework(14 이상)
            ATTrackingManager.requestTrackingAuthorization { status in
                switch status {
                    // 아직 허용되지 않은 상태
                case .notDetermined:
                    print("notDetermined")
                    Analytics.setAnalyticsCollectionEnabled(false)
                case .restricted:  // 금지를 누른 상태
                    print("restricted")
                    Analytics.setAnalyticsCollectionEnabled(false)
                case .denied:  //.
                    print("denied")
                    Analytics.setAnalyticsCollectionEnabled(false)
                case .authorized:
                    print("authorized")  // 허용했을때만 수집을 할 수 있다.
                    Analytics.setAnalyticsCollectionEnabled(true)
                @unknown default:
                    print("unknown")
                    Analytics.setAnalyticsCollectionEnabled(false)
                }
            }
        }
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }


}

