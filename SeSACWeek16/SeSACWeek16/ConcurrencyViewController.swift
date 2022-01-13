//
//  ConcurrencyViewController.swift
//  SeSACWeek16
//
//  Created by 노건호 on 2022/01/12.
//

import UIKit

class ConcurrencyViewController: UIViewController {
    
    @IBOutlet weak var imageView1: UIImageView!

    @IBOutlet weak var imageView2: UIImageView!
    
    @IBOutlet weak var imageView3: UIImageView!
    let url1 = URL(string: "https://apod.nasa.gov/apod/image/2201/OrionStarFree3_Harbison_5000.jpg")!
        let url2 = URL(string: "https://apod.nasa.gov/apod/image/2112/M3Leonard_Bartlett_3843.jpg")!
        let url3 = URL(string: "https://apod.nasa.gov/apod/image/2112/LeonardMeteor_Poole_2250.jpg")!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }

    @IBAction func basic(_ sender: UIButton) {
        print("hello world")
        
        for i in 1...100 {
            print(i, terminator: ", ")
        }
        print()
        
        for i in 101...200 {
            print(i, terminator: ", ")
        }
        
        print("bye bye world")
    }
    
    @IBAction func mainAsync(_ sender: UIButton) {
        print("hello world")
        
        DispatchQueue.main.async {
            for i in 1...100 {
                print(i, terminator: ", ")
            }
            print()
        }
        
        DispatchQueue.main.async {
            for i in 101...200 {
                print(i, terminator: ", ")
            }
            print()
        }
        
        print("bye bye world")
    }
    
    @IBAction func globalSyncAsync(_ sender: UIButton) {
        print("hello world")
        
        // global.sync는 결국 메인스레드가 다른 스레드에서 동작하는것과 유사하지 않나?
        // 다른 스레드로 동기적으로 보내는 코드
//        DispatchQueue.global().async {
//            for i in 1...100 {
//                print(i, terminator: ", ")
//            }
//            print()
//        }
        
        for i in 1...100 {
            DispatchQueue.global().async {
                print(i, terminator: ", ")
            }
        }
        
        for i in 101...200 {
            print(i, terminator: ", ")
        }
        print()
        
        
        print("bye bye world")
    }
    
    @IBAction func globalQoS(_ sender: UIButton) {
//        let queue = DispatchQueue(label: "jack")    // Serial
        let queue = DispatchQueue(label: "concurrentJack", qos: .userInteractive, attributes: .concurrent)
        
        DispatchQueue.global(qos: .background).async {
            for i in 1...100 {
                print(i, terminator: ", ")
            }
        }
        
        DispatchQueue.global(qos: .userInteractive).async {
            for i in 101...200 {
                print(i, terminator: ", ")
            }
        }
        
        DispatchQueue.global(qos: .utility).async {
            for i in 201...300 {
                print(i, terminator: ", ")
            }
        }
    }
    
    @IBAction func dispatchGroup(_ sender: UIButton) {
        let group = DispatchGroup()
        
        DispatchQueue.global().async(group: group) {
            for i in 1...100 {
                print(i, terminator: ", ")
            }
        }
        
        DispatchQueue.global().async(group: group) {
            for i in 101...200 {
                print(i, terminator: ", ")
            }
        }
        
        DispatchQueue.global().async(group: group) {
            for i in 201...300 {
                print(i, terminator: ", ")
            }
        }
        
        group.notify(queue: .main) {
            print("작업 완료")
        }
    }
    
    @IBAction func urlsessionDispatchGroup(_ sender: UIButton) {
//        request(url: url1) { image in
//            print("image1")
//        }
//
//        request(url: url2) { image in
//            print("image2")
//        }
//
//        request(url: url3) { image in
//            print("image3")
//        }
//
//        let group = DispatchGroup()
//
//        DispatchQueue.global().async(group: group) {
//            self.request(url: self.url1) { image in
//                print("image1")
//            }
//        }
//
//        DispatchQueue.global().async(group: group) {
//            self.request(url: self.url2) { image in
//                print("image2")
//            }
//        }
//
//        DispatchQueue.global().async(group: group) {
//            self.request(url: self.url3) { image in
//                print("image3")
//            }
//        }
//
//        group.notify(queue: .main) {
//            print("작업 완료")
//        }
        let group = DispatchGroup()
        
        group.enter()
        self.request(url: self.url1) { image in
            print("image1")
            group.leave()
        }
        
        group.enter()
        self.request(url: self.url2) { image in
            print("image2")
            group.leave()
        }
        
        group.enter()
        self.request(url: self.url3) { image in
            print("image3")
            group.leave()
        }
        
        group.notify(queue: .main) {
            print("작업 완료")
        }
    }
    
    func request(url: URL, completionHandler: @escaping (UIImage?) -> Void) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else {
                completionHandler(UIImage(systemName: "star"))
                return
            }
            
            let image = UIImage(data: data)
            completionHandler(image)
        }.resume()
    }
    
    func newRequest(url: URL) async throws -> UIImage {
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw APIError.statusCodeError
        }
        
        guard let image = UIImage(data: data) else {
            throw APIError.unsupportedImage
        }
        
        return image
    }
    
    @IBAction func asyncAwait(_ sender: UIButton) {
        Task {
            do {
                let request1 = try await newRequest(url: url1)
                let request2 = try await newRequest(url: url2)
                let request3 = try await newRequest(url: url3)
                
                imageView1.image = request1
                imageView2.image = request2
                imageView3.image = request3
                
            } catch {
                
            }
            
        }
    }
    
    @IBAction func raceCondition(_ sender: Any) {
        var nickname = "Jack"
        let group = DispatchGroup()
        
        DispatchQueue.global(qos: .userInteractive).async(group: group) {
            nickname = "미묘한도사"
            print("FIRST: \(nickname)")
        }
        
        DispatchQueue.global(qos: .userInteractive).async(group: group) {
            nickname = "쭙쭙이"
            print("SECOND: \(nickname)")
        }
        
        group.notify(queue: .main) {
            print("Result: \(nickname)")
        }
    }
    
}

enum APIError: Error {
    case statusCodeError
    case unsupportedImage
}
