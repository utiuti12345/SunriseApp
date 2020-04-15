//
//  ViewController.swift
//  SunriseApp
//
//  Created by saotome on 2020/04/15.
//  Copyright © 2020 saotome. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBOutlet weak var cityNameInput: UITextField!
    
    @IBOutlet weak var suriseTimeLabel: UILabel!
    @IBAction func findSunrise(_ sender: Any) {
        let url = "http://api.openweathermap.org/data/2.5/forecast?q=\(cityNameInput.text!)&appid=c12b7aa47f8707c2f43fb3c51f1e0ba9"
        getURL(url:url)
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
}

