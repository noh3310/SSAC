//
//  AppDelegate.swift
//  SeSac_FirebaseTest
//
//  Created by 노건호 on 2021/12/06.
//

import UIKit
import Firebase
import AppTrackingTransparency  // 앱 추적 투명성 프레임워크 추가

@main
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        // 파이어베이스 앱을 초기화, 공유 인스턴스 생성
        FirebaseApp.configure()
        
        // Crashlytics 개인정보는 받아오면 안된다고 하는데 테스트를 해볼 수 있다.
        Crashlytics.crashlytics().setCustomValue(1000, forKey: "movieCount")
        Crashlytics.crashlytics().setCustomValue("hello", forKey: "nickname")
        
        let keysAndValues = [
                         "string key" : "string value",
                         "string key 2" : "string value 2",
                         "boolean key" : true,
                         "boolean key 2" : false,
                         "float key" : 1.01,
                         "float key 2" : 2.02
                        ] as [String : Any]

        Crashlytics.crashlytics().setCustomKeysAndValues(keysAndValues)
        
        Crashlytics.crashlytics().setUserID("123456789")
        
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

