//
//  BoxOfficeTableViewController.swift
//  SeSAC_03Week
//
//  Created by 노건호 on 2021/10/13.
//

import UIKit

class BoxOfficeTableViewController: UITableViewController {
    
    // 1. 값을 전달 받을 공간
    var titleSpace: String?
    
    let movieInformation = MovieInformation()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //2. 표현
        self.title = titleSpace ?? "내용이 없을 때 타이틀"
        
        
        // style은 .plain을 주로 사용한다고 함
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "닫기", style: .plain, target: self, action: #selector(closeButtonClicked))
    }
    
    @objc func closeButtonClicked() {
        // Push - pop
        // Push를 했으면 Pop이 짝궁이다.
        // Present의 짝은 dismiss이다.
        // 그래서 push하고 dismiss하면 화면전환이 안된다.
        self.navigationController?.popViewController(animated: true)
    }
    
    // Row의 개수
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movieInformation.movie.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // 애플의 시스템 셀은 애플이 다 만들어놓은 것이기 때문에 각각의 셀마다 정보를 전달해주어야 한다라고 구분을 해줬다.
        // 타입캐스팅이라는 개념을 써줄 것이다.
        // UITableViewCell에는 써줄 수가 없다. 다시한번 봐야할듯
        guard let cell = tableView.dequeueReusableCell(withIdentifier: BoxOfficeTableViewCell.Identifier, for: indexPath) as? BoxOfficeTableViewCell else {
            return UITableViewCell()
        }
        
        
        
        // 아래처럼 써도 되는데 위에서 쓰는것 처럼 써주는것이 좋음
//        let cell = tableView.dequeueReusableCell(withIdentifier: "BoxOfficeTableViewCell", for: indexPath) as! BoxOfficeTableViewCell
        
        let row = movieInformation.movie[indexPath.row]
        cell.posterImageView.backgroundColor = .red
        cell.titleLabel.text = row.title
        cell.releaseDateLabel.text = row.releaseDate
        cell.overviewLabel.text = row.overview
        cell.posterImageView.image = UIImage(named: row.title)!
        
        cell.overviewLabel.numberOfLines = 0

        return cell
    }
    
    // 셀의 크기
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 250
        // 기기마다 항상 5개정도 볼 수 있는 크기로 리턴된다.
        return UIScreen.main.bounds.height / 5
    }
    
    // 셀 클릭했을 때
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Movie", bundle: nil)
        
        guard let vc = storyboard.instantiateViewController(withIdentifier: "BoxOfficeDetailViewController") as? BoxOfficeDetailViewController else {
            print("오류발생")
            return
        }
        
        let row = movieInformation.movie[indexPath.row]
        
        vc.movie = row
        
        vc.releaseDate = row.releaseDate
        vc.overview = row.overview
        vc.rate = row.rate
        vc.runtime = row.runtime
        vc.movieTitle = row.title
        
//        let vc = storyboard.instantiateViewController(withIdentifier: "BoxOfficeDetailViewController") as! BoxOfficeDetailViewController
        
        self.navigationController?.pushViewController(vc, animated: true)
    }

}
