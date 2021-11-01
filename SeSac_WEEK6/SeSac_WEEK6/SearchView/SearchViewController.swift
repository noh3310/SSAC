//
//  SearchViewController.swift
//  SeSac_WEEK6
//
//  Created by 노건호 on 2021/11/01.
//

import UIKit

class SearchViewController: UIViewController {
    
    static let identifier = "SearchViewController"
    
    @IBOutlet weak var navigationBar: UINavigationBar!
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setNavigationBar()
        
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
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: InformationTableViewCell.identifier, for: indexPath) as? InformationTableViewCell else {
            return UITableViewCell()
        }
        
        cell.titleLabel.text = "제목제목제목제목제목제목제목제목제목제목제목제목제목제목제목제목제목제목제목제목제목제목제목제목제목제목제목제목제목제목제목제목제목"
        cell.dateLabel.text = "2021-11-01"
        cell.contentsLabel.text = "내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용"
        cell.imageLabel.backgroundColor = .blue
        
        return cell
    }
    
    
}
