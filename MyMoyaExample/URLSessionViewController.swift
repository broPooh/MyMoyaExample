//
//  URLSessionViewController.swift
//  MyMoyaExample
//
//  Created by bro on 2022/07/20.
//

import UIKit

class URLSessionViewController: UIViewController {

    
    @IBOutlet weak var textField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func buttonClicked(_ sender: UIButton) {
        let text = textField.text!
        
        APIService.searchTvShows(text: text) { result in
            switch result {
            case .success(let response):
                print(response)
            case .failure(let error):
                print(error.description)
            }
        }
        
    }
    
}
