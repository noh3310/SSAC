//
//  PostView.swift
//  SeSAC_YearEndProject
//
//  Created by 노건호 on 2022/01/06.
//

import UIKit

class PostDetailView: UIView, CustomViewProtocol {
    
    let scrollView = UIScrollView()
    
    let userImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "star")
        imageView.layer.cornerRadius = 20
        return imageView
    }()
    
    let userNameLabel: UILabel = {
        let label = UILabel()
        label.text = "aaaaa"
        return label
    }()
    
    let dateLabel: UILabel = {
        let label = UILabel()
        label.text = "bbb"
        return label
    }()
    
    let divideLine: UIView = {
        let view = UIView()
        view.backgroundColor = .gray
        return view
    }()
    
    private let commentImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: "bubble.right")
        image.tintColor = .gray
        return image
    }()
    
    let commentLabel: UILabel = {
        let label = UILabel()
        label.text = "댓글 쓰기"
        label.font = .systemFont(ofSize: 15)
        return label
    }()
    
    let commentStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        return stack
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setStackView()
        
        addViews()
        makeConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setStackView() {
        commentStackView.addArrangedSubview(commentImage)
        commentStackView.addArrangedSubview(commentLabel)
    }
    
    func addViews() {
        self.addSubview(userImage)
        self.addSubview(userNameLabel)
        self.addSubview(dateLabel)
        self.addSubview(divideLine)
        self.addSubview(commentStackView)
    }
    
    func makeConstraints() {
        userImage.snp.makeConstraints {
            $0.top.leading.equalToSuperview().inset(20)
            $0.height.equalTo(40)
            $0.width.equalTo(userImage.snp.height).multipliedBy(1.0)
        }
        
        userNameLabel.snp.makeConstraints {
            $0.top.equalTo(userImage.snp.top)
            $0.leading.equalTo(userImage.snp.trailing).offset(20)
        }
        
        dateLabel.snp.makeConstraints {
            $0.top.equalTo(userNameLabel.snp.bottom).offset(5)
            $0.leading.equalTo(userNameLabel)
        }
        
        divideLine.snp.makeConstraints {
            $0.top.equalTo(dateLabel.snp.bottom).offset(20)
            $0.leading.trailing.equalToSuperview().inset(10)
        }
        
        commentStackView.snp.makeConstraints {
            $0.top.equalTo(divideLine.snp.bottom).offset(10)
            $0.leading.equalToSuperview().offset(20)
            $0.bottom.equalToSuperview().inset(10)
        }
    }
    

}
