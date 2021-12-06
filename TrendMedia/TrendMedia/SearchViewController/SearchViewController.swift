//
//  SearchViewController.swift
//  TrendMedia
//
//  Created by 노건호 on 2021/10/18.
//

import UIKit
import Alamofire
import SwiftyJSON
import Kingfisher
import AVFoundation
import RealmSwift

class SearchViewController: UIViewController {
    
    @IBOutlet weak var myTableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet weak var textField: UITextField!
    
    // Open the local-only default realm
    let localRealm = try! Realm()
    
    var movieList: Results<RankingMovie>!
    
    let tvShowList = Sample.tvShow
    
    var searchText: String = "" {
        didSet {
//            myTableView.reloadData()
//            fetchMovieData(query: self.searchText)
        }
    }
    
    var movieData: [MovieModel] = []
    
    // 랭킹 리스트
    var movieRankList: [MovieRankModel] = [] {
        didSet {
            myTableView.reloadData()
        }
    }
    
    // 검색 데이터
    var targetDate: String = "" {
        didSet {
            searchMovieList(date: self.targetDate)
        }
    }
    
    var totalCount = 0
    var startPage = 1

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Get all tasks in the realm
        movieList = localRealm.objects(RankingMovie.self)
        try! localRealm.write {
            localRealm.deleteAll()
        }
        
        // 테이블뷰 설정
        setTableView()
        
        // 서치바 설정
        setSearchBar()
        
        // 어제날짜로 설정
        setYesterday()
        
        searchBar.text = targetDate
        
        print("Realm is Located at: ", localRealm.configuration.fileURL!)
        
        // 커스텀 셀 사용가능하도록 테이블뷰에 등록
        let nibName = UINib(nibName: SearchResultTableViewCell.identifier, bundle: nil)
        myTableView.register(nibName, forCellReuseIdentifier: SearchResultTableViewCell.identifier)
    }
    
    func setTableView() {
        myTableView.delegate = self
        myTableView.dataSource = self
        myTableView.prefetchDataSource = self
        
        myTableView.keyboardDismissMode = .onDrag
    }
    
    // 서치바 설정
    func setSearchBar() {
        searchBar.delegate = self
    }
    
    func setYesterday() {
        // 어제날짜 설정
        let date = NSDate() as Date - 3600 * 24
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyyMMdd"
        
        let yesterday = formatter.string(from: date)
        
        targetDate = yesterday
        
        let calendar = Calendar.current
        let tomorrow = calendar.date(byAdding: .day, value: 1, to: Date())!
        print(tomorrow)
        let yesterday1 = calendar.date(byAdding: .day, value: -1, to: Date())!
        print(yesterday1)
        
        // 이번주 월요일은?
        var component = calendar.dateComponents([.weekOfYear, .yearForWeekOfYear, .weekday], from: Date())
        component.weekday = 2   // 2번이 월요일 (0번이 일요일부터 시작함)
        
        let mondayWeek = calendar.date(from: component)
        print(mondayWeek)
    }
}

// 서버통신을 할 때 이것을 쓰라고 권장하는 방식
// 용량이 큰 이미지를 쓸 때 다운받는데 시간이 드는데, 미리 다운받아놓는 방식
// cellForRowAt보다 먼저 실행이 된다.
// 스크롤을 너무 빠르게하면 중간의 셀들은 굳이 안해줘도 된다.
extension SearchViewController: UITableViewDataSourcePrefetching {
    // 셀이 화면에 보이기 전에 필요한 리소스를 미리 다운받는 기능
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        for indexPath in indexPaths {
            // 마지막까지 도달했다면, startPage를 늘려주고
            if self.movieData.count - 1 == indexPath.row && movieData.count < totalCount {
                startPage += 10
                
                print(indexPath)
            }
        }
    }
    
    // 취소(사용자가 너무빨리 스크롤을했을 때 취소해주는 것)
    func tableView(_ tableView: UITableView, cancelPrefetchingForRowsAt indexPaths: [IndexPath]) {
        print("취소:\(indexPaths)")
    }
}

// search bar extension
extension SearchViewController: UISearchBarDelegate {
    // 텍스트가 바뀌었을 때
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print("searchText \(searchText)", #function)
        self.searchText = searchText
    }

    // 검색버튼(키보드 리턴키)을 눌렀을 때
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        print("searchText \(String(describing: searchBar.text))")
        
        if let text = searchBar.text {
            searchMovieList(date: text)
        }
    }
    
    // 영화검색하는 부분만 따로 빼줌
    func searchMovieList(date: String) {
        
        // 배열의 값을 다 지워줌
        movieData.removeAll()
        
        // 페이지네이션 기능의 페이지를 초기화시켜줘야함
        startPage = 1
        
        print("\(date)")

        var searchResultArray = [MovieRankModel]()
        
        // 사용자가 입력한 영화를 받아오는데 등수 순서로 오름차순으로 받아옴
        movieList.filter("rankingDate == %@", date).sorted(byKeyPath: "order", ascending: true).forEach { movie in
            print("디비정보 가져오는중")
            let title = movie.title
            let rank = movie.order
            let rankDate = movie.rankingDate
            let releasedDate = movie.releasedDate

            let info = MovieRankModel(rank: rank, title: title, releasedDate: releasedDate, rankDate: rankDate)

            searchResultArray.append(info)
        }
        
        // 만약 영화정보가 디비에 있다면 굳이 검색안해도됨
        if searchResultArray.count >= 10 {
            print("디비에 있는 정보 가져옴")
            self.movieRankList = searchResultArray
            return
        }

        // 사용자가 검색하고자 하는 텍스트로 물어봄
        SearchAPI.shared.fetchMovieData(query: date) { Status, json in
            let movieList = json["boxOfficeResult"]["dailyBoxOfficeList"].arrayValue
            
            var movieInfo: [MovieRankModel] = []
            for movie in movieList {
                let rank = movie["rank"].intValue
                let title = movie["movieNm"].stringValue
                let releasedDate = movie["openDt"].stringValue
                let rankDate = date
                
                let info = MovieRankModel(rank: rank, title: title, releasedDate: releasedDate, rankDate: rankDate)
                
                // 디비에 추가해줌
                try! self.localRealm.write {
                    print("디비에 정보 넣는중")
                    let movieInfo = RankingMovie(rankingDate: rankDate, releasedDate: releasedDate, title: title, order: rank)
                    self.localRealm.add(movieInfo)
                }
                
                movieInfo.append(info)
            }
            
            // 옵저빙 프로퍼티로 해줄것임
            self.movieRankList = movieInfo
        }
    }
    
    // 취소버튼을 눌렀을 때 실행
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        print(#function)
        
        // 배열의 값을 다 지워줌
        movieData.removeAll()
        
        // 페이지네이션 기능의 페이지를 초기화시켜줘야함
        startPage = 1
        
        // 취소버튼 나타나게 해줌(애니메이션 방식)
        // 애니메이션으로 나타나게 하는 것이다
        searchBar.setShowsCancelButton(false, animated: true)
    }
    
    // 서치바에서 커서 시작할 때를 인식함
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        print(#function)
        
        // 취소버튼 나타나게 해줌
        searchBar.setShowsCancelButton(true, animated: true)
    }
}

// 테이블뷰 extension
extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(movieData.count)
        return movieRankList.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = myTableView.dequeueReusableCell(withIdentifier: SearchResultTableViewCell.identifier, for: indexPath) as! SearchResultTableViewCell
        
        let row = movieRankList[indexPath.row]
        cell.numberLabel.backgroundColor = .white
        cell.numberLabel.text = "\(row.rank)"
        cell.titleLabel.text = row.title
        cell.releasedDateLabel.text = "\(row.releasedDate)"
        
        return cell
        
//        let cell = myTableView.dequeueReusableCell(withIdentifier: "MovieInformationTableViewCell", for: indexPath) as! MovieInformationTableViewCell
//
//        print(indexPath.row)
//        let row = movieData[indexPath.row]
//        cell.titleLabel.text = row.titleData
//        cell.releaseDate.text = row.subTitle
//        cell.Overview.text = row.userRateData
//
//        print(row.imageData)
//        // 킹피셔로 이미지 가져옴
//        if let url = URL(string: row.imageData) {
//            cell.posterImageView.kf.setImage(with: url)
//        } else {
//            if #available(iOS 13.0, *) {
//                cell.posterImageView.image = UIImage(systemName: "star")
//            } else {
//                // Fallback on earlier versions
//            }
//        }
//
//        return cell
    }
}
