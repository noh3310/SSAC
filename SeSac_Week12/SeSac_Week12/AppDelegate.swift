//
//  AppDelegate.swift
//  SeSac_Week12
//
//  Created by 노건호 on 2021/12/13.
//

import UIKit
import Firebase
import FirebaseMessaging

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        print(#function)
        // Override point for customization after application launch.
        
        // 공유 인스턴스로 초기화
        FirebaseApp.configure()
        
        // 권한에 대한 부분
        if #available(iOS 10.0, *) {
          // For iOS 10 display notification (sent via APNS)
          UNUserNotificationCenter.current().delegate = self

          let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
          UNUserNotificationCenter.current().requestAuthorization(
            options: authOptions,
            completionHandler: { _, _ in }
          )
        } else {
          let settings: UIUserNotificationSettings =
            UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
          application.registerUserNotificationSettings(settings)
        }

        // 이 앱이
        application.registerForRemoteNotifications()
        
        // 메시지 대리자 설정
        // APNS, 클라이언트의 역할을 위임하는것
        Messaging.messaging().delegate = self
        
        Messaging.messaging().token { token, error in
          if let error = error {
              print("Error fetching FCM registration token: \(error)")
          } else if let token = token {
              print("FCM registration token: \(token)")
//            self.fcmRegTokenMessage.text  = "Remote FCM registration token: \(token)"
              print(token)
          }
        }
        
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        print(#function)
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        print(#function)
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

extension AppDelegate: UNUserNotificationCenterDelegate {
    
    func application(application: UIApplication,
                     didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        // 기기의 토큰과 파이어베이스에서 오는 토큰을 일치시켜준다고 보면 된다.
        Messaging.messaging().apnsToken = deviceToken
    }
    
    // 포그라인드 수신: willPresent
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        // iOS 14 이상: banner, list
        if #available(iOS 14.0, *) {
            completionHandler([.list, .banner, .badge, .sound])
        } else {
            completionHandler([.alert, .badge, .sound])
        }
        
        // 포그라운드에서 내가 따로 푸시알림을 안받고싶을수도 있다.
        // 카톡에서 원하는사람들만 알림을 받을 수 있다.
        guard let rootViewController = (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.window?.rootViewController else { return }
        print(rootViewController)
        
        if rootViewController is DetailViewController {
            completionHandler([])
        } else {
            completionHandler([.list, .badge, .sound, .banner])
        }
        
    }
    
    // 사용자가 로컬/푸시를 클릭했을 떄 Response 호출 메서드
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse) async {
        print("사용자가 푸시를 클릭했습니다.")
        
        // userInfo: key - 1(광고), 2(채팅방), 3(사용자 설정)
        // 각 데이터마다 화면을 다르게 설정, 알람을 클릭했을 떄 그 알람으로 가야한다.
        print(response.notification.request.content.userInfo)
        print(response.notification.request.content.body)
        
        let userInfo = response.notification.request.content.userInfo
        if userInfo[AnyHashable("key")] as? Int == 1 {
            print("광고 푸시입니다.")
        } else {
            print("다른 푸시입니다.")
        }
        
        // SceneDelegate의 Window 객체 가져오기
        // 여러가지 씬이 있다면 어떤것에 연결되어있는지 알 수 있는 부분
        // .first를 하면 UIScene을 가져올 수 있다.
        // 최상단뷰가 있어야한다. 상황에따라 화면전환이 달라질 수 있다. 그래서 보통 익스텐션으로 만들어준다.
        guard let rootViewController = (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.window?.rootViewController else { return }
        print(rootViewController)
        
        
        if rootViewController is SnapDetailViewController {
            print("실행")
            rootViewController.present(DetailViewController(), animated: true, completion: nil)
        }
        
        if rootViewController is DetailViewController {
//            let nav = UINavigationController(rootViewController: SnapDetailViewController())
//            nav.modalPresentationStyle = .fullScreen
//            rootViewController.navigationController?.present(nav, animated: true, completion: nil)
            rootViewController.navigationController?.pushViewController(SnapDetailViewController(), animated: true)
            rootViewController.dismiss(animated: true, completion: nil)
        }
        
    }
    
}

extension AppDelegate: MessagingDelegate {
    
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
      print("Firebase registration token: \(String(describing: fcmToken))")

      let dataDict: [String: String] = ["token": fcmToken ?? ""]
      NotificationCenter.default.post(
        name: Notification.Name("FCMToken"),
        object: nil,
        userInfo: dataDict
      )
      // TODO: If necessary send token to application server.
      // Note: This callback is fired at each app startup and whenever a new token is generated.
    }

}

// 최상단 뷰컨트롤러를 판단해주는 UIViewController Extension
extension UIViewController {
    
    // 최상단 뷰컨트롤러를 받아오는 변수
    var topViewController: UIViewController? {
        return self.topViewController(currentViewController: self)
    }
    
    // 현재 들어오는 UIViewController가 있는 경우, 탭바 컨트롤러에서 최상단 뷰가 어떤것인지 불러온다.
    // 어디를 보던지 최상단뷰는 탭바라서 UIVIewController가 어떤것인지 확인할 수 있다
    // 보통 매개변수는 3가지가 있다. 탭바컨트롤러 or 네비게이션 뷰컨트롤러 or 뷰컨트롤러
    func topViewController(currentViewController: UIViewController) -> UIViewController {
        if let tabbarController = currentViewController as? UITabBarController, let selectedViewController = tabbarController.selectedViewController {
            return self.topViewController(currentViewController: selectedViewController)
        } else if let navigationController = currentViewController as? UINavigationController, let visibleViewController = navigationController.visibleViewController {
            return self.topViewController(currentViewController: visibleViewController)
        } else if let presentedViewController = currentViewController.presentedViewController {
            return self.topViewController(currentViewController: presentedViewController)
        } else {
            return currentViewController
        }
    }
    
}
