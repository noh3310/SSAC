//
//  VisionViewController.swift
//  SeSAC_WEEK5_CLASS
//
//  Created by 노건호 on 2021/10/27.
//

import UIKit
import Alamofire
import SwiftyJSON
import AVFoundation
import JGProgressHUD

class VisionViewController: UIViewController {

    @IBOutlet weak var postImageView: UIImageView!
    @IBOutlet weak var requestButton: UIButton!
    @IBOutlet weak var resultLabel: UILabel!
    
    let progress = JGProgressHUD()
    let imagePicker = UIImagePickerController()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imagePicker.sourceType = .photoLibrary
        imagePicker.allowsEditing = true
        imagePicker.delegate = self
    }
    
    @IBAction func requestButtonClicked(_ sender: UIButton) {
        
        progress.show(in: view, animated: true)
        
        VisionAPIManager.shared.fetchFaceData(image: postImageView.image!) { code, json in
            print(json)
            
            self.progress.dismiss(animated: true)
        }
    }
    
    @IBAction func photoLibraryButtonClicked(_ sender: UIButton) {
        // imagePicker역시 UIVIewController를 상속받았기 때문에 넣을 수 있다.
        self.present(imagePicker, animated: true, completion: nil)
    }
}

extension VisionViewController: UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    // 사진을 촬영하거나, 갤러리에서 사진을 선택한 직후에 실행
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        print(#function)
        
        // 1. 선택할 사진 가져오기(originalImage를 하면 아무리 수정해도 원래사진이 나옴, editedImage는 수정한 사진이 나옴)
        // allowEditing = false라면 > editedImage는 nil값이라 옵셔널 바인딩 안의 구문은 실행되지 않을 것임
        if let value = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            // 2. 로직: 이미지뷰에 선택한 사진 보여주기
            postImageView.image = value
        }
        
        // 3. picker dismiss를 해줘야한다.
        picker.dismiss(animated: true, completion: nil)
    }
    
    // 피커뷰를 캔슬했을때
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        print(#function)
        picker.dismiss(animated: true, completion: nil)
    }
}
