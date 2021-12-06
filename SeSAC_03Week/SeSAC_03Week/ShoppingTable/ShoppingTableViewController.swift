//
//  ShoppingTableViewController.swift
//  SeSAC_03Week
//
//  Created by 노건호 on 2021/10/13.
//

import UIKit
import RealmSwift
import Zip
import MobileCoreServices

class ShoppingTableViewController: UITableViewController {
    
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var searchStackView: UIStackView!
    @IBOutlet weak var restoreButton: UIButton!
    @IBOutlet weak var backUpButton: UIButton!
    
    // 로컬DB 변수 생성
    let localRealm = try! Realm()
    
    var shoppingList: Results<ShoppingItem>! {
        didSet {
            // 데이터베이스를 업데이트 하는 과정이 조금 오래 걸리는 것 같다.
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // UserDefaults에 있는 정보 불러옴
        loadData()
        
        // 텍스트필드 설정
        setSearchTextField()
        
        // 추가 버튼 설정
        setButton(addButton, title: "추가", tintColor: .black, backgroundColor: UIColor(red: 229/255, green: 229/255, blue: 234/255, alpha: 1), cornerRadius: 5)
        
        // 스택뷰 마진 설정
        setSearchStackView()
        
        // 백업, 복구버튼 설정
        setButton(backUpButton, title: "백업", tintColor: .black, backgroundColor: UIColor(red: 229/255, green: 229/255, blue: 234/255, alpha: 1), cornerRadius: 5)
        setButton(restoreButton, title: "복구", tintColor: .black, backgroundColor: UIColor(red: 229/255, green: 229/255, blue: 234/255, alpha: 1), cornerRadius: 5)
        
        // 디비에 있는 값을 받아옴
        // favorite 기준 DESC, 체크박스 기준 ASC(true가 ASC, false가 DESC)
        shoppingList = localRealm.objects(ShoppingItem.self).sorted(byKeyPath: "favorite", ascending: false).sorted(byKeyPath: "checkBox", ascending: true)
        
        print("Realm is Located at: ", localRealm.configuration.fileURL!)
    }
    
    // 텍스트필드 설정
    func setSearchTextField() {
        textField.backgroundColor = .clear
        textField.borderStyle = .none
        textField.placeholder = "무엇을 구매하실 건가요?"
    }
    
    // 검색 스택뷰 설정
    func setSearchStackView() {
        searchStackView.layoutMargins = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        searchStackView.isLayoutMarginsRelativeArrangement = true
        searchStackView.backgroundColor = UIColor(red: 242/255, green: 242/255, blue: 247/255, alpha: 1)
        searchStackView.layer.cornerRadius = 5
    }
    
    // 버튼 설정
    func setButton(_ button: UIButton, title: String, tintColor: UIColor, backgroundColor: UIColor, cornerRadius: CGFloat) {
        button.setTitle(title, for: .normal)
        button.tintColor = tintColor
        button.backgroundColor = backgroundColor
        button.layer.cornerRadius = cornerRadius
    }
    
    // 추가 버튼 클릭했을 때
    @IBAction func addButtonClicked(_ sender: UIButton) {
//        if let text = textField.text {
//            let newItem = ShoppingList(isPurchased: isTrue.False, shoppingItem: text, isFavorite: isTrue.False)
//
//            shoppingList.append(newItem)
//        }
        
        if let text = textField.text {
            let shoppingItem = ShoppingItem.init(item: text)
            
            // Open a thread-safe transaction.
            try! localRealm.write {
                // Add the instance to the realm.
                localRealm.add(shoppingItem)
            }
            // 리로드데이터 해줌(왜 ShoppingList 옵저빙 프로퍼티에서는 말을 안듣는지 모르겠음)
            tableView.reloadData()
        }
    }
    
    // 백업버튼 클릭했을 때
    @IBAction func backUpButtonClicked(_ sender: UIButton) {
        // 백업폴더 위치 받아오기
        var urlPaths = [URL]()
        
        // 함수의 리턴값이 옵셔널 타입이므로 옵셔널 바인딩으로 도큐먼트 디렉터리가 올바른 값인지 확인
        if let path = documentDirectoryPath() {
            // string을 NSString으로 브리징했다(Swift에서 String <-> NSString 무료 브리징이 가능하다고 한다)
            // 우리가 백업하고자 하는 파일은 default.realm이므로 도큐먼트 디렉토리 파일까지 오고난 후 마지막에 default.realm을 추가해준다.
            // "/User/......./Document/default.realm" 과 같은 경로가 될 것이다.
            let realm = (path as NSString).appendingPathComponent("default.realm")
            
            // 우리가 만들어놓은 경로에 그 파일이 있는지 검사해본다.
            if FileManager.default.fileExists(atPath: realm) {
                // URL 배열에 추가한다.
                // URL(string: realm)은 옵셔널 타입이므로 우선은 맞다고 가정하고 강제로 해제한다.
                urlPaths.append(URL(string: realm)!)
            } else {
                // 파일이 없다고 알려줌
                print("파일이 없습니다.")
            }
            
            do {
                // archive.zip 파일 생성
                // shoppingList로 변경
                let zipFilePath = try Zip.quickZipFiles(urlPaths, fileName: "shoppingList") // Zip
                print("압축파일 경로: \(zipFilePath)")
                
                // 액션 뷰 컨트롤러 불러옴
                presentActionViewController()
            }
            catch {
              print("Something went wrong")
            }

            
        }
    }
    
    func presentActionViewController() {
        // 압축파일 경로를 가져오기
        // "/User/....../Document"까지 받아옴
        let fileName = (documentDirectoryPath()! as NSString).appendingPathComponent("shoppingList.zip")
        // URL로 변경
        let fileURL = URL(fileURLWithPath: fileName)
        
        // activityItems: 사용하고자 하는 파일들
        // applicationActivities: 앱이 지원하는 사용자 정의 서비스를 나타내는 배열(특정 앱에서 실행하지 않을것이라면 그냥 비워두면 된다)
        let actionViewController = UIActivityViewController(activityItems: [fileURL], applicationActivities: [])
        
        // 화면 띄워줌
        self.present(actionViewController, animated: true, completion: nil)
    }
    
    // 백업폴더 위치 받아오기
    func documentDirectoryPath() -> String? {
        // 현재 도큐먼트 디렉토리
        let documentDirectory = FileManager.SearchPathDirectory.documentDirectory
        // userDomainMask는 사용자의 홈 디렉토리, 사용자의 개인 항목들을 설치하는 위치
        // 네트워크 관련 정보들은 networkDomainMask를 사용한다.
        let userDomainMask = FileManager.SearchPathDomainMask.userDomainMask
        // 도큐먼트 디렉토리의 경로를 가져온다.
        // receiver의 경로가 "~/User/....."로 되어있는것처럼 홈디렉토리에서 시작하는 경로를 "/home/user......"처럼 전체경로로 변경하려면 마지막 expandTilde 매개변수에 전달인자로 true를 입력하면 변경된다.
        let path = NSSearchPathForDirectoriesInDomains(documentDirectory, userDomainMask, true)
        
        // 옵셔널 바인딩을 통해 경로에 파일이 있는지 확인
        if let directoryPath = path.first {
            return directoryPath
        } else {
            // 만약 경로가 없다면 nil을 리턴한다. 이때 함수의 반환값이 절대적으로 String일 수 없기 때문에 리턴타입은 String 옵셔널 타입으로 변경한다.
            return nil
        }
    }
    
    // 복구버튼 클릭했을 때
    @IBAction func restoreButtonClicked(_ sender: UIButton) {
        // UIDocumentPickerViewController - 앱의 document 또는 샌드박스 밖에있는 위치에 대한 액세스를 제공하는 뷰 컨트롤러
        // documentTypes - 내가 불러올 수 있는 파일 형식을 지정
        // in - UIDocumentPickerMode 형식 중 하나를 선택해야 한다 형식은 아래와 같다.
            // .import - 문서 선택기는 앱의 샌드박스 외부에서 파일을 가져옵니다.
            // .open - 문서 선택기는 앱의 샌드박스 외부에 외부 파일을 엽니다.
        // 현재 프로젝트에서는 앱의 샌드박스 외부에서 파일을 가여좌야 하므로 .import를 사용한다.
        // import MobileCoreServices 를 해주어야 한다.
        let documentPicker = UIDocumentPickerViewController(documentTypes: [kUTTypeZipArchive as String], in: .import)
        
        // 델리게이트를 뷰컨트롤러에 위임
        documentPicker.delegate = self
        
        // 한번에 여러개의 파일을 선택할 수 있는지 여부, 복구파일은 하나만 필요하기 떄문에 false로 설정
        documentPicker.allowsMultipleSelection = false
        
        // 파일선택 화면을 켜줌
        self.present(documentPicker, animated: true, completion: nil)
    }
    
    
    // 시작할 때 데이터 불러옴
    func loadData() {
//        let userDefaults = UserDefaults.standard
//
//        // 옵셔널 바인딩으로 값 있는지 확인
//        if let data = userDefaults.object(forKey: "shoppingList") as? [[String:Any]] {
//            // 이 list 변수에 userdefaults에 있는 정보를 다 가져옴
//            var list = [ShoppingList]()
//
//            for datum in data {
//                // userDefaults의 정보들을 다 가져옴
//                guard let isPurchased = datum["isPurchased"] as? isTrue else { return }
//                guard let shoppingItem = datum["shoppingItem"] as? String else { return }
//                guard let isFavorite = datum["isFavorite"] as? isTrue else { return }
//
//                // 가져온 정보들을 다 덮어줌
//                let appendData = ShoppingList(isPurchased: isPurchased, shoppingItem: shoppingItem, isFavorite: isFavorite)
//                list.append(appendData)
//            }
//            // 원래 배열에 추가시켜줌
//            self.shoppingList = list
//        }
    }
    
    // 정보들을 userDefaults에 다 저장해줌
    func saveData() {
//        // 이 배열을 UserDefaults에 저장해줌
//        var item = [[String:Any]]()
//
//        // for문을 돌면서 배열에 있는 정보를 UserDefaults에 들어갈 수 있는 정보로 변환
//        for shoppingItem in shoppingList {
//            let data: [String:Any] = [
//                "isPurchased": shoppingItem.isPurchased.rawValue,
//                "shoppingItem": shoppingItem.shoppingItem,
//                "isFavorite": shoppingItem.isFavorite.rawValue
//            ]
//
//            item.append(data)
//        }
//        let userDefaults = UserDefaults.standard
//        userDefaults.set(item, forKey: "shoppingList")
    }
    
    /// 1, 2, 3 은 거의 필수 요건이다.
    
    // 2. 셀의 디자인 및 데이터 처리: cellForRowAt
    // 재사용 메커니즘, 옵셔널 체이닝
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        print(#function)
        
        // 어떤 셀을 사용할지 결정해서 cell 변수에 할당
        // as? ShoppingListTableViewCell 안써주면 기본적으로 cell은 UITableViewCell로 인식이 되서 타입캐스팅을 수행해주지 않으면 안에있는 값들은 참조할 수 없음
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "checkCell") as? ShoppingListTableViewCell else {
            return UITableViewCell()
        }
        
        let row = shoppingList[indexPath.row]
        
        cell.itemLabel.text = row.item
        let chackBoxImage = row.checkBox ? "checkmark.square.fill" : "checkmark.square"
        cell.checkboxButton.setImage(UIImage(systemName: chackBoxImage), for: .normal)
        
        let favorighteImage = row.favorite ? "star.fill" : "star"
        cell.favoriteButton.setImage(UIImage(systemName: favorighteImage), for: .normal)
        
        cell._id = row._id
        cell.delegate = self
//        cell.itemLabel.text = row.shoppingItem
//        let chackBoxImage = row.isPurchased == isTrue.True ? "checkmark.square.fill" : "checkmark.square"
//        cell.checkboxButton.setImage(UIImage(systemName: chackBoxImage), for: .normal)
//        let favorighteImage = row.isFavorite == isTrue.True ? "star.fill" : "star"
//        cell.favoriteButton.setImage(UIImage(systemName: favorighteImage), for: .normal)
        
        return cell
    }
    
    // 3. (옵션)셀의 높이: heightForRowAt
    // indexPath를 주는 이유는 인덱스마다 높이가 다를 수 있기 때문(페이스북 처럼)
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return indexPath.section == 0 ? 40 : 80
//        return indexPath.section == 0 ? 50 : 40
        return 50
    }
    
    // 섹션의 개수 리턴(기본은 1 리턴)
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    // 섹션의 타이틀을 리턴함, 그런데 없어도 되기 때문에 리턴값이 옵셔널 타입임
    // titleForHeaderInSection
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return ""
    }
    
    // (옵션) 셀 편집 상태: editingStyle
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        
        // 삭제를 하면 어떻게 수행될지
        if editingStyle == .delete {
            // 업데이트하는 부분
            let row = shoppingList[indexPath.row]

            // Open a thread-safe transaction
//            try! localRealm.write {
//                // These changes are saved to the realm
//                row.favorite = true
//
//                tableView.reloadData()
//            }
            
            try! localRealm.write {
                print(row)
                localRealm.delete(row)
                
                tableView.reloadData()
            }
        }
    }
    
    // (옵션) 셀의 편집 상태를 나타냄(스와이프 할지 안할지): canEditRowAt
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    // (옵션) 셀을 클릭했을 때 기능: didSelectRowAt
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.section, ", ", indexPath.row)
    }
    
    /// 1, 2, 3 은 거의 필수 요건이다.
    // 1. 셀의 개수: numberOfRowsInSection
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return shoppingList.count
    }
}

protocol cellButtonClicked {
    func checkedButtonClicked(id: ObjectId)
    func favoriteButtonClicked(id: ObjectId)
}

extension ShoppingTableViewController: cellButtonClicked {
    func checkedButtonClicked(id: ObjectId) {
        let item = localRealm.object(ofType: ShoppingItem.self, forPrimaryKey: id)
        print("c")
        // Open a thread-safe transaction
        try! localRealm.write {
            print("a")
            // These changes are saved to the realm
            if let state = item?.checkBox {
                print("b")
                item?.checkBox = state ? false : true
            }
            tableView.reloadData()
        }
    }
    
    func favoriteButtonClicked(id: ObjectId) {
        let item = localRealm.object(ofType: ShoppingItem.self, forPrimaryKey: id)
        print("c")
        // Open a thread-safe transaction
        try! localRealm.write {
            print("a")
            // These changes are saved to the realm
            if let state = item?.favorite {
                print("b")
                item?.favorite = state ? false : true
            }
            tableView.reloadData()
        }
    }
}

extension ShoppingTableViewController: UIDocumentPickerDelegate {
    
    // 문서를 선택하면 실행되는 메서드
    // 쇼핑리스트를 복구할 것이다.
    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
        
        // 선택한 파일의 경로를 가져온다.
        guard let selectedFileURL = urls.first else { return }

        // 도메인 마스크에 있는 "...../Directory" 경로를 가져옴
        let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        // "/User/..../Directory/shoppingList.zip"을 가져옴
        // selectedFileURL.lastPathComponent가 "/User/....../shoppingList.zip" 중 마지막에 있는 "shoppingList.zip"을 리턴함
        let sandboxFileURL = documentDirectory.appendingPathComponent(selectedFileURL.lastPathComponent)

        // 복구 진행
        // 파일이 있는지 먼저 확인
        // 복구하고자 하는 파일이 document에 가지고 있는 경우
        if FileManager.default.fileExists(atPath: sandboxFileURL.path) {
            print("복구파일 document에 찾음")
        } else { // 복구하고자 하는 파일이 document에 없는 경우
            do {
                // 파일을 Document로 이동(잘못 생각함)
                try FileManager.default.copyItem(at: selectedFileURL, to: sandboxFileURL)
            } catch {
                print("오류발생")
            }
        }

        do {
            let fileURL = documentDirectory.appendingPathComponent("shoppingList.zip")

            // sandboxFilleURL - 파일 URL
            // destination - 목적지의 디렉토리
            // overwrite - 덮어쓸것인지
            try Zip.unzipFile(fileURL, destination: documentDirectory, overwrite: true, password: nil, progress: { progress in
                print("progress: \(progress)")
            }, fileOutputHandler: { unzippedFile in
                print("unzippedFile: \(unzippedFile)")
            }) // Unzip

//            // 새롭게 받아오기 이래야지 데이터베이스가 업데이트되기 때문에 바로 사용할 수 있는것 같음(맞네)
//            shoppingList = localRealm.objects(ShoppingItem.self).sorted(byKeyPath: "favorite", ascending: false).sorted(byKeyPath: "checkBox", ascending: true)

            // 테이블뷰 리로드
//            tableView.reloadData()
        }
        catch {
          print("Something went wrong")
        }
    }
}
