//
//  DetailViewController.swift
//  SeSac_Week12
//
//  Created by 노건호 on 2021/12/13.
//

import UIKit
import Firebase
import CoreMedia

class DetailViewController: UIViewController {
    
    let titleLabel = UILabel()
    let captionLabel = UILabel()
    let activateButton = MainActivateButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tabBarItem.selectedImage = UIImage(systemName: "person")
        tabBarItem.image = UIImage(systemName: "person.fill")
        tabBarItem.title = "디테일뷰"
        
        // 이런식으로 할수있는건 신기하네
        [titleLabel, captionLabel, activateButton].forEach {
            view.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        view.backgroundColor = .white
        
        setTitleLabelConstraints()
        
        setCaptionLabelConstraints()
        
        setActivateButtonConstraints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        Installations.installations().delete { error in
            if let error = error {
                print("Error deleting installation: \(error)")
                return
            }
            print("installation deleted")
        }
    }
    
    func setActivateButtonConstraints() {
        NSLayoutConstraint.activate([
            // 센터 중앙에 오게할 것이다.
            activateButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activateButton.widthAnchor.constraint(equalToConstant: view.bounds.width - 40),
            activateButton.heightAnchor.constraint(equalToConstant: 50),
            activateButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    func setCaptionLabelConstraints() {
        captionLabel.text = "맞춤 정보를 알려드려요"
        captionLabel.backgroundColor = .darkGray
        captionLabel.font = .boldSystemFont(ofSize: 12)
        captionLabel.textAlignment = .center
        
        let topConstraint = NSLayoutConstraint(item: captionLabel, attribute: .top, relatedBy: .equal, toItem: titleLabel, attribute: .bottom, multiplier: 1, constant: 20)
        
        let centerX = NSLayoutConstraint(item: captionLabel, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1, constant: 0)
        let width = NSLayoutConstraint(item: captionLabel, attribute: .width, relatedBy: .equal, toItem: view, attribute: .width, multiplier: 0.7, constant: 0)
        let height = NSLayoutConstraint(item: captionLabel, attribute: .height, relatedBy: .equal, toItem: titleLabel, attribute: .height, multiplier: 0.5, constant: 0)
        
        view.addConstraints([topConstraint, centerX, width, height])
        
//        NSLayoutConstraint(item: captionLabel, attribute: .leading, relatedBy: .equal, toItem: view, attribute: .leading, multiplier: 1, constant: 40).isActive = true
//        NSLayoutConstraint(item: captionLabel, attribute: .trailing, relatedBy: .equal, toItem: view, attribute: .trailing, multiplier: 1, constant: -40).isActive = true
//        // Multiplier를 0.2로 설정하면 뷰의 높이 대비 0.2의 높이로 고정한다.
//        NSLayoutConstraint(item: captionLabel, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1, constant: 80).isActive = true
    }
    
    func setTitleLabelConstraints() {
        titleLabel.text = "관심 있는 회사\n3개를 선택해주세요"
        titleLabel.backgroundColor = .lightGray
        titleLabel.font = .boldSystemFont(ofSize: 24)
        titleLabel.textAlignment = .center
        titleLabel.numberOfLines = 0
        
        
//        titleLabel.frame = CGRect(x: 100, y: 100, width: UIScreen.main.bounds.width - 200, height: 80)
        
        // NSLayoutContraints
        // 프레임이 아니라 제약조건 기반으로 작성하게 된다.
        // 선형방정식을 구현하 수 있는 것이라고 생각하면 된다.
        let topConstraint = NSLayoutConstraint(item: titleLabel, attribute: .top, relatedBy: .equal, toItem: view.safeAreaLayoutGuide, attribute: .top, multiplier: 1, constant: 0)
        topConstraint.isActive = true
        NSLayoutConstraint(item: titleLabel, attribute: .leading, relatedBy: .equal, toItem: view, attribute: .leading, multiplier: 1, constant: 40).isActive = true
        NSLayoutConstraint(item: titleLabel, attribute: .trailing, relatedBy: .equal, toItem: view, attribute: .trailing, multiplier: 1, constant: -40).isActive = true
        // Multiplier를 0.2로 설정하면 뷰의 높이 대비 0.2의 높이로 고정한다.
        NSLayoutConstraint(item: titleLabel, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1, constant: 80).isActive = true
    }
}
