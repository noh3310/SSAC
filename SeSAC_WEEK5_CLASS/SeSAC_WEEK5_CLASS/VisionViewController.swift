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

class VisionViewController: UIViewController {

    @IBOutlet weak var postImageView: UIImageView!
    @IBOutlet weak var requestButton: UIButton!
    @IBOutlet weak var resultLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func requestButtonClicked(_ sender: UIButton) {
        VisionAPIManager.shared.fetchFaceData(image: postImageView.image!) { code, json in
            print(json)
        }
    }
}
