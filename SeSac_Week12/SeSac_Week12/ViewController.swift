//
//  ViewController.swift
//  SeSac_Week12
//
//  Created by 노건호 on 2021/12/13.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var favoriteMenuView: SquareBoxView!

    // 코드로 인스턴스 생성
    let redView = UIView()
    let greenView = UIView()
    let blueView = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 코드로 addSubView로 추가
        blueView.addSubview(redView)
        view.addSubview(greenView)
        view.addSubview(blueView)
        
        // 이것을 설정하면 크기가 벗어나더라도 blueView를 벗어나는것들은 다 지워진다.
        blueView.clipsToBounds = true
        // 자식의 배경 알파값도 변공된다.
        blueView.alpha = 0.5
        
        redView.frame = CGRect(x: 20, y: 20, width: 200, height: 200)
        redView.backgroundColor = .red
        greenView.frame = CGRect(x: 100, y: 100, width: 150, height: 150)
        greenView.backgroundColor = .green
        blueView.frame = CGRect(x: 100, y: 100, width: 100, height: 100)
        blueView.backgroundColor = .blue
        
        favoriteMenuView.label.text = "즐겨찾기"
        favoriteMenuView.imageView.image = UIImage(systemName: "star")
        // Do any additional setup after loading the view.
    }

    @IBAction func presentButtonClicked(_ sender: UIButton) {
        // 그냥 이렇게만 호출해주면 화면이 넘어감 ㄷㄷ
        present(DetailViewController(), animated: true, completion: nil)
    }
    
}

// MARK: for canvas
import SwiftUI

struct ViewControllerRepresentable: UIViewControllerRepresentable {
    typealias UIViewControllerType = ViewController

    func makeUIViewController(context: Context) -> ViewController {
        return ViewController()
    }

    func updateUIViewController(_ uiViewController: ViewController, context: Context) {
    }
}

@available(iOS 13.0.0, *)
struct ViewPreview: PreviewProvider {
    static var previews: some View {
        ViewControllerRepresentable()
    }
}
