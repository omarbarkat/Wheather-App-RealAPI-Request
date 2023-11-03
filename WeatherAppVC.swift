//
//  WeatherAppVC.swift
//  API's Requests 30-10-23
//
//  Created by Omar barkat on 31/10/2023.
//

import UIKit
import Alamofire
class WeatherAppVC: UIViewController {
    var cityID = "360630"
    @IBOutlet weak var loaderActivityIndecator: UIActivityIndicatorView!
    @IBOutlet weak var btnChangeCity: UIButton!
    @IBOutlet weak var lblCurrenCity: UILabel!
    @IBOutlet weak var lblhumidity: UILabel!
    @IBOutlet weak var lblpressurenum: UILabel!
    @IBOutlet weak var lblpressure: UILabel!
    @IBOutlet weak var lblTemp: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        btnChangeCity.layer.cornerRadius = 15
        NotificationCenter.default.addObserver(self, selector: #selector(CityChanged), name: NSNotification.Name(rawValue: "CityNameChanged"), object: nil)
        GetWeatherCityINFO()
    }
    func GetWeatherCityINFO() {
        let params = ["id":cityID, "appid":"e298833b6575646c6e5f94d15c4b98ff"]
        loaderActivityIndecator.isHidden = false
        loaderActivityIndecator.startAnimating()
        AF.request("https://api.openweathermap.org/data/2.5/weather", parameters: params, encoder: URLEncodedFormParameterEncoder.default).responseJSON { [self] response in
            if let result = response.value{
                let json = result as! NSDictionary
                let main = json["main"] as! NSDictionary
                var temp = main["temp"] as! Double
                var pressure = main["pressure"] as! Double
                var humidity = main["humidity"] as! Double
                var newtemp = temp - 272.15
                newtemp = Double(round(1000*newtemp) / 1000)
              print(temp)
                print(humidity)
                print(pressure)
             //   self.loaderActivityIndecator.stopAnimating()
             //   loaderActivityIndecator.hidesWhenStopped = true
                loaderActivityIndecator.isHidden = true
                self.lblTemp.text = "\(newtemp) Cْ"
                self.lblpressurenum.text = "\(pressure) bar"
                self.lblhumidity.text = "\(humidity)"
            }
        }
    }
    @objc func CityChanged (notification : Notification) {
        if let City = notification.userInfo!["City"] as? City {
            lblCurrenCity.text = City.name
            cityID = City.id
            GetWeatherCityINFO()
        }
    }
}
