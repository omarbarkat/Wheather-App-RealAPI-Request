//
//  ChangeCityVC.swift
//  API's Requests 30-10-23
//
//  Created by Omar barkat on 02/11/2023.
//

/*
 alex = 361058
 luxor = 360502
 asiut = 361478
 cairo = 360630
 */

import UIKit

class ChangeCityVC: UIViewController {
   
    
    var arrCities = [
        City(name: "cairo", id: "360630"),
        City(name: "alexandria", id: "361058"),
        City(name: "luxor", id: "360502"),
        City(name: "asiut", id: "361478"),

        
    ]
    var SelectedCity : City?
 
    
    @IBOutlet weak var btnSelectCity: UIButton!
    @IBOutlet weak var CitiesPickerView: UIPickerView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        CitiesPickerView.delegate = self
        CitiesPickerView.dataSource = self
        btnSelectCity.layer.cornerRadius = 15
    }
    @IBOutlet weak var ChangeCityPickerView: UIPickerView!
    @IBAction func btnSelectCity(_ sender: Any) {
        if let City = SelectedCity {
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "CityNameChanged"), object: nil, userInfo: ["City": City.self])
            dismiss(animated: true, completion: nil)
        }
    }
}
extension ChangeCityVC : UIPickerViewDelegate , UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return arrCities.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
      let  SelectedCity = arrCities[row].name
        print(SelectedCity)
        return SelectedCity
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        SelectedCity = arrCities[row]
    }
}


