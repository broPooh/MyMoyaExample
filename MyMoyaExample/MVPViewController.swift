//
//  MVPViewController.swift
//  MyMoyaExample
//
//  Created by bro on 2022/07/22.
//

import UIKit

class MVPViewController: UIViewController, TrafficLightViewDelegate {
    

    

    
    private let trafficLightPresenter = TrafficLightPresenter(trafficLightService: TrafficLightService())

    
    @IBOutlet weak var label: UILabel!
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        trafficLightPresenter.setViewDelegate(trafficLightViewDelegate: self)
    }
    
    func displayTrafficLight(description: (String)) {
        label.text = description

    }
  
    @IBAction func red(_ sender: Any) {
        trafficLightPresenter.trafficLightColorSelected(colorName:"Red")

    }
    
    @IBAction func yellow(_ sender: Any) {
        trafficLightPresenter.trafficLightColorSelected(colorName:"Yellow")
    }
    
    @IBAction func green(_ sender: Any) {
        trafficLightPresenter.trafficLightColorSelected(colorName:"Green")
    }
    
}
