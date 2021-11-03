//
//  MovieDetailViewController.swift
//  TrendMedia
//
//  Created by 노건호 on 2021/10/17.
//

import UIKit
import Kingfisher

class MovieDetailViewController: UIViewController {
    
    @IBOutlet weak var myTableView: UITableView!
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var posterImageView: UIImageView!
    
    var tvShowList = Sample.tvShow
    var actorList: [String] = []
    var posterImage: UIImage?
    var titleLabelString: String?
    // 영화 객체 선언
    var movieInformation: Movie?
    
    // 영화배우 정보 리스트
    var actorInformations = [Actor]() {
        didSet {
            myTableView.reloadData()
        }
    }
    
    var summaryHeight = 100
    var overviewExpanse = false

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
        
        // 영화정보 받아오기
        getStarringInformation()
    }
    
    // 타이틀 설정
    func setTitleLabel() {
        if let movieInformation = movieInformation {
            titleLabel.text = movieInformation.title
            titleLabel.textColor = .white
        }
    }
    
    // 포스터이미지 설정
    func setPosterImageView() {
        
        // 타이틀뷰 이미지 설정
        if let movieInformation = movieInformation {
            let url = URL(string: "https://image.tmdb.org/t/p/w500/\(movieInformation.imageLink)")
            posterImageView.kf.setImage(with: url)
            posterImageView.contentMode = .scaleAspectFill
        } else {
            posterImageView.backgroundColor = .gray
        }
        
        // 백그라운드 이미지 설정
        if let movieInformation = movieInformation {
            let url = URL(string: "https://image.tmdb.org/t/p/w500/\(movieInformation.backDropLink)")
            backgroundImageView.kf.setImage(with: url)
            backgroundImageView.contentMode = .scaleAspectFill
        } else {
            backgroundImageView.backgroundColor = .gray
        }
        
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
    
    // 출연배우, 장르 저장
    func getStarringInformation() {
        guard let movieInformation = movieInformation else { return }

        MoviePopularListAPI.shared.getStarringInformations(id: String(movieInformation.id)) { status, json in
            switch status {
            // 올바르게 정보가 왔을 때
            case 200:
                var actorList: [Actor] = []
                
                json["credits"]["cast"].arrayValue.forEach { actorInformation in
                    let id = actorInformation["id"].intValue
                    let originalName = actorInformation["original_name"].stringValue
                    let characterName = actorInformation["character"].stringValue
                    let imageLink = actorInformation["profile_path"].stringValue
                    let popularity = actorInformation["popularity"].doubleValue
                    
                    // 유명도 10 이상의 배우들 추가(30으로하니까 몇명 안나옴...)
                    if popularity > 10.0 {
                        let actor = Actor(id: id, originalName: originalName, characterName: characterName, imageLink: imageLink)
                        actorList.append(actor)
                    }
                }
                // 영화의 등장인물 정보에 추가
                self.actorInformations = actorList
                
            // 유저가 정보를 잘못 보냈을 때
            case 401, 404:
                print("오류발생")
            default:
                print("default")
            }
        }
    }
}

extension MovieDetailViewController: UITableViewDelegate, UITableViewDataSource {
    // 섹션을 2개로 만들어줌
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    // 섹션이 0이면 줄거리, 아니면 영화배우를 보여줄 것이기 때문에 각가 다르게 리턴
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 0 ? 1 : actorInformations.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "UserInformationTableViewCell", for: indexPath)
//        return cell.bounds.height
        if indexPath.section == 0 {
            return UITableView.automaticDimension
        }
        
        return 60
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // 줄거리 출력
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: SummaryTableViewCell.identifier, for: indexPath) as! SummaryTableViewCell
            
            if let movie = movieInformation {
                cell.summaryTextLabel.text = movie.overview
            } else {
                cell.summaryTextLabel.text = "줄거리 없음"
            }
            
            cell.summaryTextLabel.numberOfLines = overviewExpanse ? 0 : 1
//            var image = UIImage(systemName: "chevron.down")!
            if #available(iOS 13.0, *) {
                let image = overviewExpanse ? UIImage(systemName: "chevron.up")! : UIImage(systemName: "chevron.down")!
                cell.sizeButton.setTitle("", for: .normal)
                cell.sizeButton.tintColor = .black
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
            
            let row = actorInformations[indexPath.row]
            cell.characterNameLabel.text = row.characterName
            cell.originalNameLabel.text = row.originalName
            let url = URL(string: "https://image.tmdb.org/t/p/w500\(row.imageLink)")
            cell.castImageView.kf.setImage(with: url)
            cell.contentMode = .scaleAspectFill
            
            return cell
        }
    }
}
