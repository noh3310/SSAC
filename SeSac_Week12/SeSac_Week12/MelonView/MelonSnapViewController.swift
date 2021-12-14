//
//  MelonSnapViewController.swift
//  SeSac_Week12
//
//  Created by 노건호 on 2021/12/14.
//

import UIKit
import SnapKit

class MelonSnapViewController: UIViewController {
    
    var timer = Timer()
    var timerState = false
    
    // 타이틀
    let titleLabel: UILabel = {
        let label = UILabel()
        
        label.text = "strawberry moon"
        label.font = .boldSystemFont(ofSize: 20)
        label.textColor = .white
        
        return label
    }()
    
    // 가수 라벨
    let singerLabel: UILabel = {
       let label = UILabel()
        
        label.text = "아이유"
        label.font = .systemFont(ofSize: 15)
        label.textColor = .systemGray6
        
        return label
    }()
    
    // 아래로가기 버튼
    let arrowButton: UIButton = {
        let button = UIButton()
        
        button.setImage(UIImage(systemName: "chevron.down"), for: .normal)
        button.tintColor = .white
        
        return button
    }()
    
    // 더보기 버튼
    let moreInformationButton: UIButton = {
        let button = UIButton()
        
        button.setImage(UIImage(systemName: "ellipsis"), for: .normal)
        // 90도 회전(맞는 이모티콘을 찾지 못했습니다....)
        button.transform = CGAffineTransform(rotationAngle: CGFloat.pi / 2)
        button.tintColor = .white
        
        return button
    }()
    
    // 앨범 이미지
    let albumImage: UIImageView = {
        let imageView = UIImageView()
        
        imageView.image = UIImage(named: "IU_Album")
        
        return imageView
    }()
    
    let bottomView: MelonBottomView = {
        let view = MelonBottomView()
        
        view.backwardButton.addTarget(self, action: #selector(resetProgress), for: .touchUpInside)
        view.forwardButton.addTarget(self, action: #selector(resetProgress), for: .touchUpInside)
        
        return view
    }()
    
    let playingView: MelonPlayView = {
        let view = MelonPlayView()
        
        return view
    }()
    
    let albumInfoView = MelonAlbumInformationView()
    
    let lyrics: UILabel = {
        let label = UILabel()
        
        label.text = "달이 익어가니 서둘러 젊은 피야\n민들레 한 송이 들고"
        label.textColor = .white
        label.numberOfLines = 0
        label.textAlignment = .center
        
        return label
    }()
    
    // play버튼 클릭했을때 progressbar 시작
    @objc
    func stopAndPlayButtonClicked(_ button: UIButton) {
        // 시작버튼을 눌렀을 때
        if button.currentImage! == UIImage(systemName: "play.fill") {
            button.setImage(UIImage(systemName: "pause.fill"), for: .normal)
            // 계속 1초마다 실행할 수 있도록 함
            timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(musicProgress), userInfo: nil, repeats: true)
        } else {
            button.setImage(UIImage(systemName: "play.fill"), for: .normal)
            // 타이머 일시정지
            timer.invalidate()
        }
    }
    
    var totalTime = 60
    var currentTimeCount = 0
    
    @objc
    func musicProgress() {
        currentTimeCount = (currentTimeCount > totalTime) ? 0 : currentTimeCount + 1
        UIView.animate(withDuration: 1.0) {
            let animate = (self.currentTimeCount == 0) ? false : true
            self.playingView.statusView.setProgress(Float(self.currentTimeCount)/Float(self.totalTime), animated: animate)
        }
        var time: String = "0:" + ((currentTimeCount < 10) ? "0" : "") + "\(currentTimeCount)"
        time = (currentTimeCount == 60) ? "1:00" : time
        if currentTimeCount > totalTime {
            gotoStartingPoint()
        } else {
            playingView.currentTime.text = time
        }
    }
    
    func gotoStartingPoint() {
        currentTimeCount = 0
        playingView.currentTime.text = "0:00"
        playingView.statusView.progress = 0
        timer.invalidate()
        bottomView.stopAndPlayButton.setImage(UIImage(systemName: "play.fill"), for: .normal)
    }
    
    @objc
    func resetProgress() {
        gotoStartingPoint()
        // 프로세스를 계속 실행하도록 하는것
        playingView.statusView.observedProgress?.resume()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 배경색 설정
        view.backgroundColor = UIColor(red: 26/255, green: 24/255, blue: 24/255, alpha: 1)
        
        // 뷰의 서브뷰로 등록
        view.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            // 탑에서 20만큼 떨어지게 설정
            make.top.equalTo(view.safeAreaLayoutGuide).inset(20)
            // 중앙 정렬
            make.centerX.equalTo(view)
        }
        
        // 뷰의 서브뷰로 등록
        view.addSubview(singerLabel)
        singerLabel.snp.makeConstraints { make in
            // 가수 라벨에서 5만큼 떨어지게 설정(이거는 오프셋이 맞음)
            make.top.equalTo(titleLabel.snp.bottom).offset(5)
            // 중앙 정렬
            make.centerX.equalTo(view)
        }
        
        view.addSubview(arrowButton)
        arrowButton.snp.makeConstraints { make in
            // 위에서 Safearea에서 10 떨어지게 설정
            make.top.equalTo(view.safeAreaLayoutGuide).inset(10)
            // 오른쪽에서 10 떨어지게 설정
            make.trailing.equalTo(view.snp.trailing).inset(10)
        }
        
        view.addSubview(moreInformationButton)
        moreInformationButton.snp.makeConstraints { make in
            // arrowButton보다 5 밑에 위치
            make.top.equalTo(arrowButton.snp.bottom).offset(5)
            // 오른쪽에서 10 떨어지게 설정
            make.trailing.equalTo(view).inset(10)
        }
        
        // 앨범이미지 등록
        view.addSubview(albumImage)
        albumImage.snp.makeConstraints { make in
            // 일단 이미지 중앙으로 이동
            make.centerX.equalTo(view)
            let top = UIScreen.main.bounds.height / 10
            make.centerY.equalTo(view).offset(-top)
            // 크기 설정(ratio로 설정해보고 싶은데 잘 모르겠음)
            let size = UIScreen.main.bounds.width - 60
            make.width.equalTo(size)
            make.height.equalTo(size)
        }
        
        // 아래에 노래 시작 이미지 등록
        view.addSubview(bottomView)
        bottomView.snp.makeConstraints { make in
            // bottom에 맞게 설정
            make.bottom.equalTo(view.safeAreaLayoutGuide)
            // 너비 view에 딱맞게 설정
            make.width.equalTo(view)
            // 높이 설정
            make.height.equalTo(60)
        }
        
        // MARK: bottomView의 버튼들 설정
        bottomView.stopAndPlayButton.addTarget(self, action: #selector(stopAndPlayButtonClicked(_:)), for: .touchUpInside)
        bottomView.stopAndPlayButton.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.centerX.equalToSuperview()
        }
        
        bottomView.backwardButton.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.right.equalTo(bottomView.stopAndPlayButton.snp.left).offset(-30)
        }
        
        bottomView.forwardButton.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalTo(bottomView.stopAndPlayButton.snp.right).offset(30)
        }
        
        bottomView.playlistButton.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalTo(20)
        }
        
        bottomView.eqButton.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.right.equalTo(-20)
        }
        
        // MARK: 플레이리스트 설정
        // 플레이리스트 가져옴
        view.addSubview(playingView)
        playingView.snp.makeConstraints { make in
            // 내 bottom 을 아래 뷰의 top으로 설정
            make.bottom.equalTo(bottomView.snp.top)
            make.width.equalTo(view)
            make.height.equalTo(30)
        }
        
        playingView.cycleButton.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalTo(20)
        }
        
        playingView.shuffleButton.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.right.equalTo(-20)
        }
        
        playingView.statusView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalTo(playingView.cycleButton.snp.right).offset(20)
            make.right.equalTo(playingView.shuffleButton.snp.left).offset(-20)
        }
        
        playingView.totalTime.snp.makeConstraints { make in
            make.right.equalTo(playingView.statusView.snp.right)
            make.top.equalTo(playingView.statusView.snp.bottom).offset(5)
        }
        
        playingView.currentTime.snp.makeConstraints { make in
            make.left.equalTo(playingView.statusView.snp.left)
            make.top.equalTo(playingView.statusView.snp.bottom).offset(5)
        }
        
        // MARK: 앨범정보 설정
        view.addSubview(albumInfoView)
        albumInfoView.snp.makeConstraints { make in
            // 앨범보다 10더 아래에 위치
            make.top.equalTo(albumImage.snp.bottom).offset(10)
            // 높이설정
            make.height.equalTo(40)
            // 너비설정
            let size = UIScreen.main.bounds.width - 60
            make.width.equalTo(size)
            // 중간으로 위치 설정
            make.centerX.equalToSuperview()
        }
        
        albumInfoView.favoriteButton.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(3)
        }
        
        albumInfoView.favoriteCountLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalTo(albumInfoView.favoriteButton.snp.right).offset(10)
        }
        
        albumInfoView.instagramButton.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().inset(3)
            make.width.equalTo(30)
            make.height.equalTo(30)
        }
        
        albumInfoView.similarMusicButton.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.right.equalTo(albumInfoView.instagramButton.snp.left).offset(-10)
            make.width.equalTo(50)
        }
        
        // MARK: 가사 설정
        view.addSubview(lyrics)
        lyrics.snp.makeConstraints { make in
            make.top.equalTo(albumInfoView.snp.bottom).offset(10)
            make.centerX.equalToSuperview()
            let size = UIScreen.main.bounds.width - 60
            make.width.equalTo(size)
            make.bottom.equalTo(playingView.snp.top).offset(-10)
        }
    }
    
}
