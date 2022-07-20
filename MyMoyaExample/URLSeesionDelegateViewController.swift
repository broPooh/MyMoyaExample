//
//  URLSeesionDelegateViewController.swift
//  MyMoyaExample
//
//  Created by bro on 2022/07/20.
//

import UIKit

class URLSeesionDelegateViewController: UIViewController {

    @IBOutlet weak var textField: UITextField!
    
    var session: URLSession!
    var buffer: Data? {
        didSet {
            print(buffer)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        buffer = Data()
    }

    
    
    @IBAction func buttonClicked(_ sender: UIButton) {
        let text = textField.text!
        APIService.searchTvShowsDelegate(text: text, delegate: self)
    }
}


extension URLSeesionDelegateViewController: URLSessionDataDelegate {
    
    //서버에서 최초로 응답을 받은 경우 호출
    func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive response: URLResponse, completionHandler: @escaping (URLSession.ResponseDisposition) -> Void) {
        if let response = response as? HTTPURLResponse, (200..<300).contains(response.statusCode) {
            return completionHandler(.allow)
        } else {
            return completionHandler(.cancel)
        }
        
    }
    
    
    //서버에서 데이터를 받을 때마다 반복적으로 호출
    func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive data: Data) {
        //받아오는 데이터를 하나로 합쳐주기
        buffer?.append(data)
    }
    
    //응답이 완료가 되었을때
    func urlSession(_ session: URLSession, task: URLSessionTask, didCompleteWithError error: Error?) {
        if let error = error {
            print("에러가 발생", error)
        } else {
            print("성공!")
            
            guard let buffer = buffer else {
                print("buffer Error")
                return
            }
            
            do {
                let data = try JSONDecoder().decode(TvShows.self, from: buffer)
                print(data)
            } catch {
                print(error.localizedDescription)
            }
            
        }
    }
    
}
