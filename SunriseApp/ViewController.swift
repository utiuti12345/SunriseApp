//
//  ViewController.swift
//  SunriseApp
//
//  Created by saotome on 2020/04/15.
//  Copyright © 2020 saotome. All rights reserved.
//

import UIKit

class ViewController: UIViewController {


    @IBOutlet weak var cityNameInput: UITextField!
    @IBOutlet weak var suriseTimeLabel: UILabel!
    @IBAction func findSunrise(_ sender: Any) {
        let url = "http://api.openweathermap.org/data/2.5/forecast?q=\(cityNameInput.text!)&appid=c12b7aa47f8707c2f43fb3c51f1e0ba9"
        getURL(url:url)
    }
    @IBOutlet weak var pushButton: UIButton!
    @IBOutlet weak var popButton: UIButton!
    @IBOutlet weak var modalButton: UIButton!
    @IBOutlet weak var dismissButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        pushButton.addTarget(self, action: #selector(ViewController.pushButtonTapped(_:)), for: .touchUpInside)
        popButton.isEnabled = navigationController!.children.count > 1
        popButton.addTarget(self, action: #selector(ViewController.popButtonTapped(_:)),for:.touchUpInside)
        
        modalButton.addTarget(self, action: #selector(ViewController.modalButtonTapped(_:)), for: .touchUpInside)
        dismissButton.isEnabled = presentingViewController != nil
        
        dismissButton.target = self
        dismissButton.action = #selector(ViewController.dismissButtonTapped(_:))
        
        NSLog("\(navigationController?.children)")
    }
    
    func getURL(url:String){
        do {
            let apiURL = URL(string: url)!
            let data = try Data(contentsOf: apiURL)
            let json = try JSONSerialization.jsonObject(with: data) as! [String:Any]
            print(json)
            let city = json["city"] as! [String:Any]
            let name = city["name"] as! NSString
            let sunrise = city["sunrise"] as! TimeInterval
            let sunriseDate = NSDate(timeIntervalSince1970: sunrise)
            let formatter = DateFormatter()
            formatter.dateFormat = "HH時mm分ss秒"
            let suriseTimestamp = formatter.string(from: sunriseDate as! Date)
            print(suriseTimestamp)
            suriseTimeLabel.text = "日の出時刻:\(suriseTimestamp)"
        } catch{
            self.suriseTimeLabel.text = "サーバーに接続できません"
        }
    }
    
    @objc func pushButtonTapped(_ sender: Any){
        let nvc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateInitialViewController() as! UINavigationController
        let vc = nvc.children[0] as! ViewController
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func popButtonTapped(_ sender:Any){
        _ = navigationController?.popViewController(animated: true)
    }
    
    @objc func modalButtonTapped(_ sender:Any){
        let nvc = UIStoryboard(name:"Main",bundle: Bundle.main).instantiateInitialViewController() as! UINavigationController
        present(nvc,animated: true,completion: nil)
    }
    
    @objc func dismissButtonTapped(_ sender:Any){
        dismiss(animated: true,completion: nil)
    }
}

