//
//  BoxOfficeTableViewController.swift
//  SeSAC_03Week
//
//  Created by 노건호 on 2021/10/13.
//

import UIKit

class BoxOfficeTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // Row의 개수
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // 애플의 시스템 셀은 애플이 다 만들어놓은 것이기 때문에 각각의 셀마다 정보를 전달해주어야 한다라고 구분을 해줬다.
        // 타입캐스팅이라는 개념을 써줄 것이다.
        // UITableViewCell에는 써줄 수가 없다. 다시한번 봐야할듯
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "BoxOfficeTableViewCell", for: indexPath) as? BoxOfficeTableViewCell else {
            return UITableViewCell()
        }
        
        // 아래처럼 써도 되는데 위에서 쓰는것 처럼 써주는것이 좋음
//        let cell = tableView.dequeueReusableCell(withIdentifier: "BoxOfficeTableViewCell", for: indexPath) as! BoxOfficeTableViewCell
        
//        cell.posterImageView.backgroundColor = .red
//        cell.titleLabel.text = "7번방의 선물"
//        cell.releaseDateLabel.text = "2012.02.02"
//        cell.overviewLabel.text = "영화 줄거리, 영화 줄거리, 영화 줄거리, 영화 줄거리, 영화 줄거리, 영화 줄거리, 영화 줄거리, 영화 줄거리, 영화 줄거리, 영화 줄거리, 영화 줄거리, 영화 줄거리, 영화 줄거리, 영화 줄거리, 영화 줄거리, 영화 줄거리, 영화 줄거리, 영화 줄거리, 영화 줄거리, 영화 줄거리, 영화 줄거리, 영화 줄거리, 영화 줄거리, 영화 줄거리, 영화 줄거리, 영화 줄거리, 영화 줄거리, 영화 줄거리, 영화 줄거리, 영화 줄거리, 영화 줄거리, 영화 줄거리, 영화 줄거리, 영화 줄거리, 영화 줄거리, 영화 줄거리, 영화 줄거리, 영화 줄거리, 영화 줄거리, 영화 줄거리"
//        cell.overviewLabel.numberOfLines = 0

        return cell
    }
    
    // 셀의 크기
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 250
        // 기기마다 항상 5개정도 볼 수 있는 크기로 리턴된다.
        return UIScreen.main.bounds.height / 5
    }

}
