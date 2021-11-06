//
//  SettingViewController.swift
//  SeSac_WEEK6
//
//  Created by 노건호 on 2021/11/01.
//

import UIKit
import Zip
import MobileCoreServices   // 프레임워크의 프로퍼티를 가져올 수 있다.

/*
 백업하기 고려사항
 - 사용자의 아이폰 저장 공간 확인
    - 부족: 백업 불가
 - 가능하다면 이후 백업 진행
    - 어떤 데이터도 없는 경우라면 백업할 데이터가 없다고 안내
    - realm데이터가 있는지 확인, 이미지 폴더에 대한 것이 존재하는지 확인
    - (선택)역량이 된다면 백업할 떄 처리되는 기능을 추가해주는것이 좋다.
    - 백그라운드 기능, 통제권을 다 구현해주면 좋지만, 역량이 안된다면 Progress를 띄워주고, 사용자가 다른 UI적인 행위를 금지할 수 있게 구현을 했다.
 - 백업은 보통 .zip파일로 생성하게 된다.
    - 백업 완료 시점(zip을 만들었을 때)에
    - Progress + UI 인터렉션 허용
 - 공유화면을 띄워줄 수 있을것이다.
 */

/*
 복구하기
 - 사용자의 아이폰 저장공간 확인
 - 파일 앱
    - zip파일이 아닌경우 선택할 수 없도록 함
    - zip파일 선택
 - zip -> unzip을 먼저 수행
    - 백업 파일이 올바른것인지 수행(사용자가 파일을 선택하기 이전에는 어떤 파일을 선택했는지 알 수 없다.)
    - 압축해제
    - 진짜 백업 파일이 맞는지 확인: 폴더, 파일이름
        - 하지만 파일이름이 같다고해도 진짜 백업파일이 아닐수도 있다.
 - 백업 당시 데이터랑 지금 현재 앱에서 사용중인 데이터 어떻게 합칠건지에 대한 고려
    - 덮어쓰기 or 새 데이터 추가
 - 백업 데이터 선택
 - 백업 파일 확인
 - 정상적인 파일인가
 */

class SettingViewController: UIViewController {
    
    static let identifier = "SettingViewController"
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    @IBAction func presentActivityViewControllerButtonClicked(_ sender: UIButton) {
        presentActionViewController()
    }
    
    // 1. 백업할 도큐먼트 폴더 위치
    func documentDirectoryPath() -> String? {
        let documentDirectory = FileManager.SearchPathDirectory.documentDirectory
        let userDomainMask = FileManager.SearchPathDomainMask.userDomainMask
        let path = NSSearchPathForDirectoriesInDomains(documentDirectory, userDomainMask, true)
        if let directoryPath = path.first {
            return directoryPath
        } else {
            return nil
        }
    }
    
    // 7. 공유 액티비티 뷰 컨트롤러 생성
    func presentActionViewController() {
        // 압축파일 경로를 가져오기
        let fileName = (documentDirectoryPath()! as NSString).appendingPathComponent("archive.zip")
        let fileURL = URL(fileURLWithPath: fileName)
        
        let vc = UIActivityViewController(activityItems: [fileURL], applicationActivities: [])
        
        self.present(vc, animated: true, completion: nil)
    }
    
    // 백업버튼 클릭했을 때
    @IBAction func backupButtonClicked(_ sender: UIButton) {
        
        // 4. 백업 파일에 대한 URL 배열
        var urlPaths = [URL]()
        
        // 1. 도큐먼트 폴더위치 확인(desktop/jack/ios/document/default.realm)
        if let path = documentDirectoryPath() {
            // 2. 백업하고자 하는 파일 URL(경로) 확인
            // 이미지 같은 경우 백업 편의성을 위해 폴더를 생성하고, 폴더 안에 이미지를 저장하는것이 효율적이다.
            let realm = (path as NSString).appendingPathComponent("default.realm")
            // 2-2. 백업하고자 하는 파일 존재 여부 확인
            if FileManager.default.fileExists(atPath: realm) {
                // 5. URL배열에 백업 파일 URL 추가
                urlPaths.append(URL(string: realm)!) // URL이 무조건 존재한다는것을 확인했기 때문에 강제해제 해도됨
            } else {
                print("백업할 파일이 없습니다.")
            }
        }
        // 3. 4번 배열에 대해 압축파일 만들기
        do {
            let zipFilePath = try Zip.quickZipFiles(urlPaths, fileName: "archive") // Zip
            print("압축 경로: \(zipFilePath)")
            // 압축이 끝난 후에 바로 화면을 띄워준다
            presentActionViewController()
        }
        catch {
          print("Something went wrong")
        }
    }
    
    //
    @IBAction func restoreButtonClicked(_ sender: UIButton) {
        
        // 복구 1. 파일앱 열기 + 확장자
        // import MobileCoreServices
let documentPicker = UIDocumentPickerViewController(documentTypes: [kUTTypeZipArchive as String], in: .import)
        
        // 기존에는 프로토콜로 구현을 했었는데, 그래서 이것을 extension으로 만들어보겠다.
        documentPicker.delegate = self
        // 복구할 떄는 필요없지만, 여러개의 파일을 선택할 수도 있다.
        documentPicker.allowsMultipleSelection = false
        
        self.present(documentPicker, animated: true, completion: nil)
    }
    
}

// 델리게이트 패턴으로 extension을 해주겠다.
extension SettingViewController: UIDocumentPickerDelegate {
    func documentPickerWasCancelled(_ controller: UIDocumentPickerViewController) {
        print(#function)
    }
    
    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
        print(#function)
        
        // 복구 2. 선택한 파일에 대한 경로를 가져와야함
        // ex) iphone/jack/fileapp/archive.zip
        guard let selectedFileURL = urls.first else { return }
        
        let directory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        // selectedFileURL.lastPathComponent은 iphone/jack/fileapp/archive.zip 중 가장 마지막에 있는 "archive.zip"을 리턴함
        let sandboxFileURL = directory.appendingPathComponent(selectedFileURL.lastPathComponent)
        
        // 복구 3. 압축 해제
        if FileManager.default.fileExists(atPath: sandboxFileURL.path) {
            // 기존에 복구하고자 하는 zip파일을 도큐먼트에 가지고 있을 경우, 도큐먼트에 위치한 zip을 압축해제하면 됨
            do {
                // 앱의 도큐먼트의 위치
                let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
                // 파일 이름을 추가
                let fileURL = documentDirectory.appendingPathComponent("archive.zip")
                
                // fileURL 파일이름
                // destination 목적지까지의 URL
                // overwrite 덮어쓸 것인지
                try Zip.unzipFile(fileURL, destination: documentDirectory, overwrite: true, password: nil, progress: { progress in
                    print("\(progress)")
                }, fileOutputHandler: { unzippedFile in // 복구가 완료되었습니다 메시지 또는 얼럿
                    print("unzipFile: \(unzippedFile)")
                })
            } catch {
                print("ERROR")
            }
        }
        // 기조에 복구하고자 하는 zip파일을 도큐먼트에 가지고있지 않는 경우
        else {
            // 파일앱의 zip -> 도큐먼트 폴더에 복사
            do {
                // 우선 복사 먼저 수행
                try FileManager.default.copyItem(at: selectedFileURL, to: sandboxFileURL)
                
                // 앱의 도큐먼트의 위치
                let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
                // 파일 이름을 추가
                let fileURL = documentDirectory.appendingPathComponent("archive.zip")
                
                // fileURL 파일이름
                // destination 목적지까지의 URL
                // overwrite 덮어쓸 것인지
                try Zip.unzipFile(fileURL, destination: documentDirectory, overwrite: true, password: nil, progress: { progress in
                    print("progress: \(progress)")
                }, fileOutputHandler: { unzippedFile in // 복구가 완료되었습니다 메시지 또는 얼럿
                    print("unzipFile: \(unzippedFile)")
                })
            } catch {
                print("ERROR")
            }
        }
    }
}
