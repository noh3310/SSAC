//
//  SearchViewController.swift
//  SeSac_WEEK6
//
//  Created by 노건호 on 2021/11/01.
//

import UIKit
import RealmSwift

class SearchViewController: UIViewController {
    
    static let identifier = "SearchViewController"
    
    @IBOutlet weak var navigationBar: UINavigationBar!
    
    @IBOutlet weak var tableView: UITableView!
    
    let localRealm = try! Realm()
    
    var tasks: Results<UserDiary>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setNavigationBar()
        
//        print(tasks[0]._id)
//        print(tasks[0].diaryTitle)
//        print(tasks[0].content)
//        print(tasks[0].writeDate)
//        print(tasks[0].regDate)
        
        tableView.delegate = self
        tableView.dataSource = self

        let nibName = UINib(nibName: InformationTableViewCell.identifier, bundle: nil)
        tableView.register(nibName, forCellReuseIdentifier: InformationTableViewCell.identifier)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Get all tasks in the realm
        tasks = localRealm.objects(UserDiary.self)
    }
    
    func setNavigationBar() {
        navigationBar.tintColor = .white
    }
    
    // 도큐먼트 폴더 경로 -> 이미지 찾기 -> UIImage -> UIImageView
    func loadImageFromDocumentDirectory(imageName: String) -> UIImage? {
        let documentDirectory = FileManager.SearchPathDirectory.documentDirectory
        let userDomainMask = FileManager.SearchPathDomainMask.userDomainMask
        let path = NSSearchPathForDirectoriesInDomains(documentDirectory, userDomainMask, true)
        
        if let directoryPath = path.first {
            // String을 파일 경로(URL)로 바꿔주는 부분
            let imageURL = URL(fileURLWithPath: directoryPath).appendingPathComponent(imageName)
            
            // UIImage 형태로 리턴
            return UIImage(contentsOfFile: imageURL.path)
        }
        
        // 리턴타입이 옵셔널 타입이기 때문에 nil을 리턴할 수 있음
        return nil
    }
    
    func deleteImageFromDocumentDirectory(imageName: String) {
        // 1. 이미지 저장할 경로 설정: 도큐먼트 폴더, FileManager.default로 싱글톤 패턴으로 접근가능
        // Desktop/jack/ios/folder가 작성이 되고, 이것은 iOS의 Sandbox 시스템 때문에 고정적으로 사용할 수 없고, 계속 변한다.
        guard let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return }
        // 2. 이미지 파일 이름 & 최종 경로 설정
        // Desktop/jack/ios/folder/222.png
        let imageURL = documentDirectory.appendingPathComponent(imageName)
        
        // 3. 이미지 삭제: 동일한 경로에 이미지를 저장하게 될 경우, 덮어쓰기
        // 4-1. 이미지 경로 여부 확인
        if FileManager.default.fileExists(atPath: imageURL.path) {
            // 4-2. 기존 경로에 있는 이미지 삭제(삭제안하고 넣으면 덮어쓰기 되지 않지만 공부용으로 알아보기
            do {
                try FileManager.default.removeItem(at: imageURL)
                print("이미지 삭제 완료")
            } catch {
                print("이미지를 삭제하지 못했습니다.")
            }
        }
    }
}

extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 160
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: InformationTableViewCell.identifier, for: indexPath) as? InformationTableViewCell else {
            return UITableViewCell()
        }
//        print(tasks[0]._id)
//        print(tasks[0].diaryTitle)
//        print(tasks[0].content)
//        print(tasks[0].writeDate)
//        print(tasks[0].regDate)
        
        let row = tasks[indexPath.row]
        cell.titleLabel.text = row.diaryTitle
        cell.dateLabel.text = "\(row.writeDate)"
        cell.contentsLabel.text = row.content
        cell.contentsLabel.numberOfLines = 0
        cell.imageLabel.backgroundColor = .gray
        cell.imageLabel.image = loadImageFromDocumentDirectory(imageName: "\(row._id).jpg")
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        try! localRealm.write {
            // 이미지를 먼저 삭제하고, 그뒤에 테이블뷰를 지워야 한다. 만약 반대로하면 에러가 발생할 수 있다.
            deleteImageFromDocumentDirectory(imageName: "\(tasks[indexPath.row]._id).jpg")
            
            localRealm.delete( tasks[indexPath.row] )
            
            tableView.reloadData()
        }
    }
    
    // 원래는 화면 전 + 값 전달 후 새로운 화면에서 수정이 적합하다.
    // 시간이 없어서 이렇게 함
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // 1. 수정 - 레코드에 대한 값 수정
//        let taskToUpdate = tasks[indexPath.row]
//
//        try! localRealm.write {
//            taskToUpdate.diaryTitle = "수정된 제목"
//            taskToUpdate.content = "수정된 컨텐츠"
//        }
//        tableView.reloadData()
        
        // 2. 일괄 수정
//        try! localRealm.write {
//            tasks.setValue(Date(), forKey: "writeDate")
//            tasks.setValue("새롭게 일기 쓰기", forKey: "diaryTitle")
//            tableView.reloadData()
//        }
        
        // 3. 수정: pk 기준으로 수정할 때 사용 (권장 x)
//        let taskToUpdate = tasks[indexPath.row]
//
//        try! localRealm.write {
//            let update = UserDiary(value: ["_id" : taskToUpdate._id, "diaryTitle": "얘만 바꾸고 싶어"])
//            localRealm.add(update, update: .modified)
//            tableView.reloadData()
//        }
        
        // 4. 수정
        let taskToUpdate = tasks[indexPath.row]
        
        try! localRealm.write {
            localRealm.create(UserDiary.self, value: ["_id" : taskToUpdate._id, "diaryTitle": "123"], update: .modified)
            tableView.reloadData()
        }
    }
}
