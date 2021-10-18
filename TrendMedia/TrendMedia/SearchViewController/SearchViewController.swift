//
//  SearchViewController.swift
//  TrendMedia
//
//  Created by 노건호 on 2021/10/18.
//

import UIKit

class SearchViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var myTableView: UITableView!
    
    let tvShowList = Sample.tvShow

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 테이블뷰 설정
        setTableView()
        
        
    }
    
    func setTableView() {
        myTableView.delegate = self
        myTableView.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tvShowList.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = myTableView.dequeueReusableCell(withIdentifier: "MovieInformationTableViewCell", for: indexPath) as! MovieInformationTableViewCell
        
        let url = URL(string: tvShowList[0].backdropImage)
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
        
        return cell
    }
    
    
}
