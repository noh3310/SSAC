//
//  SearchViewController.swift
//  TrendMedia
//
//  Created by 노건호 on 2021/10/18.
//

import UIKit

class SearchViewController: UIViewController {
    
    @IBOutlet weak var myTableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    let tvShowList = Sample.tvShow
    
    var searchText: String = "" {
        didSet {
            myTableView.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 테이블뷰 설정
        setTableView()
        
        // 서치바 설정
        setSearchBar()
    }
    
    func setTableView() {
        myTableView.delegate = self
        myTableView.dataSource = self
    }
    
    func setSearchBar() {
        searchBar.delegate = self
    }
}

// search view extension
extension SearchViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print("searchText \(searchText)")
        self.searchText = searchText
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        print("searchText \(String(describing: searchBar.text))")
    }
}

// 테이블뷰 extension
extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tvShowList.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = myTableView.dequeueReusableCell(withIdentifier: "MovieInformationTableViewCell", for: indexPath) as! MovieInformationTableViewCell
        
        let url = URL(string: tvShowList[indexPath.row].backdropImage)
        do {
            let image = try Data(contentsOf: url!)
            cell.posterImageView.image = UIImage(data: image)
        }
        catch {
            
        }
        
        // custom cell 설정
        cell.titleLabel.text = tvShowList[indexPath.row].title
        cell.releaseDate.text = tvShowList[indexPath.row].releaseDate
        cell.Overview.text = tvShowList[indexPath.row].overview

        
        if let text = cell.titleLabel.text {
            if searchText == "" || text.contains(searchText) {
                cell.isHidden = false
            }
            else {
                cell.isHidden = true
            }
        }
        
        return cell
    }
}
