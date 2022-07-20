//
//  AlamofireViewController.swift
//  MyMoyaExample
//
//  Created by bro on 2022/07/20.
//

import UIKit

import Alamofire
import SwiftyJSON

class AlamofireViewController: UIViewController {

    @IBOutlet weak var textField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    

    @IBAction func buttonClicked(_ sender: UIButton) {
        
        let text = textField.text!
        
        if let query = text.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) {
            let url = URL.searchTvShowsString(text: query)
            
            AF.request(url, method: .get).validate().responseJSON { response in
                switch response.result {
                case .success(let value):
                    let json = JSON(value)
                    print("SwiftyJSON 사용")
                    print(json)
                case .failure(let error):
                    print("error발생")
                    print(error)
                }
            }
            
            AF.request(url, method: .get).validate()
                .responseDecodable(of: TvShows.self) { response in
                switch response.result {
                case .success(let movieResult):
                    print("Codable 사용")
                    print(movieResult)
                case .failure(let error):
                    print("error발생")
                    print(error)
                }
            }
        }
        
       
    }
    
}
