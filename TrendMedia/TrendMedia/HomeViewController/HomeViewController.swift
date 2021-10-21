//
//  HomeViewController.swift
//  TrendMedia
//
//  Created by 노건호 on 2021/10/17.
//

import UIKit

class HomeViewController: UIViewController {
    
    // UIView관련 변수
    @IBOutlet weak var uiView: UIView!
    @IBOutlet weak var uiViewText: UILabel!
    @IBOutlet weak var customTableView: UITableView!
    @IBOutlet weak var stackView: UIStackView!
    
    @IBOutlet weak var button1: UIButton!
    @IBOutlet weak var button2: UIButton!
    @IBOutlet weak var button3: UIButton!
//    var buttonDictionary: [String:Any] = []
    
    // tvShow정보들을 가져옴
    var tvShowList = Sample.tvShow

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 라벨 설정
        setLabel()
        
        // 네비게이션바 설정
        setNavigationBar()

        
//        buttonDictionary = [
//            ["button": buttons[0]]
//            ["image": buttonImages[0]]
//            ["color": buttonColor]
//        ]
        
        // 버튼 설정
        setButtons()
        
        // 뷰컨트롤러를 테이블의 뷰 델리게이트, 데이터소스로 설정
        customTableView.delegate = self
        customTableView.dataSource = self
        
        let nibName = UINib(nibName: MoviePreviewTableViewCell.identifier, bundle: nil)
        customTableView.register(nibName, forCellReuseIdentifier: MoviePreviewTableViewCell.identifier)
    }
    
    // 라벨 설정
    func setLabel() {
        uiViewText.text = "Jack"
        uiViewText.textColor = .white
        uiViewText.backgroundColor = .blue
        uiViewText.textAlignment = .center
    }
    
    // 버튼 설정(미완성)
    func setButtons() {
        // 스택뷰 설정(배경색, 마진, 모서리)
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.layoutMargins = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
        stackView.backgroundColor = .white
        stackView.layer.cornerRadius = 5

        // 버튼값 초기화
        let buttons: [UIButton] = [button1, button2, button3]
        var buttonImages: [UIImage] = []
        if #available(iOS 13.0, *) {
             buttonImages = [UIImage(systemName: "film")!, UIImage(systemName: "tv")!, UIImage(systemName: "book.closed")!]
        }
        let color: [UIColor] = [UIColor.orange, UIColor.green, UIColor.blue]
        
        // 반복문으로 실행
        for index in buttons.indices {
            setButtonImage(button: buttons[index], image: buttonImages[index], color: color[index])
        }
    }
    
    // 네비게이션바 설정
    func setNavigationBar() {
        // 타이틀
        self.title = "TREND MEDIA"
        
        let navigation = self.navigationItem
        if #available(iOS 13.0, *) {
            // 왼쪽 내비게이션바 설정
            navigation.leftBarButtonItem?.image = UIImage(systemName: "list.dash")
            navigation.leftBarButtonItem?.tintColor = .black
            
            // 오른쪽 내비게이션바 설정
            navigation.rightBarButtonItem?.image = UIImage(systemName: "magnifyingglass")
            navigation.rightBarButtonItem?.tintColor = .black
        }
    }
    
    // 검색버튼 클릭했을 때 viewController push해줌
    @IBAction func searchButtonClicked(_ sender: UIBarButtonItem) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "SearchView", bundle:nil)
        
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "SearchViewController")
        nextViewController.modalPresentationStyle = .fullScreen
        self.present(nextViewController, animated: true, completion: nil)
    }
    
    func setButtonImage(button: UIButton, image: UIImage, color: UIColor) {
        button.setTitle("", for: .normal)
        button.setImage(image, for: .normal)
        button.tintColor = color
    }
    
    // 내영화 버튼 클릭했을 때
    @IBAction func MyMovieButtonClicked(_ sender: UIBarButtonItem) {
        let storyboard: UIStoryboard = UIStoryboard(name: "MyMedia", bundle: nil)
        
        let nextViewController = storyboard.instantiateViewController(withIdentifier: MyMediaViewController.identifier)
        
        self.navigationController?.pushViewController(nextViewController, animated: true)
    }
    
    @IBAction func movieMapViewButtonClicked(_ sender: UIBarButtonItem) {
        let storyboard = UIStoryboard(name: "MovieMapView", bundle: nil)
        
        let nextViewController = storyboard.instantiateViewController(withIdentifier: MovieMapViewController.identifier)
        
        self.navigationController?.pushViewController(nextViewController, animated: true)
    }
    
}

// 테이블뷰 extension
extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    
    // 테이블뷰 row의 개수
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tvShowList.count
    }
    
    // 높이 지정
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "MoviePreviewTableViewCell", for: indexPath) as! MoviePreviewTableViewCell
        return 350
    }
    
    // 보여줄 UITableViewCell을 리턴해줌
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            
        let cell = tableView.dequeueReusableCell(withIdentifier: "MoviePreviewTableViewCell", for: indexPath) as! MoviePreviewTableViewCell
        
        cell.delegate = self
        cell.titleLabel.text = tvShowList[indexPath.row].title
        cell.rateLabel.text = "\(tvShowList[indexPath.row].rate)"
        cell.actorListLabel.text = tvShowList[indexPath.row].starring
        cell.genreLabel.text = tvShowList[indexPath.row].genre
        cell.releaseDateLabel.text = tvShowList[indexPath.row].releaseDate
        let url = URL(string: tvShowList[indexPath.row].backdropImage)
        do {
            let image = try Data(contentsOf: url!)
            cell.posterImageView.image = UIImage(data: image)
        }
        catch {

        }
        

//        TvShow(title: "Squid Game", releaseDate: "09/17/2021",genre: "Mystery",region: "South Korea", overview: "Hundreds of cash-strapped players accept a strange invitation to compete in children's games. Inside, a tempting prize awaits — with deadly high stakes.", rate: 8.3, starring: "Lee Jung-jae, Park Hae-soo, Wi Ha-jun, Heo Sung-tae, Kim Joo-ryoung, Jung Ho-yeon, Lee You-mi",backdropImage:"https://www.themoviedb.org/t/p/original/oaGvjB0DvdhXhOAuADfHb261ZHa.jpg"),
        
        
        return cell
    }
    
    // 셀 클릭했을 때
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "DetailView", bundle:nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "MovieDetailViewController") as! MovieDetailViewController
        
        vc.titleLabelString = tvShowList[indexPath.row].title
        vc.actorList = tvShowList[indexPath.row].starring.components(separatedBy: ", ")
        let url = URL(string: tvShowList[indexPath.row].backdropImage)
        do {
            let image = try Data(contentsOf: url!)
            vc.posterImage = UIImage(data: image)
        }
        catch {

        }
        
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

// 델리게이트 패턴을 이용해서 프로그래밍 해줌
protocol CellDelegate {
    func clickedButton()
}

extension HomeViewController: CellDelegate {
    func clickedButton() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)

        let vc = storyboard.instantiateViewController(withIdentifier: "PopUpViewViewController") as! PopUpViewViewController

        self.present(vc, animated: true, completion: nil)
    }
}
