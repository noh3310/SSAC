//
//  WebViewController.swift
//  SeSAC_04_Week
//
//  Created by 노건호 on 2021/10/19.
//

import UIKit
import WebKit

class WebViewController: UIViewController {

    @IBOutlet weak var urlSearchBar: UISearchBar!
    @IBOutlet weak var webView: WKWebView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        urlSearchBar.delegate = self

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension WebViewController: UISearchBarDelegate {
    
    // 서치바에서 검색 리턴키 클릭
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let url = URL(string: searchBar.text ?? "") else {
            print("ERROR")
            return
        }
        
        let request = URLRequest(url: url)
        webView.load(request)
    }
    
}
