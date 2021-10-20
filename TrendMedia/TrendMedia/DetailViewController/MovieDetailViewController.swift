//
//  MovieDetailViewController.swift
//  TrendMedia
//
//  Created by 노건호 on 2021/10/17.
//

import UIKit

class MovieDetailViewController: UIViewController {
    
    @IBOutlet weak var myTableView: UITableView!
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var posterImageView: UIImageView!
    
    var tvShowList = Sample.tvShow
    var actorList: [String] = []
    var posterImage: UIImage?
    var titleLabelString: String?
    
    var summaryHeight = 100
    var overviewExpanse = true

    override func viewDidLoad() {
        super.viewDidLoad()
        
//        actorList = tvShowList[0].starring.components(separatedBy: ", ")
        
        // 커스텀 셀을 등록
        let nibName = UINib(nibName: SummaryTableViewCell.identifier, bundle: nil)
        myTableView.register(nibName, forCellReuseIdentifier: SummaryTableViewCell.identifier)
        
        // 테이블 크기를 오토디멘전으로 설정하겠다.
//        myTableView.rowHeight =
        myTableView.rowHeight = UITableView.automaticDimension
        
        
        // 타이틀 설정
        setTitleLabel()
        
        // 포스터이미지 설정
        setPosterImageView()

        // 네비게이션바 설정
        setNavigationBar()
        
        // 테이블뷰 설정
        setTableView()
    }
    
    // 타이틀 설정
    func setTitleLabel() {
        titleLabel.text = titleLabelString
        titleLabel.textColor = .white
    }
    
    // 포스터이미지 설정
    func setPosterImageView() {
        // 타이틀뷰 이미지 설정
        posterImageView.image = posterImage
        posterImageView.contentMode = .scaleAspectFill
        
        // 백그라운드 이미지 설정
        backgroundImageView.image = posterImage
        backgroundImageView.contentMode = .scaleAspectFill
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
    
    @objc func didTabOverviewButton() {
        // 레이블 lines 1 -> 0 -> 1 반복
        overviewExpanse = !overviewExpanse
        // row를 하나만 가져옴, with는 살펴보길
        myTableView.reloadRows(at: [IndexPath(item: 0, section: 0)], with: .fade)
    }
}

extension MovieDetailViewController: UITableViewDelegate, UITableViewDataSource {
    // 섹션을 2개로 만들어줌
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    // 섹션이 0이면 줄거리, 아니면 영화배우를 보여줄 것이기 때문에 각가 다르게 리턴
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 0 ? 1 : actorList.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "UserInformationTableViewCell", for: indexPath)
//        return cell.bounds.height
        if indexPath.section == 0 {
            return UITableView.automaticDimension
        }
        
        return 60
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            print("1")
//             let cell = tableView.dequeueReusableCell(withIdentifier: SummaryTableViewCell.identifier, for: indexPath) as! SummaryTableViewCell
            
            let cell = tableView.dequeueReusableCell(withIdentifier: SummaryTableViewCell.identifier) as! SummaryTableViewCell
            print("2")
            cell.summaryTextLabel.numberOfLines = 0
            print("3")
            cell.summaryTextLabel.text = tvShowList[indexPath.row].starring
            print("4")
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // 줄거리 출력
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: SummaryTableViewCell.identifier, for: indexPath) as! SummaryTableViewCell
            
            cell.summaryTextLabel.text = tvShowList[indexPath.row].starring
            
            cell.summaryTextLabel.numberOfLines = overviewExpanse ? 0 : 2
//            var image = UIImage(systemName: "chevron.down")!
            if #available(iOS 13.0, *) {
                let image = (overviewExpanse ? UIImage(systemName: "chevron.down")! : UIImage(systemName: "chevron.up"))!
                cell.sizeButton.setImage(image, for: .normal)
            } else {
                // Fallback on earlier versions
            }
            
            cell.sizeButton.addTarget(self, action: #selector(didTabOverviewButton), for: .touchUpInside)
            
            return cell
        }
        // 영화배우 출력
        else {
            let cell = tableView.dequeueReusableCell(withIdentifier: UserInformationTableViewCell.identifier, for: indexPath) as! UserInformationTableViewCell
            
            cell.nameLabel.text = actorList[indexPath.row]
            cell.roleLabel.text = actorList[indexPath.row]
            
            return cell
        }
    }
}
