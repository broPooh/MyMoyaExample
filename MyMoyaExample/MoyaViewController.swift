//
//  MoyaViewController.swift
//  MyMoyaExample
//
//  Created by bro on 2022/07/20.
//

import UIKit

import Moya

class MoyaViewController: UIViewController {

    @IBOutlet weak var textField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    

    @IBAction func buttonClicked(_ sender: UIButton) {
        
        let text = textField.text!
        
        let provider = MoyaProvider<MoyaService>()
        provider.request(.searchTV(text)) { result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data // Data, your JSON response is probably in here!
                let statusCode = moyaResponse.statusCode
                print(data)
                print(statusCode)
                do {
                    let data = try JSONDecoder().decode(TvShows.self, from: data)
                    print(data.results)
                } catch {
                    print(error.localizedDescription)
                }
            case let .failure(error):
                print(error)
            }
        }
        
    }

}
