//
//  campaniesAPI-VC.swift
//  API's Requests 30-10-23
//
//  Created by Omar barkat on 31/10/2023.
//

import UIKit
import Alamofire

struct Company : Decodable {
    var name : String
    var address : String
    var country : String
}

class campaniesAPI_VC: UIViewController , UITableViewDelegate , UITableViewDataSource {

 //   var arrCopanies : [Company]=[]
    @IBOutlet weak var tableView: UITableView!
    var arrCompanies: [Company]=[]
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        AF.request("https://json-placeholder.mock.beeceptor.com/companies").responseDecodable(of:[Company].self) { response in
           // let x = response.value
          guard let companies = response.value else {return}
            self.arrCompanies = companies
            self.tableView.reloadData()
            print(self.arrCompanies[3].country)
        }
        }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrCompanies.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "mycell")!
        cell.textLabel?.text = arrCompanies[indexPath.row].name
        return cell
    }
        }

    
    
    
    

    






