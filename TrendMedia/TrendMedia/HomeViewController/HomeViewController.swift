//
//  HomeViewController.swift
//  TrendMedia
//
//  Created by 노건호 on 2021/10/17.
//

import UIKit
import Alamofire
import SwiftyJSON
import RealmSwift

class HomeViewController: UIViewController {
    
    // UIView관련 변수
    @IBOutlet weak var uiView: UIView!
    @IBOutlet weak var uiViewText: UILabel!
    @IBOutlet weak var customTableView: UITableView!
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var cinemaMapButton: UIBarButtonItem!
    
    @IBOutlet weak var button1: UIButton!
    @IBOutlet weak var button2: UIButton!
    @IBOutlet weak var button3: UIButton!
//    var buttonDictionary: [String:Any] = []
    
    // Open the default realm
    let localRealm = try! Realm()
    
    var genreList: Results<Genre>!
    
    // tvShow정보들을 가져옴
    var tvShowList = Sample.tvShow
    
    // API로 영화정보 가져옴
    var movieInformations: [Movie] = [] {
        didSet {
            print("MovieInformation 변경")
//            print(self.movieInformation)
//            getStarringAndGenreInformation()
            customTableView.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // realm에서 Genre 테이블을 가져옴
        genreList = localRealm.objects(Genre.self)
                
        // 라벨 설정
        setLabel()
        
        // 네비게이션바 설정
        setNavigationBar()
        
        // 버튼 설정
        setButtons()
        
        // 뷰컨트롤러를 테이블의 뷰 델리게이트, 데이터소스로 설정
        customTableView.delegate = self
        customTableView.dataSource = self
        
        print("Realm is Located at: ", localRealm.configuration.fileURL!)
        
        // 셀 크기 AutomaticDimension 설정
        customTableView.rowHeight = UITableView.automaticDimension
        
        // 커스텀 셀 사용가능하도록 테이블뷰에 등록
        let nibName = UINib(nibName: HomeScreenMovieInformationTableViewCell.identifier, bundle: nil)
        customTableView.register(nibName, forCellReuseIdentifier: HomeScreenMovieInformationTableViewCell.identifier)
        
        // 맨처음에 영화정보 다 불러오기(매일 업데이트되는 정보라 DB에 저장하는게 효율적인지는 잘 모르겠음)
        DispatchQueue.global().async {
            self.getMovieInformation()
        }
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        print(movieInformations)
    }
    
    // 라벨 설정
    func setLabel() {
        uiViewText.text = "Jack"
        uiViewText.textColor = .white
        uiViewText.backgroundColor = .blue
        uiViewText.textAlignment = .center
        uiViewText.font = uiViewText.font.withSize(50)
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
    
    func setButtonImage(button: UIButton, image: UIImage, color: UIColor) {
        button.setTitle("", for: .normal)
        button.setImage(image, for: .normal)
        button.tintColor = color
        button.imageView?.contentMode = .scaleAspectFit
        button.imageEdgeInsets = UIEdgeInsets(top: 10.0, left: 0.0, bottom: 10.0, right: 0.0)
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
            
            // 지도 아이템 설정
            cinemaMapButton.image = UIImage(systemName: "map")
            cinemaMapButton.tintColor = .black
        }
    }
    
    // 영화정보 API로 불러와서 저장하기
    func getMovieInformation() {
        MoviePopularListAPI.shared.getPopularMovieList { status, json in
            switch status {
            // 올바르게 정보가 왔을 때
            case 200:
                let results = json["results"].arrayValue
                
                var movieList: [Movie] = []
                
                results.forEach { json in
                    let id = json["id"].intValue
                    let title = json["title"].stringValue
                    let releasedDate = json["release_date"].stringValue
    //                let starring = json[0]["
                    let genres = json["genre_ids"].arrayValue.map { $0.stringValue }
                    
                    let imageLink = json["poster_path"].stringValue
                    let rate = json["vote_average"].doubleValue
                    let overview = json["overview"].stringValue
                    let backDropLink = json["backdrop_path"].stringValue
                    
                    let movie = Movie(id: id, title: title, releaseDate: releasedDate, starring: [], genres: genres, imageLink: imageLink, backDropLink: backDropLink, rate: rate, overview: overview)
                    
                    movieList.append(movie)
                }
                
                // 변수에 넣어줌
                self.movieInformations = movieList
                
            // 유저가 정보를 잘못 보냈을 때
            case 401, 404:
                print("오류발생")
            default:
                print("default")
            }
        }
    }
    
    // 검색버튼 클릭했을 때 viewController push해줌
    @IBAction func searchButtonClicked(_ sender: UIBarButtonItem) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "SearchView", bundle:nil)
        
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "SearchViewController")
        nextViewController.modalPresentationStyle = .fullScreen
        self.present(nextViewController, animated: true, completion: nil)
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
        return movieInformations.count
    }
    
    // 높이 지정
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 360
    }
    
    // 보여줄 UITableViewCell을 리턴해줌
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // 커스텀셀 변경
        let cell = tableView.dequeueReusableCell(withIdentifier: HomeScreenMovieInformationTableViewCell.identifier, for: indexPath) as! HomeScreenMovieInformationTableViewCell
        
        let row = movieInformations[indexPath.row]
        cell.titleLabel.text = row.title
        cell.rateLabel.text = "\(row.rate)"
        cell.rateLabel.backgroundColor = .white
        cell.rateLabel.textAlignment = .center
        cell.rateTextLabel.text = "평점"
        cell.rateTextLabel.textColor = .white
        cell.rateTextLabel.textAlignment = .center
        cell.rateTextLabel.backgroundColor = UIColor(red: 99/255, green: 99/255, blue: 211/255, alpha: 1)
        
        // 영화배우 정보가 있다면
        if row.starring.count > 0 {
            cell.actorListLabel.text = "있음"
        } else {
            cell.actorListLabel.text = "없음"
        }
        cell.actorListLabel.textColor = .gray
        
        cell.genreLabel.text = "#\(String(describing: row.genres.first))"
        cell.releaseDateLabel.text = row.releaseDate
        cell.releaseDateLabel.textColor = .gray
//        let url = URL(string: "")
        
//        cell.titleLabel.text = tvShowList[indexPath.row].title
//        cell.rateLabel.text = "\(tvShowList[indexPath.row].rate)"
//        cell.rateLabel.backgroundColor = .white
//        cell.rateLabel.textAlignment = .center
//        cell.rateTextLabel.text = "평점"
//        cell.rateTextLabel.textColor = .white
//        cell.rateTextLabel.textAlignment = .center
//        cell.rateTextLabel.backgroundColor = UIColor(red: 99/255, green: 99/255, blue: 211/255, alpha: 1)
//
//        // tvShowList에 정보가 없는 경우가 있어서 따로 처리해줌
//        if tvShowList[indexPath.row].starring == "" {
//            cell.actorListLabel.text = "출연진 정보 없음"
//        } else {
//            cell.actorListLabel.text = tvShowList[indexPath.row].starring
//        }
//        cell.actorListLabel.textColor = .gray
//        cell.genreLabel.text = "#\(tvShowList[indexPath.row].genre)"
//        cell.releaseDateLabel.text = tvShowList[indexPath.row].releaseDate
//        cell.releaseDateLabel.textColor = .gray
//        let url = URL(string: tvShowList[indexPath.row].backdropImage)
//        do {
//            let image = try Data(contentsOf: url!)
//            cell.posterImageView.image = UIImage(data: image)
//            cell.posterImageView.contentMode = .scaleAspectFill
//            cell.posterImageView.clipsToBounds = true
//        }
//        catch {
//
//        }
        
        let url = URL(string: "https://image.tmdb.org/t/p/w500/\(row.imageLink)")
        cell.posterImageView.kf.setImage(with: url)
        cell.posterImageView.contentMode = .scaleToFill
        cell.posterImageView.layer.masksToBounds = true
        

        // 나중에 이 버튼 델리게이트 패턴으로 늘리기
        cell.linkButton.setTitle("", for: .normal)
        if #available(iOS 13.0, *) {
            cell.linkButton.setImage(UIImage(systemName: "link.circle.fill"), for: .normal)
            cell.linkButton.tintColor = .lightGray

//            cell.detailButtonStyleLabel. = UIImage(systemName: "chevron.right")

            let attributedString = NSMutableAttributedString(string: "")
            let imageAttachment = NSTextAttachment()
            imageAttachment.image = UIImage(systemName: "chevron.right")
            attributedString.append(NSAttributedString(attachment: imageAttachment))
            cell.detailButtonStyleLabel.attributedText = attributedString
        }
        else {

        }

        cell.detailLabel.text = "자세히 보기"
        cell.detailLabel.textColor = .gray

        // UIView radius, Shadow 설정
//        cell.movieInformationUiView.backgroundColor = .gray
        cell.movieInformationUiView.layer.cornerRadius = 10
        
        
        return cell
    }
    
    // 셀 클릭했을 때
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "DetailView", bundle:nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "MovieDetailViewController") as! MovieDetailViewController
        
        // 영화정보 넘겨줌
        vc.movieInformation = movieInformations[indexPath.row]
        
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
