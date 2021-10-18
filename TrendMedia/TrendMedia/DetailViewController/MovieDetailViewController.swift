//
//  MovieDetailViewController.swift
//  TrendMedia
//
//  Created by 노건호 on 2021/10/17.
//

import UIKit

class MovieDetailViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var myTableView: UITableView!
    
    var tvShowList = Sample.tvShow
    var actorList: [String] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        actorList = tvShowList[0].starring.components(separatedBy: ", ")
        

        // 네비게이션바 설정
        setNavigationBar()
        
        // 테이블뷰 설정
        setTableView()
    }
    
    // 네비게이션바 설정
    func setNavigationBar() {
        // 뒤로 버튼 타이틀 변경
        self.navigationController?.navigationBar.topItem?.title = "뒤로"
    }
    
    // 테이블뷰 설정
    func setTableView() {
        myTableView.delegate = self
        myTableView.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return actorList.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "UserInformationTableViewCell", for: indexPath)
//        return cell.bounds.height
        return 60
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UserInformationTableViewCell", for: indexPath) as! UserInformationTableViewCell
        
        cell.nameLabel.text = actorList[indexPath.row]
        cell.roleLabel.text = actorList[indexPath.row]
//        cell.actorImage.image = tvShowList[0].
        
//        let dataArray = data.components(separatedBy: "; ")
        
        return cell
    }
    
    
}
