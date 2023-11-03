//
//  ViewController.swift
//  API's Requests 30-10-23
//
//  Created by Omar barkat on 30/10/2023.
//

import UIKit
import Alamofire

struct comment: Decodable {
    var email : String
    var name : String
    var body : String
}
struct todo : Decodable {
    var id : Int
    var title : String
}

class ViewController: UIViewController  , UITableViewDataSource , UITableViewDelegate{

    @IBOutlet weak var CommentsTableView: UITableView!
    var arrComments: [comment] = []
    var arrTodos :[todo] = []
    override func viewDidLoad(){
        super.viewDidLoad()
        CommentsTableView.delegate = self
        CommentsTableView.dataSource = self

        AF.request("https://jsonplaceholder.typicode.com/comments").responseDecodable(of: [comment].self) { response in
            
            //let x = response.value
            guard let comments = response.value else{return}
            
            self.arrComments = comments
            print(self.arrComments[1])

            
        }
        AF.request("https://jsonplaceholder.typicode.com/todos").responseDecodable(of:[todo].self) { response in
            guard let todo = response.value else {return}
            self.arrTodos = todo
            self.CommentsTableView.reloadData()
        }
        let params = ["title" : "barkat"]
        AF.request("https://jsonplaceholder.typicode.com/todos", method: .post, parameters: params, encoder: JSONParameterEncoder.default).responseJSON { response in
            print(response.value)
        }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrTodos.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = CommentsTableView.dequeueReusableCell(withIdentifier: "mycell")!
        cell.textLabel?.text = arrTodos[indexPath.row].title
        return cell
    }

}

