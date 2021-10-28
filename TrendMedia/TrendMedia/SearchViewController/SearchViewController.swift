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

class SearchViewController: UIViewController {
    
    @IBOutlet weak var myTableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet weak var textField: UITextField!
    
    let tvShowList = Sample.tvShow
    
    var searchText: String = "" {
        didSet {
//            myTableView.reloadData()
//            fetchMovieData(query: self.searchText)
        }
    }
    
    var movieData: [MovieModel] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 테이블뷰 설정
        setTableView()
        
        // 서치바 설정
        setSearchBar()
    }
    
    var totalCount = 0
    var startPage = 1
    
    // 네이버 영화 네트워크 통신
    func fetchMovieData(query: String) {
        
        if let query = query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) {
            
            let url = "https://openapi.naver.com/v1/search/movie.json?query=" + query + "&display=" + "10" + "&start=" + "\(startPage)"
            
            
            let header: HTTPHeaders = [
                "X-Naver-Client-Id":"T10QP9xxucDYrZfF1bCY",
                "X-Naver-Client-Secret":"kcYyOUiGKO"
            ]
            
            AF.request(url, method: .get, headers: header).validate().responseJSON { response in
                switch response.result {
                case .success(let value):
                    let json = JSON(value)
                    print("JSON: \(json)")
                    
                    self.totalCount = json["total"].intValue
                    
                    for item in json["items"].arrayValue {
                        
                        let title = item["title"].stringValue
                        let substringTitle = title.replacingOccurrences(of: "<b>", with: "").replacingOccurrences(of: "</b>", with: "")
                        let image = item["image"].stringValue
                        let link = item["link"].stringValue
                        let userRating = item["userRating"].stringValue
                        let sub = item["subtitle"].stringValue
                        
                        self.movieData.append(MovieModel(titleData: substringTitle, imageData: image, linkData: link, userRateData: userRating, subTitle: sub))
                    }
                    
                    print(self.movieData)
                    
                    self.myTableView.reloadData()
                    
                case .failure(let error):
                    print(error)
                }
            }
        }
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
            // 배열의 값을 다 지워줌
            movieData.removeAll()
            
            // 페이지네이션 기능의 페이지를 초기화시켜줘야함
            startPage = 1
            
            fetchMovieData(query: text)
            
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
        return movieData.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = myTableView.dequeueReusableCell(withIdentifier: "MovieInformationTableViewCell", for: indexPath) as! MovieInformationTableViewCell
        
        print(indexPath.row)
        let row = movieData[indexPath.row]
        cell.titleLabel.text = row.titleData
        cell.releaseDate.text = row.subTitle
        cell.Overview.text = row.userRateData
        
        print(row.imageData)
        // 킹피셔로 이미지 가져옴
        if let url = URL(string: row.imageData) {
            cell.posterImageView.kf.setImage(with: url)
        } else {
            if #available(iOS 13.0, *) {
                cell.posterImageView.image = UIImage(systemName: "star")
            } else {
                // Fallback on earlier versions
            }
        }
        
        
        
        return cell
    }
}
