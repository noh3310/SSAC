//
//  ShoppingTableViewController.swift
//  SeSAC_03Week
//
//  Created by 노건호 on 2021/10/13.
//

import UIKit
import RealmSwift

class ShoppingTableViewController: UITableViewController {
    
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var searchStackView: UIStackView!
    
    // 로컬DB 변수 생성
    let localRealm = try! Realm()
    
    var shoppingList: Results<ShoppingItem>! {
        didSet {
            tableView.reloadData()
        }
    }
    
    //    var shoppingList: [String] = ["그립톡", "사이다", "아이패드", "양말"] {
//        didSet {
//            tableView.reloadData()
//        }
//    }
    
    // 쇼핑리스트를 담고있는 배열을 제공
//    var shoppingList = [ShoppingList]() {
//        didSet {
//            tableView.reloadData()
//
//            saveData()
//        }
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // UserDefaults에 있는 정보 불러옴
        loadData()
        
        // 텍스트필드 설정
        setSearchTextField()
        
        // 추가 버튼 설정
        setAddButton()
        
        // 스택뷰 마진 설정
        setSearchStackView()
        
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
    
    // 버튼 설정(텍스트, 색상, 테두리)
    func setAddButton() {
        addButton.setTitle("추가", for: .normal)
        addButton.tintColor = .black
        addButton.backgroundColor = UIColor(red: 229/255, green: 229/255, blue: 234/255, alpha: 1)
        addButton.layer.cornerRadius = 5
    }
    
    // 검색 스택뷰 설정
    func setSearchStackView() {
        searchStackView.layoutMargins = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        searchStackView.isLayoutMarginsRelativeArrangement = true
        searchStackView.backgroundColor = UIColor(red: 242/255, green: 242/255, blue: 247/255, alpha: 1)
        searchStackView.layer.cornerRadius = 5
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
