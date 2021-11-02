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
        
        // Get all tasks in the realm
        tasks = localRealm.objects(UserDiary.self)
        
        print(tasks[0]._id)
        print(tasks[0].diaryTitle)
        print(tasks[0].content)
        print(tasks[0].writeDate)
        print(tasks[0].regDate)
        
        tableView.delegate = self
        tableView.dataSource = self

        let nibName = UINib(nibName: InformationTableViewCell.identifier, bundle: nil)
        tableView.register(nibName, forCellReuseIdentifier: InformationTableViewCell.identifier)
    }
    
    func setNavigationBar() {
        navigationBar.tintColor = .white
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
        cell.imageLabel.backgroundColor = .blue
        
        return cell
    }
    
    
}
