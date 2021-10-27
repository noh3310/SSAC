//
//  VisionAPIManager.swift
//  SeSAC_WEEK5_CLASS
//
//  Created by 노건호 on 2021/10/27.
//

import Alamofire
import SwiftyJSON
import UIKit.UIImage

class VisionAPIManager {
    static let shared = VisionAPIManager()
    
    func fetchFaceData(image: UIImage, result: @escaping (Int, JSON) -> ()) {
        
        let header: HTTPHeaders = [
            "Authorization":APIKey.KAKAO,
            "Content-Type":"image/png"
//            "Content-Type":"multipart/form-data"
        ]
        
        // UIImage를 바이너리 타입으로 변환
        // jpg, png 둘다 타입변환 가능한데 jpg는 압축이 가능함
        guard let imageData = image.pngData() else { return }
        
        // AF.request를 다 변환해야함
        AF.upload(multipartFormData: { multipartFormData in
            multipartFormData.append(imageData, withName: "image", fileName: "imagedd")
        }, to: EndPoint.visionURL, headers: header).validate(statusCode: 200...500).responseJSON { response in
            switch response.result {
            case .success(let value):
                
                let json = JSON(value)
                print("JSON: \(json)")
                
                let code = response.response?.statusCode ?? 500
                
                result(code, json)
                
            case .failure(let error):
                print(error)
            }
        }
    }
}
